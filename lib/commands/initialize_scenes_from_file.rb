# frozen_string_literal: true

module Commands
  class InitializeScenesFromFile

    def initialize(file_path, template_variables: {})
      @file_path = file_path
      @template_variables = template_variables
      @evaluated_scenes = {}
    end

    def call
      parse_file
        .then(&method(:evaluate_scenes))
        .then(&method(:link_action_destinations))
        .then(&method(:validate_scenes))
        .then { |scenes| scenes[Models::Scene::START_SCENE_TAG] }
    end

    private

    attr_reader :file_path, :template_variables, :evaluated_scenes

    def parse_file
      YAML.safe_load(File.read(file_path), symbolize_names: true, fallback: {})
    end

    def evaluate_scenes(raw_scenes)
      evaluated = raw_scenes.to_h do |tag, scene_attributes|
        [tag, evaluate_scene(scene_attributes.merge(tag: tag))]
      end
      evaluated[Models::Scene::END_SCENE_TAG] ||= Models::Scene.new(tag: Models::Scene::END_SCENE_TAG)
      evaluated
    end

    def evaluate_scene(scene_attributes)
      Models::Scene.new(
        tag: scene_attributes[:tag],
        message: scene_attributes[:message] % template_variables,
        actions: scene_attributes[:actions].map { |action_attrs| evaluate_action(action_attrs) }
      )
    end

    def evaluate_action(attributes)
      Models::SceneAction.new(message: attributes[:message], destination_tag: attributes[:destination_tag])
    end

    def link_action_destinations(scenes)
      scenes.each_value do |scene|
        scene.actions.each do |action|
          action.destination = scenes.fetch(action.destination_tag.to_sym) do
            raise Errors::InvalidSceneReference, "#{action.destination_tag} scene not found"
          end
        end
      end
    end

    def validate_scenes(scenes)
      return scenes if Validators::StoryCompletable.new(scenes).valid?

      raise Errors::StoryNotCompletable
    end

  end
end
