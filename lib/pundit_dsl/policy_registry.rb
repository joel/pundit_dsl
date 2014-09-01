require 'singleton'

module PunditDsl
  class PolicyRegistry
    include Singleton

    def initialize
      @policies = Hash.new
    end

    def [] role
      @policies[role]
    end

    def []= role, policy
      @policies[role] = policy
    end
  end
end
