RSpec.describe ExplicitEnv::Reader do
  subject(:reader) { described_class.new }

  let(:string) { "test string" }

  before do
    ENV.delete("STRING")
  end

  context "#string" do
    it "should resolve string value" do
      ENV["STRING"] = string
      reader.string("STRING")
      expect(reader["STRING"]).to eq(string)
    end

    it "should consider nil as empty string" do
      reader.string("STRING")
      expect(reader["STRING"]).to eq("")
    end

    it "should return default if specified and not set" do
      reader.string("STRING", default: string)
      expect(reader["STRING"]).to eq(string)
    end

    it "should raise an error if required and not set" do
      expect { reader.string("STRING", required: true) }
        .to raise_error(ExplicitEnv::RequiredEnvError)
    end
  end
end
