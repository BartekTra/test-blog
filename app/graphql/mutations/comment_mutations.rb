# app/graphql/mutations/comment_mutations.rb
module Mutations
  module CommentMutations
    class CreateComment < GraphQL::Schema::Mutation
      argument :post_id, ID, required: true
      argument :body, String, required: true
      argument :user_id, ID, required: true

      type Types::CommentType

      def resolve(post_id:, body:, user_id:)
        post = Post.find(post_id)
        user = User.find(user_id)
        comment = post.comments.new(body: body, user: user)
        if comment.save
          comment
        else
          raise GraphQL::ExecutionError.new(comment.errors.full_messages.join(", "))
        end
      rescue ActiveRecord::RecordNotFound => e
        GraphQL::ExecutionError.new("Post or User not found: #{e.message}")
      end
    end

    class UpdateComment < GraphQL::Schema::Mutation
      argument :id, ID, required: true
      argument :body, String, required: false

      type Types::CommentType

      def resolve(id:, body: nil)
        comment = Comment.find(id)
        comment.body = body if body
        if comment.save
          comment
        else
          raise GraphQL::ExecutionError.new(comment.errors.full_messages.join(", "))
        end
      rescue ActiveRecord::RecordNotFound => e
        GraphQL::ExecutionError.new("Comment not found: #{e.message}")
      end
    end

    class DeleteComment < GraphQL::Schema::Mutation
      argument :id, ID, required: true

      type Boolean

      def resolve(id:)
        comment = Comment.find(id)
        comment.destroy
        true
      rescue ActiveRecord::RecordNotFound => e
        GraphQL::ExecutionError.new("Comment not found: #{e.message}")
      end
    end
  end
end
