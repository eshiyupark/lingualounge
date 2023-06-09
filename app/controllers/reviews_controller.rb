class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.save
  end

  private

  def review_params
    params.require(:review).permit(:rating)
  end
end
