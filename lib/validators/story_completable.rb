# frozen_string_literal: true

module Validators
  class StoryCompletable

    def initialize(scenes_hash)
      @scenes_hash = scenes_hash
    end

    def valid?
      includes_anchor_scenes? && end_reachable?
    end

    private

    attr_reader :scenes_hash

    def includes_anchor_scenes?
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

        scene.actions.each { scenes_queue.push(_1.destination) unless visited[_1.destination.tag] }
      end

      false
    end

    def start_scene
      scenes_hash[Models::Scene::START_SCENE_TAG]
    end

  end
end
