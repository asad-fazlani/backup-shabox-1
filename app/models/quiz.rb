class Quiz < ApplicationRecord
	has_many :questions, :dependent => :destroy
	has_many :quiz_categories
	has_many :submissions, :dependent => :destroy
  	has_many :categories, through: :quiz_categories
	validates :name, presence: true, length: {minimum: 3, maximum: 30}
    extend FriendlyId
    friendly_id :name, use: :slugged
    has_many :payment_histories, :dependent => :destroy
      ratyrate_rateable "questions", "answers"

end