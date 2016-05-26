class StoryAward < ApplicationRecord
  belongs_to :story
  belongs_to :award
end
