require "application_system_test_case"

class SignupsTest < ApplicationSystemTestCase
  setup do
    @signup = signups(:one)
  end

  test "visiting the index" do
    visit signups_url
    assert_selector "h1", text: "Signups"
  end

  test "creating a Signup" do
    visit signups_url
    click_on "New Signup"

    fill_in "Address", with: @signup.address
    fill_in "Address2", with: @signup.address2
    fill_in "City", with: @signup.city
    fill_in "Email", with: @signup.email
    fill_in "First name", with: @signup.first_name
    fill_in "Last name", with: @signup.last_name
    fill_in "Phone", with: @signup.phone
    fill_in "Photo", with: @signup.photo_id
    fill_in "Selfie", with: @signup.selfie
    fill_in "State", with: @signup.state
    fill_in "Zip", with: @signup.zip
    click_on "Create Signup"

    assert_text "Signup was successfully created"
    click_on "Back"
  end

  test "updating a Signup" do
    visit signups_url
    click_on "Edit", match: :first

    fill_in "Address", with: @signup.address
    fill_in "Address2", with: @signup.address2
    fill_in "City", with: @signup.city
    fill_in "Email", with: @signup.email
    fill_in "First name", with: @signup.first_name
    fill_in "Last name", with: @signup.last_name
    fill_in "Phone", with: @signup.phone
    fill_in "Photo", with: @signup.photo_id
    fill_in "Selfie", with: @signup.selfie
    fill_in "State", with: @signup.state
    fill_in "Zip", with: @signup.zip
    click_on "Update Signup"

    assert_text "Signup was successfully updated"
    click_on "Back"
  end

  test "destroying a Signup" do
    visit signups_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Signup was successfully destroyed"
  end
end
