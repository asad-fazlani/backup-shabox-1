class Question < ApplicationRecord
	belongs_to :quiz
	# validates :questions, presence: true, length: {minimum: 3, maximum: 60}
	validates :score, presence: true
	has_many :options, :dependent => :destroy
	accepts_nested_attributes_for :options
end