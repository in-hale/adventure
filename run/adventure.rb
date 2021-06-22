#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../config/boot'

options = Commands::ParseCliOptions.new.call

Commands::HandleInitializationExceptions.call do
  start_scene = Commands::InitializeScenesFromFile.new(
    options[:file], template_variables: { name: options[:name] }
  ).call

  InteractiveStory.new(start_scene).run
end
