class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one_attached :comment_image, dependent: :destroy
  validates :body, presence: true
end
