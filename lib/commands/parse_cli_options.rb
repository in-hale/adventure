# frozen_string_literal: true

module Commands
  class ParseCliOptions

    HELP_SECTION = <<~TEXT
      In order to create your own story, you'll have to check the following points:
        - Have a .yml story file. See scenes.yml as an example
        - The file should have one start anchor tag (#{Models::Scene::START_SCENE_TAG})
        - The file should have at least one reference to the end tag (#{Models::Scene::END_SCENE_TAG})
        - Specify your custom file path in the options

      Usage: run/adventure.rb [options]
    TEXT

    def initialize
      @options = { file: 'scenes.yml', name: 'Buddy' }
    end

    def call
      parse do |opts|
        opts.banner = HELP_SECTION

        opts.on('-f PATH', '--file PATH', "Story file path. Default: #{options[:file]}")
        opts.on('-n NAME', '--name NAME', "Player name. Default: #{options[:name]}")
        opts.on('-h', '--help', 'Prints help message') do
          puts opts
          exit
        end
      end
    end

    private

    attr_reader :options

    def parse(&block)
      parser = OptionParser.new(&block)
      parser.parse!(into: options)
      options
    end

  end
end
