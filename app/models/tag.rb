class Tag < ApplicationRecord
  has_many :taggings
  has_many :blogs, through: :taggings
end
