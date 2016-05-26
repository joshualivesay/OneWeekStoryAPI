class StorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :start_time, :on_turn, :oneup

  has_many :story_users
  has_many :awards
end
