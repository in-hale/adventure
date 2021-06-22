# frozen_string_literal: true

require 'open3'

describe 'System in integration' do
  it 'works as expected', :aggregate_failures do
    Open3.popen2('run/adventure.rb -f spec/fixtures/scenes_extended.yml -n John') do |i, o, process|
      expect_output(o, 'Hi John, are you ready for a creepy adventure?')
      expect_output(o, '  1. Yaaaaaay!!!')
      expect_output(o, '  2. Ugh, creepy?)) I think I forgot to feed my cat at home... bye :)')

      input(i, '3')
      expect_output(o, '> 3')
      expect_output(o, 'Invalid action selected, you better hurry!')

      input(i, '1')
      expect_output(o, '> 1')

      expect_output(o, 'You are facing two doors, which one do you choose?')
      expect_output(o, '  1. Spaceship door on the left')
      expect_output(o, '  2. Red door on the right')

      input(i, '1')
      expect_output(o, '> 1')

      expect_output(o, 'You have finished the adventure!')
      expect_output(o, '  1. Ok')

      input(i, '1')
      expect_output(o, '> 1')

      expect(process).not_to be(:alive)
    end
  end

  it 'has a --help section' do
    expect(`run/adventure.rb --help`).to eq(
      <<~TEXT
        In order to create your own story, you'll have to check the following points:
          - Have a .yml story file. See scenes.yml as an example
          - The file should have one start anchor tag (#{Models::Scene::START_SCENE_TAG})
          - The file should have at least one reference to the end tag (#{Models::Scene::END_SCENE_TAG})
          - Specify your custom file path in the options

        Usage: run/adventure.rb [options]
            -f, --file PATH                  Story file path. Default: scenes.yml
            -n, --name NAME                  Player name. Default: Buddy
            -h, --help                       Prints help message
      TEXT
    )
  end

  def expect_output(output, string)
    expect(output.gets).to include(string)
  end

  def input(input, string)
    input.puts(string)
  end
end
