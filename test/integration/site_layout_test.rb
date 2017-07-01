require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @href = "a[href=?]"
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "#{@href}", root_path, count: 2
    assert_select "#{@href}", help_path
    assert_select "#{@href}", about_path
    assert_select "#{@href}", contact_path

    get contact_path
    assert_select "title", full_title("Contact")
  end

end
