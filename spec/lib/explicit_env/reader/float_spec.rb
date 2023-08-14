RSpec.describe ExplicitEnv::Reader do
  subject(:reader) { described_class.new }

  let(:string) { "11.1" }
  let(:value) { string.to_f }

  before do
    ENV.delete("FLOAT")
  end

  context "#float" do
    it "should resolve float value" do
      ENV["FLOAT"] = string
      reader.float("FLOAT")
      expect(reader["FLOAT"]).to eq(value)
    end

    it "should consider nil as 0.0" do
      reader.float("FLOAT")
      expect(reader["FLOAT"]).to eq(0.0)
    end

    it "should return default if specified and not set" do
      reader.float("FLOAT", default: value)
      expect(reader["FLOAT"]).to eq(value)
    end

    it "should raise an error if required and not set" do
      expect { reader.float("FLOAT", required: true) }
        .to raise_error(ExplicitEnv::RequiredEnvError)
    end
  end
end
