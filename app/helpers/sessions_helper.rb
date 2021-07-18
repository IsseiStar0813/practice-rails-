module SessionsHelper
  
  # 渡されたユーザでログインする
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # 現在ログイン中のユーザを返す
  def current_user
    if session[:user_id]
      User.find_by(id:session[:user_id])
    end
  end
end
