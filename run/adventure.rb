#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../config/boot'

options = { file: 'scenes.yml', name: 'Buddy' }
parser = OptionParser.new do |opts|
  opts.on('-f STR', '--file STR', String)
  opts.on('-n NAME', '--name NAME', String)
end
parser.parse!(into: options)

InitializationExceptionHandler.handle do
  start_scene = Commands::InitializeScenesFromFile.new(
    options[:file], template_variables: { name: options[:name] }
  ).call

  InteractiveStory.new(start_scene).run
end
