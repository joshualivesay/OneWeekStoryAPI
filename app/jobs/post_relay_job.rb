class PostRelayJob < ApplicationJob
  def perform(post)
    ActionCable.server.broadcast "story:#{post.story.id}:posts", post: render_post(post)
  end

  private
  def render_post(post)
    post.to_json
  end
end
