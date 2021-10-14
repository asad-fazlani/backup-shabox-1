class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.shadbox_notification.subject
  #
  def shadbox_notification(info)
    @greeting = "Hi"
    @info = info
    mail to: info.email, subject: info.title
  end

  def new_blog_create_notification(blog)
    @blog = blog
    User.all.each do |user|
      if user.subscribe == true
        @user = user.username
        mail to: user.email , subject: blog.title
      end
    end
  end

  def like_notification(current_user,blog)
    @user = current_user
    @blog = blog
    mail to: @blog.user.email , subject: "New Like notification"
  end

  def blog_comment_notification(comment,blog)
    @comment = comment
    @blog = blog
    @email = []
    if comment.commentable_type == "Blog"
      @email << @blog.user.email
    else 
      @email << @blog.user.email
      @email << comment.user.email
    end
    mail to: @email.uniq , subject: "New comment notification" 
  end
end