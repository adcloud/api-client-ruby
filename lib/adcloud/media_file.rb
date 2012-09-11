module Adcloud
  class MediaFile < Adcloud::Entity
    attribute :id, Integer
    attribute :uploaded_file, String
    attribute :product_id, Integer
    attribute :ad_id, Integer
    attribute :flash, Boolean
    attribute :display, Boolean
  end
end