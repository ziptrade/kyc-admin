module States
  class Blacklisted < State
    belongs_to :docket
    belongs_to :reason, class_name: 'RejectedReason'

    def usable?
      false
    end

    def add_change_request(a_change_request, kyc)
      kyc.state = PendingChange.new(previous_state: kyc.state, change_requests: [a_change_request])
    end
  end
end
