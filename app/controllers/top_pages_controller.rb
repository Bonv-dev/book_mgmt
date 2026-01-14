class TopPagesController < ApplicationController
  def index
    policy_scope :top_page  # モデルなしの場合
  end
end
