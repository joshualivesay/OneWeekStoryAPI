class OneupsController < ApplicationController
  before_action :set_oneup, only: [:show, :update, :destroy]

  # GET /oneups
  def index
    if params[:story_id].present?
      @oneups = Story.find(params[:story_id]).oneups
    end

    render json: @oneups
  end

  # GET /oneups/1
  def show
    render json: @oneup
  end

  # POST /oneups
  def create
    if params[:story_id].present?
      @story = Story.find(params[:story_id])
    end
      @oneup = @story.oneups.new(user_id: @current_user.id)

      if @oneup.save
        render json: @oneup, status: :created, location: @oneup
      else
        render json: @oneup.errors, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /oneups/1
  def update
    if @oneup.update(oneup_params)
      render json: @oneup
    else
      render json: @oneup.errors, status: :unprocessable_entity
    end
  end

  # DELETE /oneups/1
  def destroy
    @oneup.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_oneup
      @oneup = Oneup.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def oneup_params
      params.require(:oneup).permit(:story_id)
    end
end
