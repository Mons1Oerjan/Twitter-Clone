require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'

    # Update the user with invalid input params:
    patch user_path(@user), params: {
        user: {
            name: '',
            email: 'foo@invalid',
            password: 'foo',
            password_confirmation: 'bar'
        }
    }

    assert_template 'users/edit'
    assert_select 'div.alert', 'The form contains 4 errors.'
  end

  test 'successful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = 'Foo Bar'
    email = 'foo@bar.com'

    # Update the user with valid input params:
    patch user_path(@user), params: {
        user: {
            name:  name,
            email: email,
            password: '',
            password_confirmation: ''
        }
    }

    assert_not flash.empty?
    assert_redirected_to @user

    # Reload the user's values from the DB
    @user.reload

    assert_equal name,  @user.name
    assert_equal email, @user.email
  end

  # Tests that a user is redirected to their intended destination (friendly forwarding).
  test 'successful edit with friendly forwarding' do
    # TODO: make sure that friendly forwarding only forwards to the given URL the first time. On subsequent login attempts, the forwarding URL should revert to the default. Check for the right value of session[:forwarding_url]
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name = 'Foo Bar'
    email = 'foo@bar.com'
    patch user_path(@user), params: {
        user: {
            name: name,
            email: email,
            password: '',
            password_confirmation: ''
        }
    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end

end
