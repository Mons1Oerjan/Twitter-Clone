require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  test 'login with invalid information' do
    get login_path                           # visit the login path
    assert_template 'sessions/new'   # verify that the new sessions form renders properly
    post login_path, params: {               # post to the sessions path with an invalid params hash
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

end
