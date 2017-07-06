class States::PendingChange < States::State
  belongs_to :previous_state, class_name: 'States::State'
  has_many :change_requests, class_name: 'Changes::KycChangeRequest', foreign_key: 'states_states_id'

  delegate :docket, to: :previous_state

  def usable?
    false
  end

  def add_change_request(a_change_request, kyc)
    self.change_requests.push(a_change_request)
  end

  def approve(kyc)
    kyc.state = States::Approved.new_with_changes(previous_state, change_requests)
  end

end
