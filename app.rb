require 'pg'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require './lib/project'
require './lib/volunteer'
also_reload 'lib/**/*.rb'

DB = PG.connect({:dbname => 'volunteer_tracker'})

get '/' do
  @projects = Project.all
  erb(:home)
end

get '/projects' do
  @projects = Project.all
  erb(:projects)
end

get '/projects/new' do
  erb(:new_project)
end

post '/projects' do
  title = params[:title].gsub(/'/, "''")
  project = Project.new({:title => title, :id => nil})
  project.save
  @projects = Project.all
  erb(:projects)
end
