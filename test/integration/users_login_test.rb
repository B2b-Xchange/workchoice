require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users :marco
    # omniauth setup
    OmniAuth.config.test_mode = true
    OmniAuth.config.on_failure = Proc.new { |env|
      OmniAuth::FailureEndpoint.new(env).redirect_to_failure }
    
  end
  
  test "Login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "Login with valid information" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "Login with valid information followed by logout" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second view
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
  
  test "login with remembering" do
    log_in_as @user, remember_me: '1'
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as @user, remember_me: '0'
    assert_nil cookies['remember_token']
  end


  # omniauth test
=begin
  test "valid login with facebook" do

    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({:provider => 'facebook',
                                                                   :uid => '12345',
                                                                   :info => {:name => 'John Doe',
                                                                             :email => 'john@doe.com',
                                                                             :first_name => 'John',
                                                                             :last_name => 'Doe' },
                                                                   :credentials => {:token => 'credentialtoken',
                                                                                    :expires_at => Time.now } })

    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    get '/auth/facebook'
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
  end

  test "invalid login with facebook" do
    OmniAuth.config.mock_auth[:facebook] = :user_abort
    get '/auth/facebook'
    assert_template 'sessions/new'
    assert_not flash.empty?
  end

  test "valid login with linkedin" do
    OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({:provider => 'linkedin',
                                                                   :uid => '12345',
                                                                   :info => {:name => 'John Doe',
                                                                             :email => 'john@doe.com',
                                                                             :first_name => 'John',
                                                                             :last_name => 'Doe' },
                                                                   :credentials => {:token => 'credentialtoken',
                                                                                   :expires_at => Time.now } })

    get root_path
    assert_select "a[href=?]", '/auth/linkedin', count: 1
    get '/auth/linkedin'
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
  end

  test "invalid login wiht linkedin" do
    OmniAuth.config.mock_auth[:linkedin] = :user_abort
    get '/auth/linkedin'
    assert_template 'sessions/new'
    assert_not flash.empty?
  end
=end
  
end
