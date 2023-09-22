class MessagesController < ApplicationController
  def create
    @new_message = current_user&.messages.build(strong_params)

    if @new_message&.save
      @new_message.broadcast_append_to @new_message.room, locals: { user: current_user }
    end
  end

  def like
    @message = Message.find(params[:id])

    like = @message.likes.find_by(user: current_user)

    if like.present?
      like.destroy
    else
      @message.likes.create(user: current_user)
    end

    @message.broadcast_replace_to(
      [current_user, @message.room], 
      target: "message_#{@message.id}_likes",
      partial: 'messages/heart',
      locals: { user: current_user, message: @message}
    )

    @message.broadcast_replace_to(
      @message.room, 
      target: "message_#{@message.id}_likes_count",
      locals: { message: @message},
      partial: 'messages/likes_count',
    )
  end

  private

  def strong_params
    params.require(:message).permit(:room_id, :body)
  end
end