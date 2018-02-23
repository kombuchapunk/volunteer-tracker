#!/usr/bin/ruby

class Project
  attr_accessor :title
  attr_reader :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def ==(another_project)
    self.title().==(another_project.title())
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects_list = []
    returned_projects.each() do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i
      projects_list.push(Project.new({:title => title, :id => id}))
    end
    projects_list
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.find(id)
    found_project = nil
    Project.all().each() do |project|
      if project.id().==(id)
        found_project = project
      end
    end
    found_project
  end

  def update(attributes)
    @title = attributes.fetch(:title, @title)
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{self.id()};")
  end

end
