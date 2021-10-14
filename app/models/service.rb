class Service < ApplicationRecord
	extend FriendlyId
	validates :image, presence: true
	mount_uploader :image, ImageUploader
	friendly_id :title, use: :slugged
	belongs_to :category
	
end
