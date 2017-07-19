module States
  class WithChangeSerializer < States::StateSerializer
    has_one :previous_state
    has_many :change_requests
  end
end
