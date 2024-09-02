# frozen_string_literal: true

include Rails.application.routes.url_helpers

module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :title, String
    field :body, String
    field :user_id, Integer, null: false
    field :post_image_url, String, null: true
    field :comments, [ Types::CommentType ], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def post_image_url
      if object.post_image.attached?
        ("localhost:3000" + Rails.application.routes.url_helpers.rails_blob_url(object.post_image, only_path: true))
      end
    end
  end
end
