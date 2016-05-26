class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:show, :update, :destroy]

  # GET /story/:story_id/invitations/
    # Invitations for Story
  # GET /invitations
  def index
    if params[:story_id].present?
      @invitations = Story.find(params[:story_id]).invitations
    else
      @invitations = Invitation.find_by_email(@current_user.email)
    end
    render json: @invitations
  end

  # GET /invitations/:token
  # Returns one invitation for the user we sent it to.
  def show
    render json: @invitation
  end

  # POST /stories/:story_id/invitations
  def create
    if params[:story_id].present?
      @story = Story.find(params[:story_id])
    end
    @invitation = @story.invitations.new(email:params[:email], text: params[:text])

    if @invitation.save
      render json: @invitation, status: :created, location: @invitation
    else
      render json: @invitation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /story/:story_id/invitations/:id
  def update
    if @current_user.email == @invitation.email
      #this is the user we invited.  Accept them.
      @story.story_users.new(user: @current_user, owner: false)
      @story.save
      @invitation.destroy
    else
      if @invitation.touch
        render json: @invitation
      else
        render json: @invitation.errors, status: :unprocessable_entity
      end
    end

  end

  # DELETE /invitations/:token
  #        /story/:story_id/invitations/:id
  def destroy
      @invitation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      if params[:story_id].present?
        @invitation = Invitation.find(params[:id])
        set_story
      else
        @invitation = Invitation.find_by_token(params[:id])
      end
    end

    def set_story
      @story = Story.find(params[:story_id])
    end
end
