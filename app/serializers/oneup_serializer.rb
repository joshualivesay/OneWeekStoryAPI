class OneupSerializer < ActiveModel::Serializer
  attributes :user
  has_one :user
end
