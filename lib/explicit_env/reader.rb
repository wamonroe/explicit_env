require "active_support/all"

require_relative "error"

module ExplicitEnv
  class Reader
    FALSE_VALUES = %w[false 0 f off]

    def initialize
      @env_value = {}
    end

    # Access

    def [](env_var)
      @env_value.fetch(env_var)
    rescue KeyError
      raise ::ExplicitEnv::UnknownEnvError, "unknown environmental variable (#{env_var})"
    end

    # Define

    def boolean(env_var, options = {})
      read(env_var, options) do |value|
        value.present? && FALSE_VALUES.exclude?(value.downcase)
      end
    end

    def decimal(env_var, options = {})
      read(env_var, options) { |value| value.to_d }
    end

    def env(env_var, options = {})
      options[:default] ||= "development"
      read(env_var, options) do |value|
        ActiveSupport::EnvironmentInquirer.new(value)
      end
    end

    def float(env_var, options = {})
      read(env_var, options) { |value| value.to_f }
    end

    def integer(env_var, options = {})
      read(env_var, options) { |value| value.to_i }
    end

    def raw(env_var, options = {}, &block)
      read(env_var, options, &block)
    end
    alias_method :custom, :raw

    def string(env_var, options = {})
      read(env_var, options) { |value| value.to_s }
    end

    private

    def read(env_var, options = {}, &block)
      block ||= ->(value) { value }
      value = if options[:required]
        ENV.fetch(env_var).strip
      elsif options[:default]
        ENV.fetch(env_var, options[:default].to_s).strip
      else
        ENV[env_var]&.strip
      end
      @env_value[env_var] = block.call(value)
    rescue KeyError
      raise ::ExplicitEnv::RequiredEnvError, "required environmental variable not specified (#{env_var})"
    end
  end
end
