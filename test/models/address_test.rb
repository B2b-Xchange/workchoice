require 'test_helper'

class AddressTest < ActiveSupport::TestCase

  def setup
    @user = users(:marco)
    @address = @user.addresses.build(company: "Acme llc", street_name: "Friedrichstr.",
                                     street_no: "11", zip: "19055",
                                     city: "Schwerin", phone: "016377283333",
                                     email: "test@acmetest.com", contact_person: "Mr. Acme",
                                     vat_no: "DE12345678", country_iso_code: "DE",
                                     website: "acme.com", state: nil,
                                     headcount: 1, scope_of_experience: "Not much now.",
                                     scope_of_work: "Not much though.", display: true)
  end

  test "should be valid" do
    assert @address.valid?
  end

  test "user id should be present" do
    @address.user_id = nil
    assert_not @address.valid?
  end

  test "company and country iso code should be present" do
    @address.company = "      "
    assert_not @address.valid?
    @address.company = "test"
    @address.country_iso_code = "  "
    assert_not @address.valid?
  end

  test "string fields should be at most 255 character" do
    @address.company = "a" * 256
    assert_not @address.valid?
    @address.company = "a"

    @address.street_name = "a" * 256
    assert_not @address.valid?
    @address.street_name = "a"

    @address.street_no = "a" * 256
    assert_not @address.valid?
    @address.street_no = "a"

    @address.zip = "a" * 256
    assert_not @address.valid?
    @address.zip = "a"

    @address.city = "a" * 256
    assert_not @address.valid?
    @address.city = "a"

    @address.phone = "a" * 256
    assert_not @address.valid?
    @address.phone = "a"

    @address.email = "a" * 256
    assert_not @address.valid?
    @address.email = "et@test.ex"

    @address.contact_person = "a" * 256
    assert_not @address.valid?
    @address.contact_person = "a"

    @address.vat_no = "a" * 256
    assert_not @address.valid?
    @address.vat_no = "a"

    @address.website = "a" * 256
    assert_not @address.valid?
    @address.website = "a"

    @address.state = "a" * 256
    assert_not @address.valid?
    @address.state = "a"

    # test if I made an error
    assert @address.valid?
  end

  test "country iso code should be at most 2 character" do
    @address.country_iso_code = "aaa"
    assert_not @address.valid?
  end

  test "email validation should only accept valid email addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A-US-ER@foo.bar.org first.last@foo.jp alice+bob@bar.jp]
    valid_addresses.each do |valid_address|
      @address.email = valid_address
      assert @address.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email should reject any invalid email addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @address.email = invalid_address
      assert_not @address.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

end
