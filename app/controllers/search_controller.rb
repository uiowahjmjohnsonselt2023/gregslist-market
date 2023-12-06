class SearchController < ApplicationController
  def index
    @results = Search.new(params[:q]).results
  end

  def search
    if params[:search].blank?
      redirect_to(root_path, alert: 'Empty field!') && return
    else
      @parameter = params[:search].downcase
      @results = Item.all.where('lower(name) OR lower(description) LIKE :search', search: "%#{@parameter}%")
      if @results.blank?
        redirect_to(root_path, alert: 'No items found with that name or description') && return
      end
    end
  end

  def search_results
    @results = Search.new(params[:q]).results
  end

  def search_params
    params.require(:search).permit(:q)
  end

  def show
    @item = Item.find(params[:id])
  end


end
