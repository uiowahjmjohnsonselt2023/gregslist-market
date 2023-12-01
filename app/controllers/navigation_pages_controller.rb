class NavigationPagesController < ApplicationController
  def home
    @items = Item.all
  end

  def help; end

  def about; end

  def contact; end
end
