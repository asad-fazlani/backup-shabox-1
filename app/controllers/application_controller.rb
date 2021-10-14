class ApplicationController < ActionController::Base
	require 'will_paginate/array'
		# protect_from_forgery with: :null_session
		# skip_before_action :verify_authenticity_token
		# ,if: :devise_controller?
    before_action :configure_permitted_parameters, if: :devise_controller?


	def require_admin
		if !current_user.admin?
				flash[:alert] = "You must be logged in as admin to perform that action"
				redirect_to root_path
		end
	end

	def check_admin
	end
  protected
    def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:display_name, :username, :profile_picture, :description, :profession])
  # devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :display_name, :username, :profile_picture, :description, :profession,:faceboook_link,:instagram_link,:github_link,:linkedin_link) }
  # end
	private
  	def set_cache_headers
	    response.headers["Cache-Control"] = "no-cache, no-store"
	    response.headers["Pragma"] = "no-cache"
	    response.headers["Expires"] = "Mon, 01 Jan 1990 00:00:00 GMT"
  	end


	  

end
