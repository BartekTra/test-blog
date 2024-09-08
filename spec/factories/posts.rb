FactoryBot.define do
  factory :post do
    title { "Example Post Title" }
    body { "This is an example post body." }
    association :user


    after(:build) do |post|
      post.post_image.attach(io: File.open(Rails.root.join('spec', 'support', 'assets', 'test_image.jpg')), filename: 'test_image.jpg', content_type: 'image/jpg')
    end
  end
end
