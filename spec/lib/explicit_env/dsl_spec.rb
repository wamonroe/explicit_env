module MyExampleApp
  extend ExplicitEnv::DSL
end

RSpec.describe MyExampleApp do
  subject(:app) { described_class }

  context ".env" do
    it "should return an instanced of ExplicitEnv::Reader" do
      expect(app.env).to be_a(ExplicitEnv::Reader)
    end
  end

  context ".define_env" do
    it "should evalute the passed block as .env" do
      ENV["TEST_INTEGER"] = "2"
      app.define_env do
        integer "TEST_INTEGER"
        boolean "DO_SOMETHING", default: true
      end

      expect(app.env["TEST_INTEGER"]).to eq(2)
      expect(app.env["DO_SOMETHING"]).to eq(true)
    end
  end
end
