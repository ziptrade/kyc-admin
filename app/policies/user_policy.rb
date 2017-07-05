class UserPolicy < Godmin::Authorization::Policy
  def index?
    true
  end

  def show?
    false
  end

  def create?
    false
  end

  def update?
    false
  end

  def destroy?
    false
  end
end
