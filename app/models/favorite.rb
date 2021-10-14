# frozen_string_literal: true

class Favorite < ApplicationRecord
  extend ActsAsFavoritor::FavoriteScopes

  belongs_to :favoritable, polymorphic: true
  belongs_to :favoritor, polymorphic: true

  after_create_commit :create_transaction
  after_destroy_commit :update_transaction

  def create_transaction
    @blog = Blog.find_by_id(self.favoritable_id)
    @user = User.find_by_id(self.favoritor_id)
    @data = self
    debugger
    if @blog.competition_id.present?
      @competition = Competition.find_by_id(@blog.competition_id)
      @transaction = Transaction.where(competition_id: @blog.competition_id, user_id: @user.id)
      @total_amount =  @transaction.sum(:amount) rescue 0
      if @blog.status == 'publish' and @competition.limits > @total_amount 
        Transaction.create(amount: @competition.per_price ,competition_id: @blog.competition_id ,blog_id: @blog.id ,user_id: @blog.user_id ,favoritor_user: @user.id)
      end
    end
  end

  def update_transaction
    @blog = Blog.find_by_id(self.favoritable_id)
    @user = User.find_by_id(self.favoritor_id)
    @data = self
    if @blog.competition_id.present? && @blog.status == 'publish' 
      @competition = Competition.find_by_id(@blog.competition_id)
      Transaction.create(amount:-@competition.per_price ,competition_id: @blog.competition_id,blog_id:@blog.id,user_id: @blog.user_id,favoritor_user:@user.id)
    end
  end
  
  def block!
    update!(blocked: true)
  end
end
