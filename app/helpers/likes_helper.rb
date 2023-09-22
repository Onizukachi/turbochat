module LikesHelper
  def likes_count(message, user)
    str = message.likes.find_by(user_id: message.user.id).present? ? "🧡" :  "🤍"  # ?????
    str << " #{message.likes_count}" if message.likes_count.positive?

    str
  end
end
