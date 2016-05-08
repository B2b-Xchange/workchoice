require 'test_helper'

class PostsControllerTest < ActionController::TestCase

  def setup
    @post = posts(:one)
  end

  test "should redirect when not logged in" do
    assert_no_difference 'Post.count' do
      post :create, post: {content_type: 1,
                           channel: 1,
                           billing_type: 1,
                           scope_hours: 50,
                           title: "Lotem ipsum",
                           remarks: "Lorem ipsum",
                           scope_of_work: "Lorem ipsum",
                           scope_of_experience: "Lorem iosum",
                           start_date: Time.zone.now,
                           end_date: Time.zone.now + 6.days,
                           hourly_payment: 6000,
                           currency: 1,
                           anonymous: true }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Post.count' do
      delete :destroy, id: @post
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong post" do
    log_in_as users(:marco)
    post = posts(:two)
    assert_no_difference 'Post.count' do
      delete :destroy, id: post
    end
    assert_redirected_to root_url
  end
  
end
