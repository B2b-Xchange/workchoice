require 'test_helper'

class AddressesControllerTest < ActionController::TestCase

  def setup
    @address = addresses(:one)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Address.count' do
      post :create, address: { contact_person: "Tester",
                               country_iso_code: "DE",
                               display: false }
    end

    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Address.count' do
      delete :destroy, id: @address
    end

    assert_redirected_to login_url
  end
    
end
