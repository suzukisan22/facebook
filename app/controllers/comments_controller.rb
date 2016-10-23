class CommentsController < ApplicationController
  #コメントを保存、投稿するためのアクションです。
  def create
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic

    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_path(@topic), notice: 'コメントの投稿に成功しました。'}
        format.js { render :index }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @topic = @comment.topic
    respond_to do |format|
      format.html { redirect_to topic_path(@topic) }
      format.js { render :edit }
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @topic = @comment.topic
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to topic_path(@topic), notice: 'コメントの更新に成功しました。'}
        format.js { render :index }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @comment = Comment.find(params[:id])
    @topic = @comment.topic

    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to topics_path(@topic), notice: 'コメントの削除に成功しました。'}
        format.js { render :index }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end
end
