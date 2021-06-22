# frozen_string_literal: true

describe Adapters::Console do
  subject(:instance) { described_class.new }

  describe '#println' do
    it 'prints to stdout' do
      expect { instance.println('Some text') }.to output("Some text\n").to_stdout
    end
  end

  describe '#readline' do
    it 'uses Readline to read from stdin' do
      expect(Readline).to receive(:readline).with('> ', true).and_return(nil)
      instance.readline('> ')
    end
  end

  describe '#clear' do
    it 'invokes system "clear" command' do
      expect(Kernel).to receive(:system).with('clear').and_return(nil)
      instance.clear
    end
  end
end
