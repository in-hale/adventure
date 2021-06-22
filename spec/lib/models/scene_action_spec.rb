# frozen_string_literal: true

describe Models::SceneAction do
  subject { described_class.new(message: 'Message', destination_tag: :random_room, destination: destination) }

  let(:destination) { double('destination') }

  it 'has the required attributes publicly available' do
    expect(subject).to have_attributes(
      message: 'Message',
      destination_tag: :random_room,
      destination: destination
    )
  end
end
