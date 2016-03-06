def sign_in!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
end

def sign_out!
    currently_signed_in.try(:reset_session_token)
    session[:session_token] = nil
end

def currently_signed_in
    return nil unless session[:session_token]
    @user = User.find_by(session_token: session[:session_token])
    puts @user.username
    @currently_signed_in ||= User.find_by(session_token: session[:session_token])
end


def is_signed_in?
    !!currently_signed_in
end