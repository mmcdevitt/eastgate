class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :assets, through: :brokers
  has_many :brokers
  has_many :visits
  has_many :track_downloads

  belongs_to :client

  # validates_format_of :username, with: /^[a-z0-9_]+$/, message: "must be lowercase alphanumerics only"
  validates_length_of :username, maximum: 32, message: "exceeds maximum of 32 characters"
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true

  scope :is_admin, ->      { where( admin: true ) }
  scope :regular_users, -> { where( admin: false ) }
  scope :investor, ->      { where(is_investor: true) }

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def initials
    "#{self.first_name[0]}#{self.last_name[0]}"
  end

  def broker?
    self.broker
  end

  def admin?
    self.admin
  end

  def not_admin?
    !self.admin?
  end

  def track_download(asset, document=nil, folder=true)
    tracker = TrackDownload.new(user_id: self.id, asset_id: asset.id, folder: folder, document_id: document)
    tracker.save
  end
end
