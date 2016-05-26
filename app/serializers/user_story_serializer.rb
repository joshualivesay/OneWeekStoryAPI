class UserStorySerializer < ActiveModel::Serializer
  has_one :user, key: :fat_user
  attributes :owner, :order

  private

  def attributes
    hash = super
    hash.merge!({:id        => user.id,
                 :email     => user.email,
                 :username  => user.username,
                 :points    => user.points })
    hash
  end
end
