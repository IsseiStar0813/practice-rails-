module SessionsHelper
  
  # 渡されたユーザでログインする
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # ユーザーのセッションを永続的にする
  def remember(user)
    user.remember_db
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # 現在ログイン中のユーザを返す
  def current_user
    if session[:user_id]
      @current_user = User.find_by(id:session[:user_id])
    elsif
      cookies.signed[:user_id]
      user = User.find_by(id:cookies.signed[:user_id])
      if  user && user.authenticated?(cookies[:remember_token])
        log_in(user)
        @current_user = user
      end
    end
  end
  
  # ユーザーがログイン中かどうか確認
  def logged_in?
    !current_user.nil?
  end
  
  # ログアウトする
  def log_out 
    session.delete(:user_id)
  end
end
