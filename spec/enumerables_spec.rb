require './enumerables'

describe Enumerable do
  let(:arr) { [1, 2, 3, 4] }
  let(:ans) { [] }
  let(:bool) { [true, false, nil] }
  let(:str) { %w[Dog Cat Mouse] }
  let(:str1) { ['Dog', 'Cat', 1, 3, 'Mouse', 4] }
  let(:my_hash) { { 'cat' => 0, 'dog' => 1, 'wombat' => 2 } }
end
