# frozen_string_literal: true

describe Models::Scene do
  subject(:instance) { described_class.new(tag: tag, message: 'Message', actions: actions) }

  let(:tag) { :random_room }
  let(:actions) { [Models::SceneAction.new] }

  it 'has the required attributes publicly available' do
    expect(instance).to have_attributes(
      tag: :random_room,
      message: 'Message',
      actions: actions
    )
  end

  describe '.end_scene' do
    it 'creates an instance with the end tag' do
      expect(described_class.end_scene).to have_attributes(
        class: described_class,
        tag: Models::Scene::END_SCENE_TAG,
        message: nil,
        actions: [],
        end?: true
      )
    end
  end

  describe '#end?' do
    subject { instance.end? }

    it { is_expected.to be false }

    context 'with the end tag' do
      let(:tag) { Models::Scene::END_SCENE_TAG }

      it { is_expected.to be true }
    end
  end

  describe '#select_action' do
    it 'selects an action by the given tag, and raises an exception if nothing was found' do
      expect(instance.select_action(0)).to eq(actions[0])
      expect { instance.select_action(1) }.to raise_error(
        Errors::InvalidActionSelected, Models::Scene::INVALID_ACTION_ERROR_MESSAGE
      )
    end
  end
end
