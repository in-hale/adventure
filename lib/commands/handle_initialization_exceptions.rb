# frozen_string_literal: true

module Commands
  class HandleInitializationExceptions

    def self.call(io_adapter: Adapters::Console.new, &block)
      block.call
    rescue Errors::InvalidSceneReference => e
      io_adapter.println("Story file: Invalid scene referenced. #{e.message}")
    rescue Errors::StoryNotCompletable => _e
      io_adapter.println('Story file: Story not completable. Make sure it has anchor scenes and the end is reachable')
    rescue Errors::StoryFileNotFound => _e
      io_adapter.println('Story file: Not found. Make sure to specify an existing file')
    end

  end
end
