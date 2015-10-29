# == Schema Information
#
# Table name: users
#
#  id              :integer          primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  token           :string(255)
#  roles_mask      :integer
#

class User < ActiveRecord::Base
  include ActiveRecord::Transitions
  attr_accessible :name, :email, :password, :password_confirmation

  has_secure_password

  has_many :house_admins, foreign_key: 'user_id'
  has_many :houses, through: :house_admins
  has_many :expenditures

  has_many :expenditure_users, foreign_key: 'user_id'
  has_many :expenditures, through: :expenditure_users

  belongs_to :house

  scope :with_role, lambda{ |role| {conditions: "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }

  ROLES = %w[admin regular]

  before_save { |user| user.email = email.downcase }
  before_create :create_token

  state_machine do
    state :inactive
    state :active

    event :activate do
      transitions :to => :active, :from => :inactive
    end
  end


  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }, :if => :password_required?
  validates :password_confirmation, presence: true, :if => :password_required?
  after_validation { self.errors.messages.delete(:password_digest) }

  def house_admin!(house)
    house_admins.create!(house_id: house.id)
  end

  def password_required?
    # Validation required if this is a new record or the password is being
    # updated.
    self.new_record? || !self.password.nil?
  end

  def send_password_reset
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_sent_at = Time.zone.now
    save!# (validate: false)
    UserMailer.password_reset(self).deliver
  end

  def send_invitation(password)
    UserMailer.invitation(self, password).deliver
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  def self.find_home
  end
  private

  def create_token
    self.token = SecureRandom.urlsafe_base64
  end
end
