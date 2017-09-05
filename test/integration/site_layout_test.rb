require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @href = 'a[href=?]'
    @user = users(:michael)
  end

  test 'layout links' do
    get root_path
    assert_template 'static_pages/home'
    assert_select "#{@href}", root_path, count: 2
    assert_select "#{@href}", help_path
    assert_select "#{@href}", login_path
    assert_select "#{@href}", signup_path
    assert_select "#{@href}", about_path
    assert_select "#{@href}", contact_path

    get contact_path
    assert_select 'title', full_title('Contact')
    assert_select "#{@href}", root_path, count: 2
    assert_select "#{@href}", help_path
    assert_select "#{@href}", login_path
    assert_select "#{@href}", about_path
    assert_select "#{@href}", contact_path

    get about_path
    assert_select 'title', full_title('About')
    assert_select "#{@href}", root_path, count: 2
    assert_select "#{@href}", help_path
    assert_select "#{@href}", login_path
    assert_select "#{@href}", about_path
    assert_select "#{@href}", contact_path

    get help_path
    assert_select 'title', full_title('Help')
    assert_select "#{@href}", root_path, count: 2
    assert_select "#{@href}", help_path
    assert_select "#{@href}", login_path
    assert_select "#{@href}", about_path
    assert_select "#{@href}", contact_path

    get login_path
    assert_select 'title', full_title('Log in')
    assert_select "#{@href}", root_path, count: 2
    assert_select "#{@href}", help_path
    assert_select "#{@href}", login_path
    assert_select "#{@href}", about_path
    assert_select "#{@href}", contact_path
    assert_select "#{@href}", signup_path

    # Test layout links for a logged in user:
    log_in_as(@user)
    get users_path
    assert_select 'title', full_title('All users')
    assert_select "#{@href}", root_path, count: 2
    assert_select "#{@href}", help_path
    assert_select "#{@href}", users_path
    assert_select "#{@href}", '#'
    assert_select "#{@href}", about_path
    assert_select "#{@href}", contact_path
  end
end
