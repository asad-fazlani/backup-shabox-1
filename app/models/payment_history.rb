class PaymentHistory < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
end
