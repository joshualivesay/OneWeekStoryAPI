class Invitation < ApplicationRecord
  belongs_to    :story
  before_create :random_token
  before_create :user_is_not_already_included
  after_touch   :send_invitation
  after_destroy :trigger_start
  after_create  :send_invitation

  validates :email, uniqueness: { scope: :story }
  validates :email, :presence => true
  validate  :user_is_not_already_included

  private
  def random_token
    self.token = SecureRandom.urlsafe_base64
  end

  def send_invitation
    begin
      NotifyMailer.send_invitation(self).deliver
    rescue
      #skip this for now
    end
  end

  def trigger_start
    self.story.start_now if self.story.invitations.count == 0
  end

  def user_is_not_already_included
    if self.story.has_user(self.email)
      self.errors[:user] << 'is already a contributor'
    end
  end

end
