require 'spec_helper'

describe AkamaiRestCcu::Ccu do
  let! (:ccu) { AkamaiRestCcu::Ccu.new('username', 'password') }

  describe "Ccu" do
    it "responds to purge_urls" do
      expect(ccu).to respond_to(:purge_urls)
    end

    it "responds to purge_cpcodes" do
      expect(ccu).to respond_to(:purge_cpcodes)
    end

    it "responds to purge_status" do
      expect(ccu).to respond_to(:purge_status)
    end
  end
end
