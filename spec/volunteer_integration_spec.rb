require 'spec_helper'
require "capybara/rspec"
require "pry"
require "./app"

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

# The user should be able to visit the home page and fill out a form to add a new project. When that project is created, the application should direct them back to the homepage.

describe 'the project creation path', {:type => :feature} do
  it 'takes the user to the homepage where they can create a project' do
    visit '/'
    click_link('PROJECTS')
    click_link('Add a new project')
    fill_in('title', :with => 'Teaching Kids to Code')
    click_button('Create Project')
    expect(page).to have_content('Teaching Kids to Code')
  end
end
