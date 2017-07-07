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

  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }


end
