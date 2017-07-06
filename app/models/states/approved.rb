class States::Approved < States::State
  belongs_to :docket

  def self.new_with_changes(previous_state, change_requests)
    docket = previous_state.docket.new_copy
    change_requests.each { | change_request | change_request.apply(docket) }
    new(docket: docket)
  end

  def usable?
    true
  end

end
