class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
        comment_params = params.require(:comment).permit(:description, :user_id, :picture_id)
        @comment = Comment.new(comment_params)

        respond_to do |format|
            if @comment.save
                format.html { redirect_to show_and_new_comment_picture_path(@comment.picture), notice: "Comentario creado correctamente." }
            else 
                format.html { redirect_to show_and_new_comment_picture_path(@comment.picture), alert: "Ha ocurrido un error." }
            end
        end
    end
end
