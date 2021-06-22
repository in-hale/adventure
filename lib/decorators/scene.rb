# frozen_string_literal: true

module Decorators
  class Scene < SimpleDelegator

    ACTION_TAG_REGEX = /[1-9]\d*/.freeze

    def actions_string
      scene.actions.map.with_index do |action, index|
        "  #{index + 1}. #{action.message}"
      end.join("\n")
    end

    def select_action(action_tag)
      unless action_tag.match?(ACTION_TAG_REGEX)
        raise Errors::InvalidActionSelected, Models::Scene::INVALID_ACTION_ERROR_MESSAGE
      end

      optimized_action_tag = (action_tag.to_i - 1)
      scene.select_action(optimized_action_tag)
    end

    def action_input_prefix
      '> '
    end

    private

    def scene
      __getobj__
    end

  end
end
