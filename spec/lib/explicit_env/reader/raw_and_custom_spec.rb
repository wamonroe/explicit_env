RSpec.describe ExplicitEnv::Reader do
  subject(:reader) { described_class.new }

  context "#raw" do
    before do
      ENV.delete("RAW")
    end

    it "should resolve a raw value without any typecasting" do
      ENV["RAW"] = "1"
      reader.raw("RAW")
      expect(reader["RAW"]).to eq("1")
    end

    it "should resolve an unset raw value as nil" do
      reader.raw("RAW")
      expect(reader["RAW"]).to be_nil
    end
  end

  context "#custom" do
    before do
      ENV.delete("CUSTOM")
    end

    it "should allow custom typecasting" do
      ENV["CUSTOM"] = "localhost"
      reader.raw("CUSTOM") { |value| "https://#{value}" }
      expect(reader["CUSTOM"]).to eq("https://localhost")
    end
  end
end
