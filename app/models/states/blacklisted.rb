module States
  class Blacklisted < State
    CANT_MAKE_CHANGE_REQUEST_ERROR = "Can't add change request to blacklisted Kyc".freeze
    belongs_to :previous_state, class_name: 'States::State'
    belongs_to :reason, class_name: 'RejectedReason'

    delegate :docket, to: :previous_state

    def usable?
      false
    end


    def add_change_request(_a_change_request, _kyc)
      raise StandardError, CANT_MAKE_CHANGE_REQUEST_ERROR
    end

    def blacklist(_kyc, _reason)
      raise StandardError, "Can't blacklist an already blacklisted Kyc"
    end

    def remove_from_blacklist(kyc)
      kyc.change_to_state(previous_state)
    end
  end
end
