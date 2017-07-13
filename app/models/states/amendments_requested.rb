module States
  class AmendmentsRequested < WithChange
    def add_change_request(a_change_request, kyc)
      super(a_change_request, kyc)
      new_state = PendingChange.new(previous_state: previous_state, change_requests: change_requests)
      kyc.change_to_state(new_state)
    end
  end
end
