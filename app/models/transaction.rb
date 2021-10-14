class Transaction < ApplicationRecord
	  belongs_to :competition
	  belongs_to :blog
	  	  belongs_to :user


end
