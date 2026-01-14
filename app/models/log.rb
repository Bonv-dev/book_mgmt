class Log < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :status, presence: true

  # book_id 毎に最も新しいIDのリスト
  scope :latest_list, -> {
    latest_ids = group(:book_id).maximum(:id).values
    where(id: latest_ids)
  }

  # 指定した book_id の最新ログ
  scope :latest, -> (book_id){ where(book_id: book_id).order(id: "DESC").first }
end
