module States
  class Empty < State
    def usable?
      false
    end

    def add_change_request(a_change_request, kyc)
      kyc.state = States::PendingChange.new(previous_state: kyc.state, change_requests: [a_change_request])
    end

    def docket
      Docket.new
    end
  end
end
