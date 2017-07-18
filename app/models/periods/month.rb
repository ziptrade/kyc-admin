module Periods
  class Month < Periods::Period
    def before(a_date)
      times.months.before(a_date)
    end
  end
end
