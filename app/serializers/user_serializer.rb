class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :points
  has_many :awards
end
