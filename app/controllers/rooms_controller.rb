class RoomsController < ApplicationController
  def index
    @new_room = Room.new
    @rooms = Room.all
  end

  def create
    @new_room = current_user&.rooms&.build

    if @new_room&.save
      @new_room.broadcast_append_to :rooms, partial: "rooms/room", locals: { room: @new_room }, target: "rooms"
    end
  end
end