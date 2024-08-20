class Article < ApplicationRecord
  has_one_attached :image
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true
  validates :user, presence: true
end