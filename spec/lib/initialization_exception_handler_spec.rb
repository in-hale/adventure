# frozen_string_literal: true

describe InitializationExceptionHandler do
  let(:io_adapter) { double(println: nil) }

  it 'handles initialization errors' do
    expect(io_adapter).to receive(:println).with('Story file: Invalid scene referenced. blabla')
    described_class.handle(io_adapter: io_adapter) { raise Errors::InvalidSceneReference, 'blabla' }

    expect(io_adapter).to receive(:println).with(
      'Story file: Story not completable. Make sure it has anchor scenes and the end is reachable'
    )
    described_class.handle(io_adapter: io_adapter) { raise Errors::StoryNotCompletable }

    expect(io_adapter).to receive(:println).with('Story file: Not found. Make sure to specify an existing file')
    described_class.handle(io_adapter: io_adapter) { raise Errors::StoryFileNotFound }
  end
end
