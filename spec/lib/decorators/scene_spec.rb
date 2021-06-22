# frozen_string_literal: true

describe Decorators::Scene do
  subject { described_class.new(scene) }

  let(:scene) do
    Models::Scene.new(
      tag: :tag,
      message: 'Scene Message',
      actions: [
        Models::SceneAction.new(message: 'Go forward'),
        Models::SceneAction.new(message: 'Go back')
      ]
    )
  end

  describe '#select_action' do
    it 'raises an exception if invalid action tag is provided' do
      expect { subject.select_action('one_two_three') }.to raise_error(
        Errors::InvalidActionSelected, Models::Scene::INVALID_ACTION_ERROR_MESSAGE
      )
    end

    it 'decrements the input and delegates to scene if valid action tag is provided' do
      expect(scene).to receive(:select_action).with(1)
      subject.select_action('2')
    end
  end

  it 'has all the required attributes' do
    expect(subject).to have_attributes(
      actions_string: "  1. Go forward\n  2. Go back",
      action_input_prefix: '> '
    )
  end
end
