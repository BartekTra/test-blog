class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one_attached :user_prof_pic
  has_many :comments
  validates :email, presence: true
  after_commit :add_default_cover, on: [ :create ]


  private
  def add_default_cover
    unless user_prof_pic.attached?
      self.user_prof_pic.attach(io: File.open(Rails.root.join("app", "assets", "images", "default.jpg")), filename: "default.jpg", content_type: "image/jpg")
    end
  end

end
