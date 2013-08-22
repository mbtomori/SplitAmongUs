require 'spec_helper'

describe "Inviting a user to a list", js: true do
  let!(:user) { create(:user, :with_list) }
  
  before do
    login_as(user)
  end
  
  it "lets the user invite someone to the list" do
    #visit dashboard
    visit root_path

    #click on list name
    within(".lists") do
      click_on(user.lists.last.name)
    end
    #click on invite user link
    click_on("Add A Friend")
    #fill in form
    fill_in("name", with: "Mike")
    fill_in("email", with: "mike@me.com")
    #click submit
    click_on("Send an invitation")
    #should see invited user's name on page
    within("#dashboard-lists") do
      page.should have_content("Mike")
    end
  end

  it "does not allow you to add someone who is already part of the list" do
    #visit dashboard
    visit root_path

    #click on list name
    within(".lists") do
      click_on(user.lists.last.name)
    end
    #click on invite user link
    click_on("Add A Friend")
    #fill in form
    fill_in("name", with: "Mike")
    fill_in("email", with: "mike@me.com")
    #click submit
    click_on("Send an invitation")
    #should see invited user's name on page
    within("#dashboard-lists") do
      page.should have_content("Mike")
    end
    within(".lists") do
      click_on(user.lists.last.name)
    end
    #click on invite user link
    click_on("Add A Friend")
    #fill in form
    fill_in("name", with: "Mike")
    fill_in("email", with: "mike@me.com")
    #click submit
    click_on("Send an invitation")
    #should see invited user's name on page
    within(".alert") do
      page.should have_content("is already part of this list")
    end
  end

    it "will not allow someone to invite a friend with empty fields" do
    #visit dashboard
    visit root_path

    #click on list name
    within(".lists") do
      click_on(user.lists.last.name)
    end
    #click on invite user link
    click_on("Add A Friend")
    #fill in form
    fill_in("name", with: nil)
    fill_in("email", with: nil)
    #click submit
    click_on("Send an invitation")
    #should see invited user's name on page
    within("#error_explanation") do
      page.should have_content("prohibited this user from being saved:")
    end
  end
end 