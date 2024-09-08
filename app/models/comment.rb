class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one_attached :comment_image, dependent: :destroy
  validates :body, presence: true
  has_many :likes, as: :likeable, dependent: :destroy
end
