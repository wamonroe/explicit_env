require_relative "reader"

module ExplicitEnv
  module DSL
    def env
      @env ||= ::ExplicitEnv::Reader.new
    end

    def define_env(&block)
      env.instance_eval(&block)
    end
  end
end
