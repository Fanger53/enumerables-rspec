require './enumerables'

describe Enumerable do
  let(:arr) { [1, 2, 3, 4] }
  let(:ans) { [] }
  let(:bool) { [true, false, nil] }
  let(:str) { %w[Dog Cat Mouse] }
  let(:str1) { ['Dog', 'Cat', 1, 3, 'Mouse', 4] }
  let(:my_hash) { { 'cat' => 0, 'dog' => 1, 'wombat' => 2 } }

  describe '#my_each' do
    it " pass for each value of array and multiply by 2" do
      arr.my_each { |n| ans << n * 2}
      expect(ans).to eql([2, 4, 6, 8])
    end

    it "my_each pass for all the strings values" do
      str.my_each { |n| ans << n}
      expect(ans).to eql(%w[Dog Cat Mouse])
    end

    it "if no block is given, returns an enumerator " do
      ans.my_each { |n| ans << n.empty?}
      expect(ans).to eql([])
    end

  end

  describe '#my_each_with_index' do
    it "select a specific key or value from my_hash" do
      my_hash.my_each_with_index { |key, value| ans << value.to_s }
      expect(ans).to eql(%w[0 1 2])
    end
    
    it "if no block is given, returns an enumerator" do
      expect(my_hash.my_each_with_index).to be_an Enumerator
    end
  end

  describe '#my_select' do
    it "select method returns an array with the even numbers" do
      arr.my_select {|n| ans << n if n.even?  } 
      expect(ans).to eql([2, 4])
    end

    it "if no block is given, returns an enumerator" do
      expect(arr.my_select).to be_an Enumerator
    end
  end

  describe '#my_all?' do
    it "returns true, if the block never returns false or nil" do
      expect(arr.my_all?(Numeric)).to eql(true)
    end

    it "returns true if no block is given" do
      expect(arr.my_all?).to eql(true)
    end
  end
end
