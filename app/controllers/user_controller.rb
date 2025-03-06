class UserController < ApplicationController
  before_action :set_tenant
  before_action :authenticate, only: %i[ show ]

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

  # Defines the GET /user to obtain user data.
  def show
    @user = User.find_by(id: params[:id], tenant_id: @tenant)
    if @user.present?
      render json: {
        id: @user.id,
        username: @user.username,
        role: @user.role
      }
    else
      render json: @user.errors, status: :not_found
    end
  end

  private
    def authenticate
      @message = { error: "Unauthorized" }.to_json
      authenticate_or_request_with_http_token("realm", @message) do |token, options|
        # The encoded token includes the user id.
        # There's a check that the user exists for the authorization to success.
        if token != nil
          @decodedToken = JWT.decode(token, UserController::TOKEN_KEY)
          @userId = @decodedToken[0]
          User.exists?(@userId)
        end
      end
    end
    def set_tenant
      @tenant = request.headers["x-tenant-id"]
    end
end
