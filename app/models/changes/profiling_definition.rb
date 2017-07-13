module Changes
  class ProfilingDefinition < KycChangeRequest
    has_many :movement_restrictions

    def apply(docket)
      docket.movement_restrictions = movement_restrictions
    end
  end
end
