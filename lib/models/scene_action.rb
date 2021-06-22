# frozen_string_literal: true

module Models
  SceneAction = Struct.new(:message, :destination_tag, :destination, keyword_init: true)
end
