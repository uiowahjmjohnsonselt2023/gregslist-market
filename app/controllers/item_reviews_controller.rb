class ItemReviewsController < ApplicationController
  def show
    @review = ItemReview.find(params[:id])
  end

  def new
    @review = ItemReview.new
    @user = current_user
    @item_id = params[:item_id]
  end

  def edit
    @review = ItemReview.find(params[:id].keys[0])
  end

  def update
    @review = ItemReview.find(params[:review][:id])
    if @review.update({ rating: params[:review][:rating], text: params[:review][:text] })
      flash[:notice] = 'Review updated'
    end
    redirect_to item_path
  end

  def create
    @review = ItemReview.new(item_review_params)
    @review.user_id ||= current_user
    if @review.save
      redirect_to @review
      puts 'SAVED'
    else
      puts 'NEW'
      render 'new'
    end
  end

  private

  def item_review_params
    params.require(:item_review).permit(:item_id, :user_id, :rating, :text)
  end
end
