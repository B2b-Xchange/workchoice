require 'test_helper'

class AddressesTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users :marco
  end

  test "address index display" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    get addresses_path
    assert_template 'addresses/index'
    assert_select 'title', full_title("All addresses")
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'

    assert_select 'div.pagination'
    @user.addresses.paginate(page: 1).each do |address|
      assert_match address.contact_person, response.body
      assert_match address.email, response.body
    end
    delete logout_path
    
  end

end
