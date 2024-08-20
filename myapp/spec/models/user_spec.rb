require 'rails_helper'

RSpec.describe User, type: :model do
  
  it { should have_one_attached(:profilepicture)}
  it { should have_many(:comments)}
  it { should have_many(:articles)}
  it { should validate_presence_of(:email) }
end
