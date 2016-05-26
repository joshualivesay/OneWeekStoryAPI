class User < ApplicationRecord
  has_many :user_awards, :dependent => :destroy
  has_many :user_stories, :dependent => :destroy
  has_many :awards, :through => :user_awards, :dependent => :destroy
  has_many :stories, :through => :user_stories, :dependent => :destroy

  attr_accessor :guest

  validates :email, {uniqueness: true, presence: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}}
  validates_presence_of :password
  validates_length_of :password, minimum: 6
  validates :username, {uniqueness: true, allow_blank: true}


end
