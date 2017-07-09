require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  def setup
    @full_title = 'Ruby on Rails Tutorial Sample App'
  end

  test 'full title helper' do
    assert_equal full_title, "#{@full_title}"
    assert_equal full_title('Help'), "Help | #{@full_title}"
  end

end