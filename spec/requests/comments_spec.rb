require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let!(:user) { create(:user) }
  let!(:post) { create(:post) }
  let!(:valid_attributes) { { body: "Test comment", comment_image: nil } }
  let!(:invalid_attributes) { { body: "", comment_image: nil } }

  before { sign_in user }
  

  describe "POST /posts/:post_id/comments" do
    context "with valid parameters" do
      it "creates a new Comment" do
        expect {
          post "/posts/#{post.id}/comments", params: { comment: valid_attributes }
        }.to change(Comment, :count).by(1)
      end

      it "redirects to the post" do
        post "/posts/#{post.id}/comments", params: { comment: valid_attributes }
        expect(response).to redirect_to(post)
        expect(flash[:notice]).to eq("Komentarz został dodany.")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Comment" do
        expect {
          post "/posts/#{post.id}/comments", params: { comment: invalid_attributes }
        }.to change(Comment, :count).by(0)
      end

      it "redirects to the root path" do
        post "/posts/#{post.id}/comments", params: { comment: invalid_attributes }
        expect(response).to redirect_to(root_path)
      end

      it "logs error messages" do
        expect(Rails.logger).to receive(:debug).with(/Comment errors/)
        post "/posts/#{post.id}/comments", params: { comment: invalid_attributes }
      end
    end
  end
end
