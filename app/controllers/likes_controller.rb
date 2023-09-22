class LikesController < ApplicationController
  def create
    message = Message.find_by(id: params[:message_id])
    user = message.user
    room = message.room
    @like = Like.new(user: user, message_id: params[:message_id])
    @like.save
  
    message.broadcast_replace_to room, locals: { message: message.reload }
    message.broadcast_replace_to [user, room], locals: { message: message.reload }
    
  end
end