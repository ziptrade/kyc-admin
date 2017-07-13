module States
  class Empty < State
    def usable?
      false
    end

    def add_change_request(a_change_request, kyc)
      new_state = States::PendingChange.new(previous_state: kyc.state, change_requests: [a_change_request])
      kyc.change_to_state(new_state)
    end

    def docket
      Docket.new
    end
  end
end
