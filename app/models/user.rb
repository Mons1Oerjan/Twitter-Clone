class User < ApplicationRecord
  # Callbacks:
  before_save { email.downcase! }

  # Breakdown of the Valid Email Regex
  # Regex:             Explanation:
  # /                  start or regex
  # \A                 match start of a string
  # [\w+\-.]+          at least one word character, plus, hyphen, or dot
  # @                  literal "at" sign
  # [a-z\d\-.]+        at least one letter, digit, hyphen, or dot
  # (\.[a-z\d\-]+)*    zero or more of: (at least one dot, letter, digit, or hyphen)
  # \.                 literal dot
  # [a-z]+             at least one letter
  # \z                 match end of a string
  # /                  end of regex
  # i                  case-insensitive
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name,
            presence: true,
            length: {
                maximum: 50
            }
  validates :email,
            presence: true,
            length: {
                maximum: 255
            },
            format: {
                with: VALID_EMAIL_REGEX
            },
            uniqueness: {
                case_sensitive: false
            }
  validates :password,
            presence: true,
            length: {
                minimum: 6
            }

  # Uses bcrypt to hash the user's password. This ensures that an attacker won't
  # be able to log in to the site even if they manage to obtain a copy of the DB.
  # By default, bcrypt produces a "salted hash", which protects against two
  # important classes of attacks: Dictionary attacks and Rainbow Table Attacks.
  has_secure_password

  # Returns the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
               BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
