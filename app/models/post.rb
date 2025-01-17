class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre

  has_many :post_comments, dependent: :destroy
end
