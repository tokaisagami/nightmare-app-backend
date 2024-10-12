class User < ApplicationRecord
  authenticates_with_sorcery!
  has_secure_password
end
