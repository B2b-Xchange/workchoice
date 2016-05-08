require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:marco)
  end

  test "post interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # invalid submission
    assert_no_difference 'Post.count' do
      post posts_path, post: { title: "",
                               remarks: "" }
    end
    assert_select 'div#error_explanation'
    # valid submission
    title = "This is a test title"
    hourly_payment = 60
    assert_difference 'Post.count', 1 do
      post posts_path, post: { content_type: 1,
                               channel: 1,
                               billing_type: 1,
                               scope_hours: 50,
                               title: title,
                               remarks: "Remarks",
                               scope_of_work: "Scope of work",
                               scope_of_experience: "Ex goes h",
                               start_date: Time.zone.now,
                               end_date: Time.zone.now + 6.days,
                               hourly_payment: hourly_payment * 100,
                               currency: 1,
                               anonymous: 0 }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match title, response.body
    # Delete a post
    assert_select 'a', text: "delete"
    first_post = @user.posts.paginate(page: 1).first
    assert_difference 'Post.count', -1 do
      delete post_path(first_post)
    end
    # Visit a different user
    get user_path users(:jonathan)
    assert_select 'a', text: 'delete', count: 0
  end
  
end
