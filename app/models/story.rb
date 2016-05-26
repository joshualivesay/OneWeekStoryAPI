class Story < ApplicationRecord
  has_many :invitations, :dependent => :destroy
  has_many :oneups, :dependent => :destroy
  has_many :story_awards, :dependent => :destroy
  has_many :story_users, class_name: "UserStory", :dependent => :destroy
  has_many :awards, :through => :story_awards
  has_many :users, :through => :story_users
  has_many :posts, :dependent => :destroy

  attr_reader :oneup

  validates :title, :presence => true
  validates :description, :presence => true

  def oneup
    self.oneups.count
  end

  def start_now
    # We're ready to start the story.
    # email all guests that we're starting
    # Place alert in actioncable

    # if there is only 1 user set on_turn to 1
    if self.story_users.count == 1
      self.on_turn = 1
    end
    # set the story start date.
    self.start_time = DateTime.now
    # randomize users orders
    UserStory.randomize_order self.id

    # email all guests that we're starting
    self.users.each do |user|

      begin
        NotifyMailer.starting(self, user).deliver
      rescue

      end
    end

    self.save
  end

  def increment_turn
    unless self.on_turn.nil?
      next_turn = self.on_turn+1
      turns_in_round = self.users.count
      self.on_turn = (next_turn <= turns_in_round) ? next_turn : 1
    else
      # Manually set to two after the initial post
      # Because the story has not started and more users
      # will be invited.
      self.on_turn = 2
    end
    self.save
    send_turn_reminder
  end

  def has_user(email)
    self.users.where({email: email}).count > 0
  end

  def owner
    self.story_users.find_by_owner(true).user
  end

  def send_turn_reminder
    #What user gets emailed?
    user = self.story_users.where({order: self.on_turn}).first.user
    begin
      NotifyMailer.turn_reminder(self, user).deliver
    rescue
      #report an error
    end
  end
end
