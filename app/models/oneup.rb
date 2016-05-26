class Oneup < ApplicationRecord
  belongs_to :story
  belongs_to :user

  validates :story, uniqueness: { scope: :user }
end
