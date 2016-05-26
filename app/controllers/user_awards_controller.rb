class UserAwardsController < ApplicationController
  before_action :set_user_award, only: [:show, :update, :destroy]

  # GET /user_awards
  def index
    @user_awards = UserAward.all

    render json: @user_awards
  end

  # GET /user_awards/1
  def show
    render json: @user_award
  end

  # POST /user_awards
  def create
    @user_award = UserAward.new(user_award_params)

    if @user_award.save
      render json: @user_award, status: :created, location: @user_award
    else
      render json: @user_award.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_awards/1
  def update
    if @user_award.update(user_award_params)
      render json: @user_award
    else
      render json: @user_award.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_awards/1
  def destroy
    @user_award.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_award
      @user_award = UserAward.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_award_params
      params.require(:user_award).permit(:user_id, :award_id)
    end
end
