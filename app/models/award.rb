class Award < ApplicationRecord
  has_many :story_awards
  has_many :user_awards
  has_many :users, :through => :user_awards
  has_many :stories, :through => :story_awards
end
