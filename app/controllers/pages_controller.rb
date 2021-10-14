class PagesController < ApplicationController
  def index
  	redirect_to quizzes_path if logged_in?
  end

  def about
  end

  def faq
  end
end
