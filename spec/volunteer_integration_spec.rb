require "capybara/rspec"
require "pry"
require "./app"
require 'spec_helper'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

# The user should be able to visit the home page and fill out a form to add a new project. When that project is created, the application should direct them back to the homepage.

describe 'the project creation path', {:type => :feature} do
  it 'takes the user to the homepage where they can create a project' do
    visit '/'
    fill_in('title', :with => 'Teaching Kids to Code')
    click_button('Create Project')
    expect(page).to have_content('Teaching Kids to Code')
  end
end

# A user should be able to click on a project to see its detail. The detail page includes a form where the project can be updated. When the form is submitted, the user can be directed to either the home page or that project's detail page. (The test will work for either.)

describe 'the project update path', {:type => :feature} do
  it 'allows a user to change the name of the project' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    visit '/'
    click_link('Teaching Kids to Code')
    click_link('Edit Project')
    fill_in('title', :with => 'Teaching Ruby to Kids')
    click_button('Update Project')
    expect(page).to have_content('Teaching Ruby to Kids')
  end
end

# A user should be able to nagivate to a project's detail page and delete the project. The user will then be directed to the index page. The project should no longer be on the list of projects.

describe 'the project delete path', {:type => :feature} do
  it 'allows a user to delete a project' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    id = test_project.id
    visit "/projects/#{id}/edit"
    click_button('Delete Project')
    visit '/'
    expect(page).not_to have_content("Teaching Kids to Code")
  end
end

# The user should be able to click on a project detail page and see a list of all volunteers working on that project. The user should be able to click on a volunteer to see the volunteer's detail page.

describe 'the volunteer detail page path', {:type => :feature} do
  it 'shows a volunteer detail page' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    project_id = test_project.id.to_i
    test_volunteer = Volunteer.new({:name => 'Jasmine', :project_id => project_id, :id => nil})
    test_volunteer.save
    visit "/projects/#{project_id}"
    click_link('Jasmine')
    fill_in('name', :with => 'Jane')
    click_button('Update Volunteer')
    expect(page).to have_content('Jane')
  end
end

# A user should be able to nagivate to a project's detail page and add a volunteer. The user will stay on the project's detail page, where the volunteer should now be listed.

describe 'the volunteer creation path', {:type => :feature} do
  it 'allows a user to add a volunteer to a project' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    id = test_project.id
    visit "/projects/#{id}"
    fill_in('name', :with => 'Jasmine')
    click_button('Add Volunteer')
    expect(page).to have_content("Jasmine")
  end
end

# A user should be able to nagivate to a volunteer's detail page and delete the volunteer. The user will then be directed to the project's detail page. The volunteer should no longer be on the list of volunteers.

describe 'the volunteer delete path', {:type => :feature} do
  it 'allows a user to delete a volunteer' do
    test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
    test_project.save
    project_id = test_project.id.to_i
    test_volunteer = Volunteer.new({:name => 'Jasmine', :project_id => project_id, :id => nil})
    test_volunteer.save
    volunteer_id = test_volunteer.id.to_i
    visit "/projects/#{project_id}/volunteers/#{volunteer_id}"
    click_button('Delete Volunteer')
    visit "/projects/#{project_id}"
    expect(page).not_to have_content("Jasmine")
  end
end
