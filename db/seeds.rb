# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'

def post_image_fetcher
  URI.open(Faker::LoremFlickr.image(size: "320x240"))
end

def user_prof_pic_fetcher
  URI.open(Faker::Avatar.image)
end

def comment_image_fetcher
  URI.open(Faker::LoremFlickr.image(size: "320x240", search_terms: [ 'dog', 'paris', 'girl' ]))
end

User.destroy_all
Post.destroy_all
Comment.destroy_all
Like.destroy_all

(1..20).each do |id|
  first_name = Faker::Name.first_name
  u = User.create!(id: id,
  email: "#{first_name}@test.com",
  password: "12qwaszx",
  password_confirmation: "12qwaszx",
    # user_prof_pic: Faker::LoremFlickr.image(size: "75x75")
  )
  u.user_prof_pic.attach({ io: user_prof_pic_fetcher, filename: "#{id}_faker_image.jpg" })
end

users = User.all

(1..50).each do |id|
  p = Post.create!(

   user: users.sample,
   title: Faker::Lorem.sentence(word_count: rand(1..4)),
   body: Faker::Lorem.sentence(word_count: rand(5..20)),
     # post_image: Faker::LoremFlickr.image(size: "225x225", search_terms: ['dog', 'cat', 'sports', 'fitness'])
   )
   p.post_image.attach({ io: post_image_fetcher, filename: "#{id}_faker_image.jpg" })

   rand(2..5).times do |id|
     c = Comment.create!(
      body: Faker::Lorem.sentence(word_count: rand(5..25)),
      post: p,
      user: users.sample
     )
     if rand(1..3) == 1
       c.comment_image.attach({ io: comment_image_fetcher, filename: "#{id}comment_faker_image.jpg" })
     end
   end
end
