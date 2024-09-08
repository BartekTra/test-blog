FactoryBot.define do
  factory :comment do
    body { "This is an example comment." }
    association :user
    association :post


    after(:build) do |comment|
      comment.comment_image.attach(io: File.open(Rails.root.join('spec', 'support', 'assets', 'test_image.jpg')), filename: 'test_image.jpg', content_type: 'image/jpg')
    end
  end
end
