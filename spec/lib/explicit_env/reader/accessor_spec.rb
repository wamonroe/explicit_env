RSpec.describe ExplicitEnv::Reader do
  subject(:reader) { described_class.new }

  context "#[]" do
    it "should return the type casted value of a known environmental variable" do
      ENV["MY_NUMBER"] = "2"
      reader.integer "MY_NUMBER"
      expect(reader["MY_NUMBER"]).to eq(2)
    end

    it "should raise an exception if the environmental variable is unknown" do
      ENV["UNKNOWN"] = "test value"
      expect { reader["UNKNOWN"] }.to raise_error(ExplicitEnv::UnknownEnvError)
    end
  end

  context "#read" do
    it "should not require a block" do
      ENV["TEST_ENV"] = "value"
      reader.send(:read, "TEST_ENV")
      expect(reader["TEST_ENV"]).to eq("value")
    end
  end
end
