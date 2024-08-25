class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to @post, notice: "Komentarz został dodany."
    else
      Rails.logger.debug "Comment errors: #{@comment.errors.full_messages.join(", ")}"
      redirect_to root_path
    end
  end
  private
    def comment_params
      params.require(:comment).permit(:body, :comment_image)
    end
end
