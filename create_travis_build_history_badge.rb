require 'travis'
require_relative './spark_pr.rb'

repo_slug = ENV["TRAVIS_REPO_SLUG"]
exit if repo_slug.nil? || repo_slug.empty?

project_name = repo_slug.sub(/^.+\//, '')
img_filename = "TravisBuildHistory-#{project_name}.png"

spark_colors = {
  green:  SparkCanvas::GREEN,
  yellow: SparkCanvas::YELLOW,
  red:    SparkCanvas::RED,
}

data = []

project = Travis::Repository.find(repo_slug)
project.each_build do |build|
  data.push(build.duration => spark_colors[build.color])
end

if (!data.empty?)
  File.open(img_filename, "wb" ) do |png|
    png << Spark.plot(
      data,
      :type => "bar",
      :height => 20,
      :width => 100,
    )
  end
end
