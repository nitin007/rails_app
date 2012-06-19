require 'digest/sha2'

# This module contains functions for hashing and storing passwords
module Password

  # Checks the password against the stored password
  def Password.check(password, store)
    hash = self.get_hash(store)

    if self.hash(password) == hash
      true

    else
      false
    end
  end

  protected

  # Generates a 128 character hash
  def Password.hash(password)
    Digest::SHA512.hexdigest("#{password}")
  end
  
  # Gets the hash from a stored password
  def Password.get_hash(store)
    store[0..127]
  end
end
