RSpec.describe ExplicitEnv::Reader do
  subject(:reader) { described_class.new }

  let(:string) { "11.1" }
  let(:value) { string.to_d }

  before do
    ENV.delete("DECIMAL")
  end

  context "#decimal" do
    it "should resolve decimal value" do
      ENV["DECIMAL"] = string
      reader.decimal("DECIMAL")
      expect(reader["DECIMAL"]).to eq(value)
    end

    it "should consider nil as 0.0" do
      reader.decimal("DECIMAL")
      expect(reader["DECIMAL"]).to eq(0.0)
    end

    it "should return default if specified and not set" do
      reader.decimal("DECIMAL", default: value)
      expect(reader["DECIMAL"]).to eq(value)
    end

    it "should raise an error if required and not set" do
      expect { reader.decimal("DECIMAL", required: true) }
        .to raise_error(ExplicitEnv::RequiredEnvError)
    end
  end
end
