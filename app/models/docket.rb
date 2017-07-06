class Docket < ApplicationRecord

  def new_copy
    Docket.new(first_name: first_name, last_name: last_name, id_number: id_number, id_type: id_type)
  end
end
