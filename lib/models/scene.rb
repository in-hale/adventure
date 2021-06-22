# frozen_string_literal: true

module Models
  class Scene

    START_SCENE_TAG = :_start
    END_SCENE_TAG = :_exit
    INVALID_ACTION_ERROR_MESSAGE = 'Invalid action selected, you better hurry!'

    attr_reader :tag, :message, :actions

    def self.end_scene
      new(tag: END_SCENE_TAG)
    end

    def initialize(tag:, message: nil, actions: [])
      @tag = tag
      @message = message
      @actions = actions
    end

    def select_action(action_tag)
      actions.fetch(action_tag) do
        raise Errors::InvalidActionSelected, Models::Scene::INVALID_ACTION_ERROR_MESSAGE
      end
    end

    def end?
      tag.eql?(END_SCENE_TAG)
    end

  end
end
