
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,:confirmable,
  :omniauthable, omniauth_providers: [:github, :google_oauth2  ]

  #  devise :database_authenticatable, :registerable,
  # :recoverable, :rememberable, :trackable, 
  # :validatable, authentication_keys: [:login]

  has_many :submissions, :dependent => :destroy
  extend FriendlyId
  friendly_id :username, use: :slugged
  include SimpleDiscussion::ForumUser
  has_many :comments, :dependent => :destroy
  has_many :blogs, :dependent => :destroy
  has_many :payment_histories, :dependent => :destroy
  acts_as_favoritor
  ratyrate_rater
  has_many :messages
  has_many :conversations, foreign_key: :sender_id
  mount_uploader :profile_picture, ImageUploader
  require 'uri'
  validate :check_valid_url
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users
  validates :username, format: { with:  /\A[a-z0-9_]{4,16}\z/}
  validates_uniqueness_of :username
  has_many :transactions
  attr_writer :login

  def login
    @login || self.username || self.email
  end
 

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end


  # validates :profile_picture, presence: true
  
  def name
    display_name
  end
  def current_admin
    current_user && current_user.admin
  end

  def check_all_link(link_name)
    uri  = self.send(link_name)
    if uri.present? and (uri =~ URI::regexp).blank?
      errors.add(:base, "Invalid #{link_name} ")
    end
  end

  # def validate_usr(username)
  #   username =~ /\A[a-z0-9_]{4,16}\z/
  # end
  
  # Check Valid Url For All Link If reuire to validate Another Attributes Just add elemnt in the array
  def check_valid_url
    ["faceboook_link",
      "instagram_link",
      "github_link",
      "linkedin_link"].each do |link_name|
        check_all_link(link_name)
      end
    end


    def self.create_from_provider_data(provider_data)
      puts provider_data.inspect
      where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
        user.email = provider_data.info.email
        user.password = Devise.friendly_token[0, 20]
        user.skip_confirmation!
      end
    end

    def self.from_github(provider_data)
      where(email: provider_data.info.email).first_or_create do | user |
        user.provider = provider_data.provider
        user.email = provider_data.info.email
        unless User.find_by(email: provider_data.info.email).present?
          user.password = Devise.friendly_token[0, 20]
        end
        user.skip_confirmation!
        user.save(validate: false )
      end
    end
  end
