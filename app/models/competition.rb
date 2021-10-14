class Competition < ApplicationRecord
  has_many :transactions

  enum status:{published: 1, unpublished: 2, not_set: 3}
  enum competition_type:{Likes: 'Likes', Views:'Views', Comments: 'Comments'}

end
