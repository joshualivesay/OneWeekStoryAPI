require 'auth_token'

class TokenController < ActionController::API
  def authenticate
    # You'll need to implement the below method. It should return the
    # user instance if the username and password are valid.
    # Otherwise return nil.
    if params[:email] == 'guest' && params[:password] == 'guest'
      user = User.new({email: params[:email], password: params[:password]})
      user.id = 1234567890
      user.guest = true
    else
      user = User.where({email: params[:email], password: params[:password]}).first
    end

    if user
      render json: authentication_payload(user)
    else
      render json: { errors: ['Invalid username or password'] }, status: :unauthorized
    end
  end

  private

  def authentication_payload(user)

    return nil unless user && user.id
    {
        token: AuthToken.encode({ user_id: user.id }),
        user: { id: user.id, email: user.email }
    }
  end
end