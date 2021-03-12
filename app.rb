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
  erb(:projects)
end

get '/projects' do
  @projects = Project.all
  erb(:projects)
end

post '/projects' do
  title = params[:title].gsub(/'/, "''")
  project = Project.new({:title => title, :id => nil})
  project.save
  @projects = Project.all
  erb(:projects)
end

get('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  erb(:project)
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i)
  erb(:edit_project)
end

patch('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  @project.update({:title => params[:title].gsub(/'/, "''"), :id => nil})
  # @projects = Project.all
  erb(:project)
end
