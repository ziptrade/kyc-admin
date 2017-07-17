module Movements
  class Movement < ApplicationRecord
    monetize :amount_cents

    alias moved amount
  end
end
