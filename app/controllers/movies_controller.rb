class MoviesController < ApplicationController
  def index
    # @movies = Movie.all # this creates the N+1 problem; +1 refers to movies whereas N refers to production_companies,
    # in short this means we are reduntantly calling the database which can be expensive :)
    @movies = Movie.includes(:production_company).all.order('average_vote DESC')
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    @movies = Movie.where('title LIKE ?', wildcard_search)
  end
end
