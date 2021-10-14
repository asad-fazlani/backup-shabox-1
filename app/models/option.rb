class Option < ApplicationRecord
	belongs_to :question
	# validates :opt_name, presence: true, length: {minimum: 2, maximum: 20}
end