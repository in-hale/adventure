# frozen_string_literal: true

module Validators
  class StoryCompletable

    def initialize(scenes_hash)
      @scenes_hash = scenes_hash
    end

    def valid?
      has_anchor_scenes? && end_reachable?
    end

    private

    attr_reader :scenes_hash

    def has_anchor_scenes?
      scenes_hash.key?(Models::Scene::START_SCENE_TAG) &&
        scenes_hash.key?(Models::Scene::END_SCENE_TAG)
    end

    def end_reachable?
      visited = {}
      scenes_queue = [start_scene]

      while scenes_queue.any?
        scene = scenes_queue.pop
        visited[scene.tag] = true
        return true if scene.end?

        scene.actions.each do |action|
          scenes_queue.push(action.destination) unless visited[action.destination.tag]
        end
      end

      false
    end

    def start_scene
      scenes_hash[Models::Scene::START_SCENE_TAG]
    end

  end
end
