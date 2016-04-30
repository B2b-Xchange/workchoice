require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @user = users(:marco)
    @post = @user.posts.build(content_type: 1, channel: 1,
                              billing_type: 1, scope_hours: 2,
                              title: "title", remarks: "remarks",
                              scope_of_work: "Scope of work",
                              scope_of_experience: "Experience",
                              start_date: Time.zone.now,
                              end_date: Time.zone.now.advance(weeks: 1),
                              hourly_payment: 20, currency: 1,
                              anonymous: 0)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "scope in hours should be present" do
    @post.scope_hours = 0
    assert_not @post.valid?
  end

  test "content type should have only 2 possibile values" do
    @post.content_type = 1
    assert @post.valid?
    @post.content_type = 3
    assert_not @post.valid?
  end

  test "channel should have only 1 possible value" do
    @post.channel = 1
    assert @post.valid?
    @post.channel = 2
    assert_not @post.valid?
  end

  test "billing type should have only 2 possible value" do
    @post.billing_type = 1
    assert @post.valid?
    @post.billing_type = 2
    assert_not @post.valid?
  end

  test "scope in hours should be less then a month" do
    @post.scope_hours = 1
    assert @post.valid?
    @post.scope_hours = 161
    assert_not @post.valid?
  end

  test "title shold be at most 1000 character" do
    @post.title = "a"
    assert @post.valid?
    @post.title = "a" * 1001
    assert_not @post.valid?
  end

  test "remarks should be at most 2000 character" do
    @post.remarks = "a"
    assert @post.valid?
    @post.remarks = "a" * 2001
    assert_not @post.valid?
  end

  test "scope of work should be at most 2000 character" do
    @post.scope_of_work = "a"
    assert @post.valid?
    @post.scope_of_work = "a" * 2001
    assert_not @post.valid?
  end

  test "scope of experience should be at most 2000 character" do
    @post.scope_of_experience = "a"
    assert @post.valid?
    @post.scope_of_experience = "a" * 2001
    assert_not @post.valid?
  end

  #test "start date should be after now" do
  #  @post.start_date = Time.zone.now.advance days: 1
  #  assert @post.valid?
  #  @post.start_date = Time.zone.now.ago 1000
  #  assert_not @post.valid?
  #end

  #test "end date should be after start date" do
  #  @post.end_date = @post.start_date.advance days: 1
  #  assert @post.valid?
  #  @post.start_date = Time.zone.now
  #  @post.end_date = @post.start_date.ago 1000
  #  assert_not @post.valid?
  #end

  test "currency should have 2 values" do
    @post.currency = 1
    assert @post.valid?
    @post.currency = 3
    assert_not @post.valid?
  end

  test "order should be most recent first" do
    assert_equal posts(:four), Post.first
  end
  
end
