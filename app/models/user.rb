class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :validatable

  def can_manage?
    self&.is_admin? || self&.is_librarian?
  end

  def is_ippan?
    # 今は !can_manage? と同じだが、将来変わるかもしれないので分けておく。
    !self&.is_admin? && !self&.is_librarian?
  end
end
