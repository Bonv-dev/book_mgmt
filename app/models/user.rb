class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable

  def active_for_authentication?
    super && enabled?
  end

  has_many :logs, dependent: :restrict_with_error

  validates :enabled, inclusion: [ true, false ]
  validates :name, presence: true
  validates :is_admin, inclusion: [ true, false ]
  validates :is_librarian, inclusion: [ true, false ]
  # validates :encrypted_password, presence: true
  # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  include CommonScopes

  scope :librarians, -> { enabled_only.where(is_librarian: true).order(:id) }

  def can_manage?
    self&.is_admin? || self&.is_librarian?
  end

  def is_ippan?
    # 今は !can_manage? と同じだが、将来変わるかもしれないので分けておく。
    !self&.is_admin? && !self&.is_librarian?
  end
end
