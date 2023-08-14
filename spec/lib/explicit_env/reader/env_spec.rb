RSpec.describe ExplicitEnv::Reader do
  subject(:reader) { described_class.new }

  before do
    ENV.delete("APP_ENV")
  end

  context "#env" do
    it "should be an instance of ActiveSupport::EnvironmentInquirer" do
      reader.env("APP_ENV")
      expect(reader["APP_ENV"]).to be_a(ActiveSupport::EnvironmentInquirer)
    end

    it "should resolve passed value" do
      ENV["APP_ENV"] = "production"
      reader.env("APP_ENV")
      expect(reader["APP_ENV"].production?).to eq(true)
    end

    it "should default to development" do
      reader.env("APP_ENV")
      expect(reader["APP_ENV"].development?).to eq(true)
    end

    it "should raise an error if required and not set" do
      expect { reader.env("APP_ENV", required: true) }
        .to raise_error(ExplicitEnv::RequiredEnvError)
    end
  end
end
