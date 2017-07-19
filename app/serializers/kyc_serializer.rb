class KycSerializer
  include JSONAPI::Serializer

  has_one :state, include_links: false
end
