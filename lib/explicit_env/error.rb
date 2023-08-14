module ExplicitEnv
  class Error < StandardError; end

  class BlockRequiredError < Error; end

  class RequiredEnvError < Error; end

  class UnknownEnvError < Error; end
end
