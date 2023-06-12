class ReviewsController < ApplicationController
  before_action :set_session, only: %i[new create]

  def new
    @review = Review.new
    if @session.participant_one_id == current_user.id
      @user = @session.participant_two
    else
      @user = @session.participant_one
    end
  end

  def create
    @review = Review.new(review_params)
    @review.session = @session
    @review.user_id = current_user.id
    if @review.save
      # AJAX HERE to change button
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :user_id, :session_id)
  end

  def set_session
    @session = Session.find(params[:session_id])
  end
end
