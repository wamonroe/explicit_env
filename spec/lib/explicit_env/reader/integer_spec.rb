RSpec.describe ExplicitEnv::Reader do
  subject(:reader) { described_class.new }

  let(:string) { "11" }
  let(:value) { string.to_i }

  before do
    ENV.delete("INTEGER")
  end

  context "#integer" do
    it "should resolve integer value" do
      ENV["INTEGER"] = string
      reader.integer("INTEGER")
      expect(reader["INTEGER"]).to eq(value)
    end

    it "should consider nil as 0" do
      reader.integer("INTEGER")
      expect(reader["INTEGER"]).to eq(0)
    end

    it "should return default if specified and not set" do
      reader.integer("INTEGER", default: value)
      expect(reader["INTEGER"]).to eq(value)
    end

    it "should raise an error if required and not set" do
      expect { reader.integer("INTEGER", required: true) }
        .to raise_error(ExplicitEnv::RequiredEnvError)
    end
  end
end
