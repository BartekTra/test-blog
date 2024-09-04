# app/graphql/mutations/user_mutations.rb
module Mutations
  module UserMutations
    class CreateUser < GraphQL::Schema::Mutation
      argument :email, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true

      type Types::UserType

      def resolve(email:, password:, password_confirmation:)
        user = User.new(email: email, password: password, password_confirmation: password_confirmation)
        if user.save
          user
        else
          raise GraphQL::ExecutionError.new(user.errors.full_messages.join(", "))
        end
      end
    end

    class UpdateUser < GraphQL::Schema::Mutation
      argument :id, ID, required: true
      argument :email, String, required: false
      argument :password, String, required: false
      argument :password_confirmation, String, required: false

      type Types::UserType

      def resolve(id:, email: nil, password: nil, password_confirmation: nil)
        user = User.find(id)
        user.email = email if email
        user.password = password if password
        user.password_confirmation = password_confirmation if password_confirmation

        if user.save
          user
        else
          raise GraphQL::ExecutionError.new(user.errors.full_messages.join(", "))
        end
      rescue ActiveRecord::RecordNotFound => e
        GraphQL::ExecutionError.new("User not found: #{e.message}")
      end
    end

    class DeleteUser < GraphQL::Schema::Mutation
      argument :id, ID, required: true

      type Boolean

      def resolve(id:)
        user = User.find(id)
        user.destroy
        true
      rescue ActiveRecord::RecordNotFound => e
        GraphQL::ExecutionError.new("User not found: #{e.message}")
      end
    end
  end
end
