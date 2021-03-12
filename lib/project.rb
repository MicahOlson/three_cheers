class Project
  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def title
    @title
  end

  def id
    @id
  end

  def ==(project_to_compare)
    self.title == project_to_compare.title
  end
end
