class Post < ApplicationRecord
  belongs_to :user
  belongs_to :story
  after_commit :increment_turn
  after_commit { PostRelayJob.perform_later(self) }

  def increment_turn
    self.story.increment_turn
  end
end
