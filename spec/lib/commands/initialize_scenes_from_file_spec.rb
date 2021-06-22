# frozen_string_literal: true

describe Commands::InitializeScenesFromFile do
  subject { described_class.new(file_path, template_variables: { name: 'John' }).call }

  context 'with properly organized file' do
    let(:file_path) { 'spec/fixtures/scenes.yml' }

    it 'evaluates all and returns the start scene' do
      expect(subject).to match scene_with_attributes(
        tag: :_start,
        message: 'Hi John, are you ready?',
        actions: [
          action_with_attributes(
            message: 'Yes!',
            destination: scene_with_attributes(
              tag: :second_room,
              message: 'Forward or back?',
              actions: [
                action_with_attributes(
                  message: 'Forward',
                  destination: scene_with_attributes(
                    tag: :_exit
                  )
                ),
                action_with_attributes(
                  message: 'Back',
                  destination: subject
                )
              ]
            )
          ),
          action_with_attributes(
            message: 'No!',
            destination: scene_with_attributes(
              tag: :_exit
            )
          )
        ]
      )
    end
  end

  context 'with file with no anchors' do
    let(:file_path) { 'spec/fixtures/scenes_with_no_anchors.yml' }

    it 'raises proper exception' do
      expect { subject }.to raise_error(Errors::StoryNotCompletable)
    end
  end

  context 'with infinite story' do
    let(:file_path) { 'spec/fixtures/scenes_infinite.yml' }

    it 'raises proper exception' do
      expect { subject }.to raise_error(Errors::StoryNotCompletable)
    end
  end

  context 'with file with invalid reference' do
    let(:file_path) { 'spec/fixtures/scenes_with_invalid_reference.yml' }

    it 'raises proper exception' do
      expect { subject }.to raise_error(Errors::InvalidSceneReference)
    end
  end

  context 'with invalid file path' do
    let(:file_path) { 'invalid_file_path.yml' }

    it 'raises proper exception' do
      expect { subject }.to raise_error(Errors::StoryFileNotFound)
    end
  end

  def scene_with_attributes(attrs)
    an_object_having_attributes(
      class: Models::Scene,
      **attrs
    )
  end

  def action_with_attributes(attrs)
    an_object_having_attributes(
      class: Models::SceneAction,
      **attrs
    )
  end

end
