class Volunteer
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def name
    @name
  end

  def project_id
    @project_id
  end
end
