# coding: utf-8
require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Sample user", email: "sample@void.com",
                     password: "häh muss lang sein", password_confirmation: "häh muss lang sein")
    
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should no be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "w" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should only accept valid email addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A-US-ER@foo.bar.org first.last@foo.jp alice+bob@bar.jp]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email should reject any invalid email addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be non blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
  test "associated posts should be destroyed" do
    @user.save
    @user.posts.create!(content_type: 1, channel: 1,
                        billing_type: 1, scope_hours: 100,
                        title: "teste", remarks: "tester",
                        scope_of_work: "tester",
                        scope_of_experience: "tester",
                        start_date: 60.minutes.ago,
                        end_date: Time.zone.now,
                        hourly_payment: 60, currency: 1,
                        anonymous: 1)
    assert_difference "Post.count", -1 do
      @user.destroy
    end
  end

  test "associated addresses should be destroyed" do
    @user.save
    @user.addresses.create!(email: "test@example.com",
                            company: "tester",
                            country_iso_code: "DE",
                            street_name: "tester",
                            street_no: "tester",
                            zip: "zip",
                            city: "city",
                            contact_person: "Hey you tiger")
    assert_difference "Address.count", -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    marco = users(:marco)
    jonathan = users(:jonathan)
    assert_not marco.following? jonathan
    marco.follow jonathan
    assert marco.following? jonathan
    assert jonathan.followers.include?(marco)
    marco.unfollow jonathan
    assert_not marco.following? jonathan
  end

  test "feed should have the right posts" do
    marco = users :marco
    jonathan = users :jonathan
    lana = users :lana
    # Posts from followed users
    lana.posts.each do |post_following|
      assert michael.feed.include?(post_following)
    end
    # Posts from self
    marco.posts.each do |post_self|
      assert marco.feed.include?(post_self)
    end
    # Posts from unfollowed user
    jonathan.posts.each do |post_unfollowed|
      assert_not marco.feed.include?(post_unfollowed)
    end
  end
    
end
