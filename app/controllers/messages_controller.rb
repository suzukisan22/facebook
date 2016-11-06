class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages

    # 10文字以上のメッセージがあるとき
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    if @messages.last
      if @messages.last.user_id != current_user.id
        #　もし最後のメッセージが相手のメールなら未読にする
        @messages.last.read = true
      end
    end

    @message = @conversation.messages.build

    # 他人の会話を見られないようにする
    if @conversation.sender_id != current_user.id && @conversation.recipient_id != current_user.id
      redirect_to authenticated_root_path, notice: '他人のメッセージを閲覧することはできません。'
    end
  end

  def create
    @message = @conversation.messages.build(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
end
