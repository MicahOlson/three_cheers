require 'pg'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require './lib/project'
require './lib/volunteer'
also_reload 'lib/**/*.rb'

DB = PG.connect({:dbname => 'volunteer_tracker'})

get '/' do
  redirect to('/projects')
end

get '/projects' do
  @projects = Project.all
  erb(:projects)
end

post '/projects' do
  title = params[:title].gsub(/'/, "''")
  project = Project.new({:title => title, :id => nil})
  project.save
  redirect to('/projects')
end

get '/projects/:id' do
  @project = Project.find(params[:id].to_i)
  erb(:project)
end

get '/projects/:id/edit' do
  @project = Project.find(params[:id].to_i)
  erb(:edit_project)
end

patch '/projects/:id' do
  @project = Project.find(params[:id].to_i)
  @project.update({:title => params[:title].gsub(/'/, "''")})
  erb(:project)
end

delete '/projects/:id' do
  @project = Project.find(params[:id].to_i)
  @project.delete
  redirect to('/projects')
end

get '/projects/:id/volunteers/:volunteer_id' do
  @volunteer = Volunteer.find(params[:volunteer_id].to_i)
  erb(:volunteer)
end

post '/projects/:id/volunteers' do
  @project = Project.find(params[:id].to_i)
  volunteer = Volunteer.new({:name => params[:name].gsub(/'/, "''"), :project_id => @project.id, :id => nil})
  volunteer.save
  erb(:project)
end

patch '/projects/:id/volunteers/:volunteer_id' do
  @project = Project.find(params[:id].to_i)
  volunteer = Volunteer.find(params[:volunteer_id].to_i)
  if volunteer.name == params[:name]
    volunteer.update({:name => params[:name].gsub(/'/, "''"), :project_id => 0})
  else
    volunteer.update({:name => params[:name].gsub(/'/, "''"), :project_id => @project.id})
  end
  erb(:project)
end

delete '/projects/:id/volunteers/:volunteer_id' do
  volunteer = Volunteer.find(params[:volunteer_id].to_i)
  volunteer.delete
  @project = Project.find(params[:id].to_i)
  erb(:project)
end

get '/volunteers' do
  @volunteers = Volunteer.all
  erb(:volunteers)
end

post '/volunteers' do
  name = params[:name].gsub(/'/, "''")
  volunteer = Volunteer.new({:name => name, :project_id => 'NULL', :id => nil})
  volunteer.save
  redirect to('/volunteers')
end

get '/volunteers/:id' do
  @volunteer = Volunteer.find(params[:id].to_i)
  erb(:volunteer)
end

get '/volunteers/:id/edit' do
  @volunteer = Volunteer.find(params[:id].to_i)
  erb(:edit_volunteer)
end

patch '/volunteers/:id' do
  @volunteer = Volunteer.find(params[:id].to_i)
  @volunteer.update({:name => params[:name].gsub(/'/, "''"), :project_id => @volunteer.project_id})
  erb(:volunteer)
end

delete '/volunteers/:id' do
  @volunteer = Volunteer.find(params[:id].to_i)
  @volunteer.delete
  redirect to('/volunteers')
end
