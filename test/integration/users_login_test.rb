require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)                  # michael is a fixture reference from users.yml
    @href = 'a[href=?]'
  end

  test 'login with invalid information' do
    get login_path                           # visit the login path
    assert_template 'sessions/new'   # verify that the new sessions form renders properly
    post login_path, params: {              # post to the sessions path with an invalid params hash
        session: {
            email: '',
            password: ''
        }
    }
    assert_template 'sessions/new'   # verify that the new sessions form gets re-rendered
    assert_not flash.empty?           # verify that a flash message appears
    get root_path                           # visit another page
    assert flash.empty?                # verify that the flash message doesn't appear on the new page
  end

  test 'login with valid information followed by logout' do
    get login_path
    post login_path, params: {
        session: {
            email: @user.email,
            password: 'password'
        }
    }
    assert is_logged_in?
    assert_redirected_to @user                 # check for the right redirect target
    follow_redirect!                           # visit the target page
    assert_template 'users/show'
    assert_select @href, login_path, count: 0  # verify that the login link disappears
    assert_select @href, logout_path
    assert_select @href, user_path(@user)

    # Logout:
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url

    # Simulate a user clicking logout in a second window:
    delete logout_path

    follow_redirect!
    assert_select @href, login_path
    assert_select @href, logout_path, count: 0
    assert_select @href, user_path(@user), count: 0
  end

end
