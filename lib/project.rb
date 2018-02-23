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

end
