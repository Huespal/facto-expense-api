class ExpenseController < ApplicationController
  # Obtains the expense by id before 'approve' and 'reject' actions.
  before_action :authenticate
  before_action :set_tenant
  before_action :set_expense, only: %i[ approve reject ]

  # Defines the GET /expense list endpoint filtered by status and/or date range.
  # Parameters checks is skipped in here for the sake of simplicity
  # but it should not in a production ready project.
  def index
    @status = params[:status]
    @from = params[:from]
    @to = params[:to]

    @expenses = Expense
      .where(tenant_id: @tenant)
      .by_status(@status)
      .by_date_range(@from, @to)

    # Maps the expenses to the expected view format (including camelCase).
    @output = @expenses.map { |expense| {
      id: expense.id,
      name: expense.name,
      type: expense.type,
      status: expense.status,
      accommodation: expense[:hotel_name] ? {
        hotelName: expense[:hotel_name],
        checkInDate: expense[:check_in_date],
        checkOutDate: expense[:check_out_date]
      } : nil,
      transportation: expense[:transportation_mode] ? {
        mode: expense[:transportation_mode],
        route: expense[:route]
      } : nil,
      mileage: expense.mileage,
      amount: expense.amount,
      createdAt: expense.created_at
    } }

    render json: @output
  end

  # Defines the POST /expense endpoint.
  # It sets the 'pending' status by default and
  # adapts model from request JSON body parameters.
  def create
    @expense = Expense.new(expense_params)
    @expense.tenant_id = @tenant
    @expense.status = "pending"
    @amount = params[:amount].to_f

    if params[:accommodation]
      @accommodation = params[:accommodation]
      @expense.hotel_name = @accommodation[:hotelName]
      @expense.check_in_date = @accommodation[:checkInDate]
      @expense.check_out_date = @accommodation[:checkOutDate]
    end

    if params[:transportation]
      @transportation = params[:transportation]
      @expense.transportation_mode = @transportation[:mode]
      @expense.route = @transportation[:route]
    end

    # For Mileage expense type, the amount is decided to
    # be 10 times the mileage quantity.
    if params[:mileage]
      @mileage = params[:mileage].to_f
      @amount = @mileage * 10
    end

    @expense.amount = @amount

    if @expense.save
      render json: { id: @expense.id() }, status: :created, location: @expense
    else
      render json: @expense.errors, status: :unprocessable_entity
    end
  end

  # Defines the PATCH /expense/:id/approve endpoint.
  # Modifies the expense's status to 'approved'.
  def approve
    @user = User.find_by(id: @userId, tenant_id: @tenant)
    if @user && @user.role === "admin" && @expense.update(status: "approved")
      render json: { id: @expense.id() }
    else
      render json: @expense.errors, status: :unprocessable_entity
    end
  end

  # Defines the PATCH /expense/:id/reject endpoint.
  # Modifies the expense's status to 'rejected'.
  def reject
    @user = User.find_by(id: @userId, tenant_id: @tenant)
    if @user && @user.role === "admin" && @expense.update(status: "rejected")
      render json: { id: @expense.id() }
    else
      render json: @expense.errors, status: :unprocessable_entity
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
          # This check is adding a query for each expense action
          # which seems to be expensive, so it may be improved.
          User.exists?(@userId)
        end
      end
    end
    def set_expense
      @expense = Expense.find(params[:id])
    end
    def set_tenant
      @tenant = request.headers["x-tenant-id"]
    end
    def expense_params
      params.expect(expense: [ :name, :type, :status ])
    end
end
