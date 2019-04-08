class DoctorPolicy < ApplicationPolicy
  def show?
  	return false if !doctor.present?
    true if doctor.id == record.id
  end

 #  def create?
 #    return Regular.new(record)
 #  end
 #
 #  def show?
 #    return Guest.new(record) unless doctor
 #    return Admin.new(record) if doctor.admin?
 #    return Regular.new(record)
 #  end
 #
 #  def update?
 #    raise Pundit::NotAuthorizedError unless doctor
 #    return Admin.new(record) if doctor.admin?
 #    return Regular.new(record)
 #  end
 #
 #  def destroy?
 #    raise Pundit::NotAuthorizedError unless doctor
 #    return Admin.new(record) if doctor.admin?
 #    return Regular.new(record)
 #  end
 #
 #  def activate?
 #    raise Pundit::NotAuthorizedError unless record.is_a? doctor
 #    return Admin.new(record) if record.admin?
 #    return Regular.new(record)
 #  end
 #
 #  class Scope < Scope
 #    def resolve
 #      return Guest.new(scope, doctor) unless doctor
 #      return Admin.new(scope, doctor) if doctor.admin?
 #      return Regular.new(scope, doctor)
 #    end
 #  end
 #
 #  class Admin < FlexiblePermissions::Base
 #    class Fields < self::Fields
 #      def permitted
 #        #super
 #      end
 #    end
 #
 #    class Includes < self::Includes
 #      def permitted
 #        #super
 #      end
 #    end
 #  end
 #
 #  class Regular < Admin
 #    class Fields < self::Fields
 #      def permitted
 #        #super - [
 #        #  :token, :updated_at
 #        #]
 #      end
 #    end
 #  end
 #
 #  class Guest < Regular
 #    class Fields < self::Fields
 #      def permitted
 #        #super - [
 #        #  :email
 #        #]
 #      end
 #    end
 #  end
end
