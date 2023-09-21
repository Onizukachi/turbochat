module LikesHelper
  def likes_count(message)
    str = message.likes.find_by(user_id: current_user.id).present? ? "🧡" :  "🤍"
    str << " #{message.likes_count}" if message.likes_count.positive?

    str
  end
end
