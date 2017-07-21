module Applications
  class KYCApplication
    def self.for(web_application, environment)
      send environment, web_application
    end

    def self.development(web_application)
      new(web_application).tap(&:use_hardcoded_jwt_config)
    end

    def self.test(web_application)
      new(web_application).tap(&:use_hardcoded_jwt_config)
    end

    def self.production(web_application)
      new(web_application).tap(&:use_jwt_from_env)
    end

    def initialize(web_application)
      @web_application = web_application
    end

    def sso_subsystem
      Applications::SingleSignOn.new @web_application, @jwt_config
    end

    def use_hardcoded_jwt_config
      @jwt_config = JWTAuthentication::Config.for_development_and_test
    end

    def use_jwt_from_env
      @jwt_config = JWTAuthentication::Config.for_production
    end
  end
end
