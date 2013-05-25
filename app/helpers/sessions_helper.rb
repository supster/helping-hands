module SessionsHelper

  def store_case
    if current_case.nil?
      # can't find the case in the UserCase table, se we have to create one
      current_case = UserCase.create()
      cookies.permanent[:case_token] = current_case.case_token
    end
  end

  def current_case=(user_case)
    @current_case = user_case
  end
  
  def current_case
    @current_case ||= UserCase.find_by_case_token(cookies[:case_token])
  end

  def sign_in(user)
    #sign the user in
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user                                    
  end

  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def signed_in?
    !current_user.nil? 
  end
  
  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end
  
  def redirect_back_or(default)
    return_to = session[:return_to]
    session.delete(:return_to)
    redirect_to(return_to || default)
  end
  
  def signed_in_user
    unless signed_in? 
      store_location
      flash[:notice] = "Please sign in."
      redirect_to signin_path      
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end  
  
  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
