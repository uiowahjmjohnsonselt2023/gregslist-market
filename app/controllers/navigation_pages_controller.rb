class NavigationPagesController < ApplicationController
  def home
    @items = Item.joins(seller: :users)
  end

  def help; end

  def about; end

  def contact; end
end
