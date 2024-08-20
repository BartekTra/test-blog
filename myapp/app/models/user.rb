class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :comments, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_one_attached :profilepicture
  after_commit :add_default_cover, on: [:create, :update]
  validates :email, presence: true

  private 
    def add_default_cover
      unless profilepicture.attached?
        self.profilepicture.attach(io: File.open(Rails.root.join("app", "assets", "images", "default_prof_pic.png")), filename: 'default_prof_pic.png' , content_type: "image/png")
      end
    end

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end
