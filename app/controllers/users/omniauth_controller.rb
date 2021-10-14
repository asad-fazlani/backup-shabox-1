class Users::OmniauthController < ApplicationController
# facebook callback
def facebook
  @user = User.create_from_provider_data(request.env['omniauth.auth'])
  if @user.persisted?
    sign_in_and_redirect @user
    # set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
  else
    flash[:error] = 'There was a problem signing you in through Facebook. Please register or try signing in later.'
    redirect_to new_user_registration_url
  end 
end


# github callback
def github
  @user = User.from_github(request.env['omniauth.auth'])
  if @user.persisted?
    sign_in_and_redirect @user
    if !@user.username.present?
      username = @user.email.split('@').first
      @user.update_attribute(:username ,username)

    # if @user.email.split('@')
      # @user.update_attribute(:username ,@user.email[0,4].gsub!(/[@]/,''))
    # else
        # @user.update_attribute(:username ,@user.email[0,4])
    # end
  end 
    # set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
    flash[:notice] = 'login successfully.'
  else
    redirect_to new_user_registration_url
  end
end

# google callback
def google_oauth2
  @user = User.create_from_provider_data(request.env['omniauth.auth'])
  if @user.persisted?
    sign_in_and_redirect @user
    set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
  else
    flash[:error] = 'There was a problem signing you in through Google. Please register or try signing in later.'
    redirect_to new_user_registration_url
  end 
end
def failure
  flash[:error] = 'There was a problem signing you in. Please register or try signing in later.' 
  redirect_to new_user_registration_url
end
end
