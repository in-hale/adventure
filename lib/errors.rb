# frozen_string_literal: true

class Errors

  InvalidActionSelected = Class.new(StandardError)
  InvalidSceneReference = Class.new(StandardError)
  StoryNotCompletable = Class.new(StandardError)
  StoryFileNotFound = Class.new(StandardError)

end
