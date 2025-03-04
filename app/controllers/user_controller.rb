class UserController < ApplicationController
  before_action :set_tenant

  # Sets a generic token secret.
  TOKEN = "secret"

  # Defines the POST /login to allow users to authenticate.
  def login
    @user = User.find_by(username: params[:username], tenant_id: @tenant)
    if @user.present? && @user.password === params[:password]

      # This does not seem to be ok because the 'TOKEN' constant is getting
      # overwrited. It is done this way to try to share the token between
      # controllers, which it also seems to be totally incorrect.
      # The correct way may be to store this token data into the db.
      TOKEN.replace JWT.encode(@user.id, "secret")

      render json: { token: TOKEN }
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  def set_tenant
    @tenant = request.headers["x-tenant-id"]
  end
end
