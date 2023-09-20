require 'csv'

Movie.delete_all
ProductionCompany.delete_all
Page.delete_all

# Reset the auto-increment counter for the primary key (id)
# This step is specific to SQLite and may not work with other databases
# Replace 'your_models' with the actual name of your table
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='production_companies';")

# open top_movies.csv
filename = Rails.root.join('db/top_movies.csv')

puts "Loading Movies from the CSV file: #{filename}"

csv_data = File.read(filename)

movies = CSV.parse(csv_data, headers: true, encoding: 'utf-8')

movies.each do |m|
  production_company = ProductionCompany.find_or_create_by(name: m['production_company'])

  if production_company && production_company.valid?
    # create the movie
    movie = production_company.movies.create(
      title: m['original_title'],
      year: m['year'],
      duration: m['duration'],
      description: m['description'],
      average_vote: m['avg_vote']
    )
    puts "Invalid movie #{m['original_title']}" unless movie&.valid?

  else
    puts "invalid production company #{m['production_company']} for movie #{m['original_title']}"
  end
  puts m['original_title']
end

puts "Created #{ProductionCompany.count} Production Companies"
puts "Created #{Movie.count} Movies."

Page.create(
  title: 'About The Data',
  content: 'The data powering this website was provied by IMDB Kaggle dataset.',
  permalink: 'about_the_data'
)

Page.create(
  title: 'Contact us',
  content: 'If you like this website please reaach out to faker@notfaker.com',
  permalink: 'contact'
)
