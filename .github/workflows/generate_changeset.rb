#!/usr/bin/env ruby
# frozen_string_literal: true

def generate_changelogs(base_dir, head_dir)
  puts 'Generating OpenAPI changelogs for all releases...'

  for_each_release(base_dir) do |release_name|
    puts "Diffing release #{release_name}"

    diff = `docker run --rm \
      -v #{base_dir}:/base \
      -v #{head_dir}:/head \
      -t openapitools/openapi-diff:latest /base/#{release_name}/dereferenced/#{release_name}.deref.json /head/#{release_name}/dereferenced/#{release_name}.deref.json \
      --text /head/#{release_name}/dereferenced/#{release_name}.deref.changeset.txt`
    exit_code = $?.exitstatus

    if exit_code != 0
      puts "OpenAPI Diff for #{release_name} has failed"
      next
    end

    if diff.start_with?("No differences")
      puts "Release #{release_name} has no differences."
    else
      puts "Release #{release_name} has differences."
    end
  end
end

def for_each_release(description_folder)
  # Assumes a root directory with one folder per release
  Dir.glob(File.join(description_folder, "**")).map { |folder| File.basename(folder) }.each do |release|
    yield release
  end
end

base_dir = ARGV[0] #ex. '$PWD/schemas/base/descriptions'
head_dir = ARGV[1] #ex. '$PWD/schemas/head/descriptions'

generate_changelogs(base_dir, head_dir)
