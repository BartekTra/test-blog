require 'rails_helper'

RSpec.describe Article, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user) }
  it { should have_one_attached(:image)}
  it { should have_many(:comments)}
  
end
