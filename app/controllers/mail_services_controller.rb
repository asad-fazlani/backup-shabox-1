class MailServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_mail_service, only: %i[ show edit update destroy ]

  # GET /mail_services or /mail_services.json
  def index
    @mail_services = MailService.all
  end

  # GET /mail_services/1 or /mail_services/1.json
  def show
  end

  # GET /mail_services/new
  def new
    @mail_service = MailService.new
  end

  # GET /mail_services/1/edit
  def edit
  end

  # POST /mail_services or /mail_services.json
  def create
    @mail_service = MailService.new(mail_service_params)

    respond_to do |format|
      if @mail_service.save
        UserMailer.shadbox_notification(@mail_service).deliver_now!
        format.html { redirect_to @mail_service, notice: "Mail service was successfully created." }
        format.json { render :show, status: :created, location: @mail_service }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mail_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mail_services/1 or /mail_services/1.json
  def update
    respond_to do |format|
      if @mail_service.update(mail_service_params)
        # UserMailer.shadbox_notification(@mail_service).deliver_now!
        format.html { redirect_to @mail_service, notice: "Mail service was successfully updated." }
        format.json { render :show, status: :ok, location: @mail_service }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mail_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_services/1 or /mail_services/1.json
  def destroy
    @mail_service.destroy
    respond_to do |format|
      format.html { redirect_to mail_services_url, notice: "Mail service was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail_service
      @mail_service = MailService.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mail_service_params
      params.require(:mail_service).permit(:title, :body, :email, :full_name)
    end
end
