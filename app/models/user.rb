class User
  include Mongoid::Document
  extend Enumerize

  ROLES       = [:user, :moderator, :admin].freeze
  SEX_OPTIONS = [:male, :female].freeze

  mount_uploader :avatar, AvatarUploader
  attr_accessor :avatar_cache
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  field :avatar,                  type: String, default: ''
  field :login_name,              type: String
  field :first_name,              type: String
  field :last_name,               type: String
  field :email,                   type: String, default: ""
  field :encrypted_password,      type: String, default: ""
  field :reset_password_token,    type: String
  field :reset_password_sent_at,  type: Time
  field :remember_created_at,     type: Time
  field :sign_in_count,           type: Integer, default: 0
  field :current_sign_in_at,      type: Time
  field :last_sign_in_at,         type: Time
  field :current_sign_in_ip,      type: String
  field :last_sign_in_ip,         type: String
  field :confirmation_token,      type: String
  field :confirmed_at,            type: Time
  field :confirmation_sent_at,    type: Time
  field :unconfirmed_email,       type: String # Only if using reconfirmable

  field :sex
  field :role
  field :birthday,                type: Time

  enumerize :sex, in: SEX_OPTIONS
  enumerize :role, in: ROLES, default: :user

  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable


  # Methods
  def full_name
    [first_name, last_name].compact.join(' ')
  end
end
