class Post < ApplicationRecord
  has_one_attached :post_image
  has_many :comments
  validates :title, presence: true
  validates :body, presence: true

  private
  def add_default_cover
    unless post_image.attached?
      self.post_image.attach(io: File.open(Rails.root.join("app", "assets", "images", "default.jpg")), filename: "default.jpg", content_type: "image/jpg")
    end
  end
end
