class Post < ApplicationRecord
  has_one_attached :post_image, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true
  belongs_to :user

  private
  def add_default_cover
    unless post_image.attached?
      self.post_image.attach(io: File.open(Rails.root.join("app", "assets", "images", "default.jpg")), filename: "default.jpg", content_type: "image/jpg")
    end
  end
end
