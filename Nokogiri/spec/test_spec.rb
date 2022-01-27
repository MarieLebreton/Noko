require_relative '../lib/test'


describe "new_hash contain 20 values" do
    it "should return 20" do
      expect(hash_length).to eq(20)
    end
end

describe "new_hash contain BTC" do
    it "should return BTC" do
      expect(hash_check).to eq(true)
    end
end



