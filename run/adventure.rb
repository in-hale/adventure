#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative '../config/boot'

# params = {}
# OptionParser.new do |opts|
#   opts.on("-f STR", "--file STR", String)
#   opts.on("-u", "--unique")
# end.parse!(into: params)

io_adapter = Adapters::Console.new

begin
  start_scene = Commands::InitializeScenesFromFile.new('scenes.yml', template_variables: { name: 'Yury' }).call
  InteractiveStory.new(start_scene).run
rescue Errors::InvalidSceneReference => e
  io_adapter.println("Story file: Invalid scene referenced. #{e.message}")
rescue Errors::StoryNotCompletable => _
  io_adapter.println(
    'Story file: Story not completable. Make sure it has anchor scenes and the end is reachable'
  )
end
