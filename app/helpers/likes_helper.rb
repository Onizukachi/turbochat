module LikesHelper
  def show_like(message)
    message.likes.find_by(user_id: message.user.id).present? ? "🧡" :  "🤍"
  end

  def show_like_count(message)
    " #{message.likes_count}" if message.likes_count.positive?
  end
end
