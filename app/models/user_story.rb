class UserStory < ApplicationRecord
  belongs_to :user
  belongs_to :story, :dependent => :destroy

  validates :user_id, uniqueness: { scope: :story_id }

  def self.randomize_order(story_id = null)
    @users = UserStory.where({story_id: story_id, owner: false}).order('random()')
    order = 1
    @users.each do |user|
      order += 1 #Inital will be 2
      user.order = order
      user.save
    end
  end

end
