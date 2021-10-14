class Comment < ApplicationRecord
 belongs_to :commentable, polymorphic: true
 has_many :comments, as: :commentable
 belongs_to :user
 extend FriendlyId
 friendly_id :body, use: :slugged

 after_create_commit  :sendmail

 def sendmail
  @blog = Blog.find_by_id(self.blog_id)  
  UserMailer.blog_comment_notification(self, @blog).deliver_later!  
end
end
