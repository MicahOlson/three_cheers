class Volunteer
  attr_reader :id
  attr_accessor :name, :project_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def ==(volunteer_to_compare)
    self.name == volunteer_to_compare.name
  end

  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers ORDER BY name;")
    volunteers = []
    returned_volunteers.each do |volunteer|
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id").to_i
      id = volunteer.fetch("id").to_i
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def save
    if DB.exec("SELECT * FROM volunteers WHERE name = '#{@name}';").first
      if @project_id != 'NULL'
        result = DB.exec("UPDATE volunteers SET project_id = #{@project_id} WHERE name = '#{@name}' RETURNING id;")
        @id = result.first.fetch("id").to_i
      end
    else
      result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
      @id = result.first.fetch("id").to_i
    end
  end

  def self.find(id)
    volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
    if volunteer
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id").to_i
      id = volunteer.fetch("id").to_i
      Volunteer.new({:name => name, :project_id => project_id, :id => id})
    else
      nil
    end
  end

  def self.find_by_project(proj_id)
    volunteers = []
    returned_volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{proj_id};")
    returned_volunteers.each do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i
      volunteers.push(Volunteer.new({:name => name, :project_id => proj_id, :id => id}))
    end
    volunteers
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    DB.exec("UPDATE volunteers SET name = '#{@name}', project_id = #{@project_id} WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
  end

  def remove
    DB.exec("UPDATE volunteers SET project_id = NULL WHERE id = #{@id};")
  end

  def project
    Project.find(@project_id)
  end
end
