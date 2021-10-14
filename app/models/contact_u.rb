class ContactU < ApplicationRecord
  validates :name, :email, :subject, presence: true

end
