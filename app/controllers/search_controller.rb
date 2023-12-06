class SearchController < ApplicationController
  def index
    @results = Search.new(params[:q]).results
  end
end
