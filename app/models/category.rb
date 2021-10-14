class Category < ApplicationRecord
	has_many :quiz_categories
  	has_many :quizzes, through: :quiz_categories
	validates :name, presence: true, length: {minimum: 3, maximum: 20}, uniqueness: true
	extend FriendlyId
    friendly_id :name, use: :slugged
    
  has_one :blog
end