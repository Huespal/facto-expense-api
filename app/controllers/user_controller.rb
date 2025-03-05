class UserController < ApplicationController
  before_action :set_tenant

  # Sets a generic token key secret.
  TOKEN_KEY = "secret"

  # Defines the POST /login to allow users to authenticate.
  def login
    @user = User.find_by(username: params[:username], tenant_id: @tenant)
    if @user.present? && @user.password === params[:password]
      render json: { token: JWT.encode(@user.id, TOKEN_KEY) }
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  def set_tenant
    @tenant = request.headers["x-tenant-id"]
  end
end
