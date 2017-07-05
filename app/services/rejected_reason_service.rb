class RejectedReasonService
  include Godmin::Resources::ResourceService

  attrs_for_index :name, :description
  attrs_for_show :name, :description
  attrs_for_form :name, :description
end
