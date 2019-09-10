class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
    ActionCable.server.broadcast "blogs_#{comment.blog.id}_channel", comment: render_comment()
  end

  private

  def render_comment
    CommentsController.render partial: comments/comment
  end
end
