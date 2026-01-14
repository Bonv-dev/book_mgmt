class Log < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :status, presence: true

  # book_id 毎に最も新しいIDのリスト
  scope :latest_list, -> {
    latest_ids = group(:book_id).maximum(:id).values
    where(id: latest_ids)
  }
end
