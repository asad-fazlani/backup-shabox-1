class UsersController < ApplicationController
	require 'rubygems'
require 'twilio-ruby'

	before_action :authenticate_user!, except: [:new, :create,:index,:show,:followings,:followers]
	before_action :set_user, only: [:show, :edit, :destroy, :update]
	def index
		# response = Paytm::PaytmWalletTransfer.new( amount: 1,user_id: User.last.id, phone_number: "9579747075").transfer
		@users = User.order('created_at DESC').paginate(page: params[:page], per_page: 20) 
	end

	def update_payment
		
	end

	def new
		@user = User.new
	end

	def create
		if params[:user][:password]!=params[:user][:conf_password] #Check if passwords match
			flash[:danger] = "Passwords don't match"
			redirect_to signup_path
		else
			@user = User.new(user_params)
			if @user.save
				session[:user_id] = @user.id
				flash[:success] = "Welcome to the ShadBox Quiz App, #{@user.username}"
				redirect_to user_path(@user)
			else
				render 'new'
			end
		end
	end

	def edit
		if current_user!=@user
			flash[:danger]="You can only edit your own account"
			redirect_to root_path
		end
	end

	def update
		@user = User.find(params[:id])
		if current_user!=@user
			flash[:danger]="You can only edit your own account"
			redirect_to root_path
		end
		if params[:password].blank?
			params.delete(:password)
		end
		if @user.update(user_params)
			flash[:success] = "Your account was updated successfully"
			redirect_to quizzes_path
		else
			render 'edit'
		end
	end


	def show


# Find your Account SID and Auth Token at twilio.com/console
# and set the environment variables. See http://twil.io/secure
# account_sid = 'AC2e060f2890bf92b74078ce9191ecf68a'
# auth_token = 'a4ccffcb2f28872ea9fb99dd0efb6289'

# @client = Twilio::REST::Client.new(account_sid, auth_token)

# message = @client.messages.create(
#                              body: 'Hi there',
#                              from: '(334) 375-9481',
#                              to: '+917020145735'
#                            )

# puts message.sid
		@quizzes = Quiz.where(id: Submission.select(:quiz_id).where(user_id: @user.id))
		@submissions = Submission.where(user_id: @user.id)
		@blogs = @user.blogs.publish.order('created_at DESC').paginate(:page => params[:page])

		respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @blogs }
      format.js
    end
  end

  def editPassword
  end

  def updatePassword
  	user_pwd_change = current_user
  	if params[:user][:old_password].blank? || params[:user][:new_password].blank? || params[:user][:conf_password].blank?
  		flash[:danger] = "Enter all fields"
  		redirect_to editPassword_path
  	else
			if params[:user][:new_password]!=params[:user][:conf_password] #Check if passwords match
				flash[:danger] = "Passwords don't match"
				redirect_to editPassword_path
			elsif params[:user][:old_password]==params[:user][:new_password] #Check if new password is same as old password
				flash[:danger] = "New password cannot be same as old password"
				redirect_to editPassword_path
			elsif user_pwd_change.authenticate(params[:user][:old_password]) #Check if old password is correct
				user_pwd_change.password=params[:user][:new_password]
				if user_pwd_change.save
					flash[:success] = "Password was changed successfully"
					redirect_to user_path(user_pwd_change)
				else
					flash[:danger] = "Password cannot be blank"
					redirect_to editPassword_path
				end
			else
				flash[:danger] = "Wrong old password"
				redirect_to editPassword_path
			end
		end
	end

	def follow
		@user = User.friendly.find(params[:id])
		current_user.followees << @user
		redirect_back(fallback_location: user_path(@user))
	end

	def unfollow
		@user = User.friendly.find(params[:id])
		current_user.followed_users.find_by(followee_id: @user.id).destroy
		redirect_back(fallback_location: user_path(@user))
	end

	def followings
		@user = User.friendly.find(params[:id])
		@users = User.where(id: @user.followed_users.pluck(:followee_id))
	end

	def followers
		@user = User.friendly.find(params[:id])
		@users = User.where(id: Follow.where(followee_id: @user.id).pluck(:follower_id))
	end

	def earning
		@user = User.friendly.find(params[:id])
		@transactions = @user.transactions
		@grouped_messages = @transactions.group_by_day{ |t| t.created_at.to_date  }
		debugger
	end

	def verify_mobile
		@user = User.friendly.find(params[:id])
		@user.update(phone_number: params[:phone_number])	
	end

	
	def destroy
		# @user = User.find(params[:id])
		if !current_user.admin? && current_user!=@user #Only admins and user of the account can delete
			flash[:danger]="You can only delete your own account"
			redirect_to users_path
		elsif
			@user.destroy
			flash[:danger] = "User and all submissions by user have been deleted"
			redirect_to users_path
		end
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def set_user
		@user = User.friendly.find(params[:id])	
	end
end