class CommentsController < ApplicationController
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    @comment.user_id = current_user.id

    if current_user.nil?
      Rails.logger.debug "Current user is nil!"
    end

    if @comment.save
      redirect_to @article, notice: "Komentarz został dodany."
    else
      Rails.logger.debug "Comment errors: #{@comment.errors.full_messages.join(", ")}"
      redirect_to root_path
    end

  end

  private
    def comment_params
      params.require(:comment).permit( :body)
    end
end