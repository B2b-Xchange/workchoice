require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

  include ApplicationHelper

  def setup
    @user = users :marco
  end

  test "profile display" do
    get user_path @user
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.posts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.posts.paginate(page: 1).each do |post|
      assert_match post.title, response.body
      assert_match post.start_date.to_s(:long), response.body
      assert_match post.end_date.to_s(:long), response.body
      assert_match (post.hourly_payment / 100).to_s, response.body
    end
  end
  
end