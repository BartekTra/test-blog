# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # /api/users - lista wszystkich użytkowników
    field :users, [ Types::UserType ], null: false

    # /api/users/:id - szczegóły pojedynczego użytkownika
    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def users
      User.all
    end

    def user(id:)
      User.find(id)
    rescue ActiveRecord::RecordNotFound => e
      GraphQL::ExecutionError.new("User not found: #{e.message}")
    end

    # /api/posts - lista wszystkich postów
    field :posts, [ Types::PostType ], null: false

    # /api/posts/:id - szczegóły pojedynczego posta
    field :post, Types::PostType, null: false do
      argument :id, ID, required: true
    end

    def posts
      Post.all
    end

    def post(id:)
      Post.find(id)
    rescue ActiveRecord::RecordNotFound => e
      GraphQL::ExecutionError.new("Post not found: #{e.message}")
    end

    # /api/posts/:post_id/comments - lista komentarzy dla konkretnego posta
    field :comments, [ Types::CommentType ], null: false do
      argument :post_id, ID, required: true
    end

    def comments(post_id:)
      Post.find(post_id).comments
    rescue ActiveRecord::RecordNotFound => e
      GraphQL::ExecutionError.new("Post not found: #{e.message}")
    end
  end
end
