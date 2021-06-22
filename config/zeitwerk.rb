# frozen_string_literal: true

AUTOLOAD_PATHS = %w[lib].freeze

Zeitwerk::Loader.new.tap do |loader|
  AUTOLOAD_PATHS.each do |path|
    loader.push_dir(path)
  end
  loader.setup
end
