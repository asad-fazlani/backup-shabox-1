class PaymentRequestsController < ApplicationController
  before_action :set_payment_request, only: %i[ show edit update destroy ]

  # GET /payment_requests or /payment_requests.json
  def index
    @payment_requests = PaymentRequest.all
  end

  # GET /payment_requests/1 or /payment_requests/1.json
  def show
  end

  # GET /payment_requests/new
  def new
    @payment_request = PaymentRequest.new
  end

  # GET /payment_requests/1/edit
  def edit
  end

  # POST /payment_requests or /payment_requests.json
  def create
    @payment_request = PaymentRequest.new(payment_request_params)

    respond_to do |format|
      if @payment_request.save
        format.html { redirect_to @payment_request, notice: "Payment request was successfully created." }
        format.json { render :show, status: :created, location: @payment_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payment_requests/1 or /payment_requests/1.json
  def update
    respond_to do |format|
      if @payment_request.update(payment_request_params)
        format.html { redirect_to @payment_request, notice: "Payment request was successfully updated." }
        format.json { render :show, status: :ok, location: @payment_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_requests/1 or /payment_requests/1.json
  def destroy
    @payment_request.destroy
    respond_to do |format|
      format.html { redirect_to payment_requests_url, notice: "Payment request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_request
      @payment_request = PaymentRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_request_params
      params.require(:payment_request).permit(:user_id, :status, :comment)
    end
end
