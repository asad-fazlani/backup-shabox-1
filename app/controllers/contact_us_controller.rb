class ContactUsController < ApplicationController
  before_action :set_contact_u, only: %i[ show edit update destroy ]
  before_action :authenticate_user!,only: [:index, :show, :edit, :update, :destroy]
  before_action :require_admin, only: [:index, :show, :edit, :update, :destroy]
  # GET /contact_us or /contact_us.json
  def index
    @contact_us = ContactU.all
  end

  # GET /contact_us/1 or /contact_us/1.json
  def show
  end

  # GET /contact_us/new
  def new
    @contact_u = ContactU.new
  end

  # GET /contact_us/1/edit
  def edit
  end

  # POST /contact_us or /contact_us.json
  def create
    @contact_u = ContactU.new(contact_u_params)

    respond_to do |format|
      if @contact_u.save
        format.html { redirect_to root_path, notice: "We will connect you soon keep paitence." }
        format.json { render :show, status: :created, location: @contact_u }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact_u.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contact_us/1 or /contact_us/1.json
  def update
    respond_to do |format|
      if @contact_u.update(contact_u_params)
        format.html { redirect_to @contact_u, notice: "Contact u was successfully updated." }
        format.json { render :show, status: :ok, location: @contact_u }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact_u.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_us/1 or /contact_us/1.json
  def destroy
    @contact_u.destroy
    respond_to do |format|
      format.html { redirect_to contact_us_url, notice: "Contact u was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact_u
      @contact_u = ContactU.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_u_params
      params.require(:contact_u).permit(:email, :name, :subject, :body, :mobile_number)
    end
end
