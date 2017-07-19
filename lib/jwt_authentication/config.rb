module JWTAuthentication
  class Config
    attr_reader :hmac_secret, :leeway, :issuer, :expires_in, :algorithm

    def self.for_production
      config = {
        leeway: ENV['JWT_LEEWAY'],
        issuer: ENV['JWT_ISSUER'],
        hmac_secret: ENV['JWT_JMAC_SECRET'],
        expires_in: ENV['JWT_EXPIRES_IN'],
        algorithm: ENV['JWT_ALGORITHM']
      }

      self.new(config)

    end

    def self.for_development_and_test
      config = {
        leeway: 30,
        issuer: 'Bitex.la',
        hmac_secret: '65677cda69cf2d9760ca619082ac2e686b7bdeb3fda7',
        expires_in: 300,
        algorithm: 'HS256'
      }

      self.new(config)
    end

    def initialize(config)
      @hmac_secret, @leeway, @issuer, @expires_in, @algorithm =
        config[:hmac_secret], config[:leeway], config[:issuer], config[:expires_in], config[:algorithm]
    end
  end
end