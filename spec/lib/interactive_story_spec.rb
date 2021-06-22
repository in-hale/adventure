# frozen_string_literal: true

describe InteractiveStory do
  let(:test_io) do
    Class.new do
      attr_accessor :mixed_stream

      def initialize
        @mixed_stream = ''
      end

      def println(str)
        self.mixed_stream += "#{str}\n"
      end

      def readline(prefix)
        self.mixed_stream += "#{prefix}1\n"
        '1'
      end

      def clear
        self.mixed_stream += "[flush]\n"
      end
    end.new
  end

  let(:test_decorator) do
    Class.new(SimpleDelegator) do
      def actions_string
        __getobj__.actions.map(&:message).join("\n")
      end

      def select_action(tag)
        __getobj__.select_action(tag.to_i - 1)
      end

      def action_input_prefix
        '$ '
      end
    end
  end

  subject { described_class.new(start_scene, io_adapter: test_io, scene_decorator: test_decorator).run }

  let(:start_scene) do
    Models::Scene.new(
      tag: :_start,
      message: 'Start message',
      actions: [
        Models::SceneAction.new(message: 'Next', destination: second_scene)
      ]
    )
  end
  let(:second_scene) do
    Models::Scene.new(
      tag: :second_scene,
      message: 'Second message',
      actions: [
        Models::SceneAction.new(message: 'End', destination: end_scene)
      ]
    )
  end
  let(:end_scene) { Models::Scene.end_scene }

  it 'works as expected, makes use of the adapters' do
    subject

    expect(test_io.mixed_stream).to eq(
      <<~STREAM
        [flush]
        Start message
        Next
        $ 1
        [flush]
        Second message
        End
        $ 1
      STREAM
    )
  end
end
