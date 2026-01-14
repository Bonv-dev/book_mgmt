class Log < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :status, presence: true
end
