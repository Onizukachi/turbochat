class LikesController < ApplicationController
  def create
    message = Message.find_by(id: params[:message_id])
    @like = Like.new(user_id: message.user.id, message_id: params[:message_id])

    @like.save
  
    Turbo::StreamsChannel.broadcast_replace_to message, partial: 'messages/message', target: message, locals: {message: message}
  end
end