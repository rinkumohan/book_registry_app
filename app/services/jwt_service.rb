class JwtService

  SECRET_KEY = Rails.application.secrets.secret_key_base

  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  def self.decode(token)
    return if token.nil?

    JWT.decode( token, SECRET_KEY,true, algorithm: 'HS256' )
  end
end
