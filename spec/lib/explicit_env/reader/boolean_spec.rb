RSpec.describe ExplicitEnv::Reader do
  subject(:reader) { described_class.new }

  before do
    ENV.delete("BOOLEAN")
  end

  context "#boolean" do
    %w[false False FALSE 0 f F off Off OFF].each do |value|
      it "should consider `#{value}` false" do
        ENV["BOOLEAN"] = value
        reader.boolean("BOOLEAN")
        expect(reader["BOOLEAN"]).to eq(false)
      end
    end

    it "should consider nil false" do
      reader.boolean("BOOLEAN")
      expect(reader["BOOLEAN"]).to eq(false)
    end

    it "should return default if specified and not set" do
      reader.boolean("BOOLEAN", default: true)
      expect(reader["BOOLEAN"]).to eq(true)
    end

    it "should raise an error if required and not set" do
      expect { reader.boolean("BOOLEAN", required: true) }
        .to raise_error(ExplicitEnv::RequiredEnvError)
    end
  end
end
