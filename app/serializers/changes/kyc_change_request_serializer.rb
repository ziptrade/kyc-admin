module Changes
  class KycChangeRequestSerializer
    include JSONAPI::Serializer
    attribute :comment
  end
end
