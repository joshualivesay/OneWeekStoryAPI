class StoryChannel < ApplicationCable::Channel
  def follow(data)
    stop_all_streams
    stream_from "stories:#{data["storyid"]}:posts"
  end

  def unfollow
    stop_all_streams
  end
end
