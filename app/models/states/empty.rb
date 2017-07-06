module States
  class Empty < State

    def able_to_make_movements?
      false
    end
  end
end