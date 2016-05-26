class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :update, :destroy]
  before_action :validate_role, only: [:create, :update, :destroy]

  # GET /stories
  def index
    #filter by title
    if params[:user_id].present?
      stories = User.find(params[:user_id]).stories
    else
      stories = Story.all
    end

    if params[:title]
      stories = stories.where('lower(title) LIKE ?', '%' + params[:title].downcase + '%')
    end

    render json: stories
  end

  # GET /stories/1
  def show
    render json: @story
  end

  # POST /stories
  def create
    @story = Story.new(story_params)
    @story.users << @current_user

    if @story.save
      rel = @story.story_users.first
      rel.owner = true
      rel.order = 1
      rel.save
      render json: @story, status: :created, location: @story
    else
      render json: @story.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stories/1
  def update
    if @story.update(story_params)
      render json: @story
    else
      render json: @story.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stories/1
  def destroy
    @story.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def story_params
      params.require(:story).permit(:title, :description)
    end

    def validate_role
      if @current_user && @current_user.guest
        forbidden_resource
      end
    end
end
