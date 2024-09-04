# app/graphql/mutations/post_mutations.rb
module Mutations
  module PostMutations
    class CreatePost < GraphQL::Schema::Mutation
      argument :title, String, required: true
      argument :body, String, required: true
      argument :user_id, ID, required: true

      type Types::PostType

      def resolve(title:, body:, user_id:)
        user = User.find(user_id)
        post = user.posts.new(title: title, body: body)
        if post.save
          post
        else
          raise GraphQL::ExecutionError.new(post.errors.full_messages.join(", "))
        end
      rescue ActiveRecord::RecordNotFound => e
        GraphQL::ExecutionError.new("User not found: #{e.message}")
      end
    end

    class UpdatePost < GraphQL::Schema::Mutation
      argument :id, ID, required: true
      argument :title, String, required: false
      argument :body, String, required: false

      type Types::PostType

      def resolve(id:, title: nil, body: nil)
        post = Post.find(id)
        post.title = title if title
        post.body = body if body
        if post.save
          post
        else
          raise GraphQL::ExecutionError.new(post.errors.full_messages.join(", "))
        end
      rescue ActiveRecord::RecordNotFound => e
        GraphQL::ExecutionError.new("Post not found: #{e.message}")
      end
    end

    class DeletePost < GraphQL::Schema::Mutation
      argument :id, ID, required: true

      type Boolean

      def resolve(id:)
        post = Post.find(id)
        post.destroy
        true
      rescue ActiveRecord::RecordNotFound => e
        GraphQL::ExecutionError.new("Post not found: #{e.message}")
      end
    end
  end
end
