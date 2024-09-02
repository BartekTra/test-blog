# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject


    # Add root-level fields here.
    # They will be entry points for queries on your schema.

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
  end
end
