require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }

  before { sign_in user }

  describe 'GET #index' do
    it 'returns a success response' do
      get "/pl/posts"
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new post' do
        expect {
          post "/pl/posts", params: { post: { title: 'Valid title', body: 'Valid body' } }
        }.to change(Post, :count).by(1)
      end
    end
  end
end
