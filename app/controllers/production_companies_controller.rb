class ProductionCompaniesController < ApplicationController
  def index
    # all production companies
    # @production_companies = ProductionCompany.all

    # @production_companies = ProductionCompany.select('production_companies.*')
    #                                          .select('COUNT(production_companies.id) as movie_count')
    #                                          .left_joins(:movies)
    #                                          .group('production_companies.id')
    #                                          .order('movie_count DESC')

    @production_companies = ProductionCompany.ordered_by_movies
  end

  def show
    # a specific production company
    @production_company = ProductionCompany.find(params[:id])
  end
end
