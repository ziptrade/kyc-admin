module Applications
  class KYCApplication

    def self.for parent, environment
      self.send environment, parent
    end

    def self.development parent
      self.new(parent).tap do |application|
        application.use_hardcoded_jwt_config
      end
    end

    def self.test parent
      self.new(parent).tap do |application|
        application.use_hardcoded_jwt_config
      end
    end

    def self.production parent
      self.new(parent).tap do |application|
        application.use_jwt_from_env
      end
    end

    def initialize(parent)
      @parent = parent
    end

    def sso_subsystem
      Applications::SingleSignOn.new @parent, @jwt_config
    end

    def use_hardcoded_jwt_config
      @jwt_config = JWTAuthentication::Config.for_development_and_test
    end

    def use_jwt_from_env
      @jwt_config = JWTAuthentication::Config.for_production
    end
  end
end