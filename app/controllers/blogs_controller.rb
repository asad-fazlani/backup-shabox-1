class BlogsController < ApplicationController
  autocomplete :blog, :title, :full => true
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new,:create, :toggle_favorite, :draft]
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :toggle_favorite, :update_blog_status]
  before_action :require_admin, only: [:destroy, :draft]
  before_action :log_impression, :only=> [:show]
  before_action :set_paper_trail_whodunnit, :only => [:update]
  before_action :check_blog_owner , :only=> [:edit]
  # GET /blogs
  # GET /blogs.json
  def index
    if params[:search]
      @blogs = Blog.search_title("%#{params[:search]}%").order('title').paginate(page: params[:page], per_page: 12)
    else
      params[:tag] ? @blogs = Blog.where(status: 'publish').tagged_with(params[:tag]).order('created_at DESC').paginate(page: params[:page], per_page: 12) : @blogs = Blog.where(status: 'publish').order('created_at DESC').paginate(page: params[:page], per_page: 12)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
      format.js
    end
  end

  def my_blogs
    params[:tag] ? @blogs = current_user.blogs.tagged_with(params[:tag]).order('created_at DESC').paginate(page: params[:page], per_page: 6) : @blogs = current_user.blogs.all.order('created_at DESC').paginate(page: params[:page], per_page: 12)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
      format.js
    end
  end

  def users_show
    @blog = Blog.find_by_id(params[:blog])
    @users = User.where(id: @blog.favorited.pluck(:favoritor_id)).paginate(page: params[:page], per_page: 4)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.js
    end
    
  end

  # GET /blogs/1.order('created_at DESC').paginate(page: params[:page], per_page: 6) : @blogs = Blog.all.order('created_at DESC').paginate(page: params[:page], per_page: 6)
  # GET /blogs/1.json
  def show
    @comment = @blog.comments.build
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def update_blog_status
    if @blog.update(status: params[:status])
      if params[:status] == 'publish' and @blog.email_sent == false
        UserMailer.new_blog_create_notification(@blog).deliver_later!
        @blog.update(email_sent: true)
      end
      redirect_to @blog, notice: 'Blog was successfully updated.' 
    end
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    tag_ids = params[:blog][:tag_ids]
    params[:blog][:tag_ids] = []
    tag_ids.map do |data|
      next if data.empty? or 
      if data.to_i != 0
        params[:blog][:tag_ids] << data.to_i
      else  
       tag = Tag.where(name: data.strip).first_or_create! 
       params[:blog][:tag_ids] << tag.id
     end
   end
   @blog = Blog.new(blog_params)
   @blog.user_id = current_user.id
   respond_to do |format|
    unless current_user.admin?
      @blog.status = 'Draft'
    end
    if @blog.save
      format.html { redirect_to root_path, notice: 'Blog was successfully created.' }
      format.json { render :show, status: :created, location: @blog }
    else
      format.html { render :new }
      format.json { render json: @blog.errors, status: :unprocessable_entity }
    end
  end
end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      tag_ids = params[:blog][:tag_ids]
      params[:blog][:tag_ids] = []
      tag_ids.map do |data|
        next if data.empty? or 
        if data.to_i != 0
          params[:blog][:tag_ids] << data.to_i
        else  
         tag = Tag.where(name: data.strip).first_or_create! 
         params[:blog][:tag_ids] << tag.id
       end
     end
     if @blog.update(blog_params)

      format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
      format.json { render :show, status: :ok, location: @blog }
    else
      format.html { render :edit }
      format.json { render json: @blog.errors, status: :unprocessable_entity }
    end
  end
end

def toggle_favorite
  current_user.favorited?(@blog)  ? current_user.unfavorite(@blog) : current_user.favorite(@blog)
  if current_user.favorited?(@blog)
    UserMailer.like_notification(current_user,@blog).deliver_later!
  end
end

def draft
  @blogs = Blog.where.not(status: 'publish').paginate(page: params[:page])
end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:category_id,:image, :title, :content,:tag_list, :tag, { tag_ids: [] }, :tag_ids, :status,:competition_id)
    end

    def log_impression
      # this assumes you have a current_user method in your authentication system
      @blog.impressions.where(ip_address: request.remote_ip).first_or_create
    end
    def check_admin_blog
      if  !current_user.admin?
        flash[:alert] = "You must be logged in as admin to perform that action"
        redirect_to root_path
      end
    end
    def check_blog_owner
      status = (@blog.user_id == current_user.id or current_user.admin)
      unless status
        flash[:alert] = "Unauthorized action, Invalid Access Role."
        redirect_to root_path
      end
    end
  end
