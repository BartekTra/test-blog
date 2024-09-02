# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Mutacje związane z użytkownikami
    field :create_user, mutation: Mutations::UserMutations::CreateUser
    field :update_user, mutation: Mutations::UserMutations::UpdateUser
    field :delete_user, mutation: Mutations::UserMutations::DeleteUser

    # Mutacje związane z postami
    field :create_post, mutation: Mutations::PostMutations::CreatePost
    field :update_post, mutation: Mutations::PostMutations::UpdatePost
    field :delete_post, mutation: Mutations::PostMutations::DeletePost

    # Mutacje związane z komentarzami
    field :create_comment, mutation: Mutations::CommentMutations::CreateComment
    field :update_comment, mutation: Mutations::CommentMutations::UpdateComment
    field :delete_comment, mutation: Mutations::CommentMutations::DeleteComment
  end
end
