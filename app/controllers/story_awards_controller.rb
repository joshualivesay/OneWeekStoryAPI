class StoryAwardsController < ApplicationController
  before_action :set_story_award, only: [:show, :update, :destroy]

  # GET /story_awards
  def index
    @story_awards = StoryAward.all

    render json: @story_awards
  end

  # GET /story_awards/1
  def show
    render json: @story_award
  end

  # POST /story_awards
  def create
    @story_award = StoryAward.new(story_award_params)

    if @story_award.save
      render json: @story_award, status: :created, location: @story_award
    else
      render json: @story_award.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /story_awards/1
  def update
    if @story_award.update(story_award_params)
      render json: @story_award
    else
      render json: @story_award.errors, status: :unprocessable_entity
    end
  end

  # DELETE /story_awards/1
  def destroy
    @story_award.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story_award
      @story_award = StoryAward.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def story_award_params
      params.require(:story_award).permit(:story_id, :award_id)
    end
end
