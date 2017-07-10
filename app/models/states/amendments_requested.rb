class States::AmendmentsRequested < States::WithChange

  def add_change_request(a_change_request, kyc)
    super(a_change_request, kyc)
    kyc.state = States::PendingChange.new(previous_state: previous_state, change_requests: change_requests)
  end
end
