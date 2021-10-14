
class Blog < ApplicationRecord
  # has_many :comments
  has_many :comments, as: :commentable
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :transactions

  belongs_to :category
  belongs_to :user

  extend FriendlyId
  has_many :impressions, :as=>:impressionable
  validates :image, presence: true
  mount_uploader :image, ImageUploader
  friendly_id :title, use: :slugged
  acts_as_favoritable
  ratyrate_rateable "blog_content", "presentation", "blogger"
  scope :search_title, -> (title) { where("title ilike ?", title)}
  validates :status, presence: true
  # STATUSES = [:draft, :published, :unpublished]
  scope :publish, -> {where(status: 'publish')}
  self.per_page = 9
  has_paper_trail

  # after_create_commit  :sendmail
  # def sendmail
  #   debugger
  #   @blog = self  
  #   UserMailer.new_blog_create_notification(self).deliver_later!  
  # end


  def self.tagged_with(name)
    Tag.find_by!(name: name).blogs
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def impression_count
    impressions.size
  end

  def unique_impression_count
    # impressions.group(:ip_address).size gives => {'127.0.0.1'=>9, '0.0.0.0'=>1}
    # so getting keys from the hash and calculating the number of keys
    impressions.group(:ip_address).size.keys.length #TESTED
  end
end
