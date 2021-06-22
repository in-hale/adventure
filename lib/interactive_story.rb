# frozen_string_literal: true

class InteractiveStory

  def initialize(start_scene, io_adapter: Adapters::Console.new, scene_decorator: Decorators::Scene)
    @start_scene = start_scene
    @io_adapter = io_adapter
    @scene_decorator = scene_decorator
  end

  def run
    current_decorated_scene = decorate_scene(start_scene)

    loop do
      io_adapter.clear
      io_adapter.println(current_decorated_scene.message)
      io_adapter.println(current_decorated_scene.actions_string)

      select_action(current_decorated_scene).then do |action|
        current_decorated_scene = decorate_scene(action.destination)
      end

      break if current_decorated_scene.end?
    end
  end

  private

  attr_reader :start_scene, :io_adapter, :scene_decorator

  def select_action(decorated_scene)
    loop do
      input_action = io_adapter.readline(decorated_scene.action_input_prefix)
      break decorated_scene.select_action(input_action)
    rescue Errors::InvalidActionSelected => e
      io_adapter.println(e.message)
    end
  end

  def decorate_scene(scene)
    scene_decorator.new(scene)
  end

end
