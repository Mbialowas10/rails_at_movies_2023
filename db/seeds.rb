require 'csv'
Movie.delete_all
ProductionCompany.delete_all

# open top_movies.csv
filename = Rails.root.join('db/top_movies.csv')

puts "Loading Movies from the CSV file: #{filename}"

csv_data = File.read(filename)

movies = CSV.parse(csv_data, headers: true, encoding: 'utf-8')

movies.each do |m|
  production_company = ProductionCompany.find_or_create_by(name: m['production_company'])

  if production_company && production_company.valid?
    # create the movie
  else
    puts "invalid production company #{m['production_company']} for movie #{m['original_title']}"
  end
  puts m['original_title']
end

puts "Created #{ProductionCompany.count} Production Companies"
