require "application_system_test_case"

class AbcsTest < ApplicationSystemTestCase
  setup do
    @abc = abcs(:one)
  end

  test "visiting the index" do
    visit abcs_url
    assert_selector "h1", text: "Abcs"
  end

  test "creating a Abc" do
    visit abcs_url
    click_on "New Abc"

    click_on "Create Abc"

    assert_text "Abc was successfully created"
    click_on "Back"
  end

  test "updating a Abc" do
    visit abcs_url
    click_on "Edit", match: :first

    click_on "Update Abc"

    assert_text "Abc was successfully updated"
    click_on "Back"
  end

  test "destroying a Abc" do
    visit abcs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Abc was successfully destroyed"
  end
end
