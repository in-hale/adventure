# frozen_string_literal: true

require 'bundler/setup'

DEFAULT_ENV = :development

Bundler.require(:default, ENV.fetch('ADVENTURE_ENV', DEFAULT_ENV))

require_relative 'zeitwerk'
