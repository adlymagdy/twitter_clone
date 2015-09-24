module SessionsHelper
  
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # Remember a user in persistent session
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # Returns true if the current user is the given user
  def current_user?(user)
    user == current_user
  end
    
  # Returns the current logged-in user (if-any).
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  # Returns true if the user is logged in, false otherwise
  def logged_in?
    !current_user.nil?
  end
  
  # Forget method a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:user_id) # =  session[:user_id] = nil
    @current_user = nil
  end
  
  # Redirect to stored location or default
  def redirect_back_or(default)
    redirect_to(session[:forwading_url] || default)
    session.delete(:forwading_url)
  end
  
  # Stores the url trying to be accssed.
  def store_location
    session[:forwading_url] = request.url if request.get?
  end
end
