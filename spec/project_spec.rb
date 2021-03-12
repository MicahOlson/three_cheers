require 'spec_helper'

describe Project do
  describe '#title' do
    it 'returns the project title' do
      project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      expect(project.title).to eq 'Teaching Kids to Code'
    end
  end
  
  context '#id' do
    it 'returns the id of the project before saving project' do
      project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      expect(project.id).to eq nil
    end
  end
end
