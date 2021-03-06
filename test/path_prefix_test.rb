require 'test_helper'
require 'lotus/utils/path_prefix'

describe Lotus::Utils::PathPrefix do
  it 'exposes itself as a string' do
    prefix = Lotus::Utils::PathPrefix.new
    assert prefix == '', "Expected #{ prefix } to equal ''"
  end

  it 'adds root prefix only when needed' do
    prefix = Lotus::Utils::PathPrefix.new('/fruits')
    assert prefix == '/fruits', "Expected #{ prefix } to equal '/fruits'"
  end

  describe '#join' do
    it 'joins a string' do
      prefix = Lotus::Utils::PathPrefix.new('fruits')
      prefix.join('peaches').must_equal '/fruits/peaches'
    end

    it 'joins a prefixed string' do
      prefix = Lotus::Utils::PathPrefix.new('fruits')
      prefix.join('/cherries').must_equal '/fruits/cherries'
    end

    it 'joins a string when the root is blank' do
      prefix = Lotus::Utils::PathPrefix.new
      prefix.join('tea').must_equal '/tea'
    end

    it 'joins a prefixed string when the root is blank' do
      prefix = Lotus::Utils::PathPrefix.new
      prefix.join('/tea').must_equal '/tea'
    end
  end

  describe '#relative_join' do
    it 'joins a string without prefixing with separator' do
      prefix = Lotus::Utils::PathPrefix.new('fruits')
      prefix.relative_join('peaches').must_equal 'fruits/peaches'
    end

    it 'joins a prefixed string without prefixing with separator' do
      prefix = Lotus::Utils::PathPrefix.new('fruits')
      prefix.relative_join('/cherries').must_equal 'fruits/cherries'
    end

    it 'joins a string when the root is blank without prefixing with separator' do
      prefix = Lotus::Utils::PathPrefix.new
      prefix.relative_join('tea').must_equal 'tea'
    end

    it 'joins a prefixed string when the root is blank and removes the prefix' do
      prefix = Lotus::Utils::PathPrefix.new
      prefix.relative_join('/tea').must_equal 'tea'
    end

    it 'joins a string with custom separator' do
      prefix = Lotus::Utils::PathPrefix.new('fruits')
      prefix.relative_join('cherries', '_').must_equal 'fruits_cherries'
    end

    it 'joins a prefixed string without prefixing with custom separator' do
      prefix = Lotus::Utils::PathPrefix.new('fruits')
      prefix.relative_join('_cherries', '_').must_equal 'fruits_cherries'
    end
  end

  describe 'string interface' do
    describe 'equality' do
      it 'has a working equality' do
        string = Lotus::Utils::PathPrefix.new('lotus')
        other  = Lotus::Utils::PathPrefix.new('lotus')

        assert string == other
      end

      it 'has a working equality with raw strings' do
        string = Lotus::Utils::PathPrefix.new('lotus')
        assert string == 'lotus'
      end
    end

    describe 'case equality' do
      it 'has a working case equality' do
        string = Lotus::Utils::PathPrefix.new('lotus')
        other  = Lotus::Utils::PathPrefix.new('lotus')
        assert string === other
      end

      it 'has a working case equality with raw strings' do
        string = Lotus::Utils::PathPrefix.new('lotus')
        assert string === 'lotus'
      end
    end

    describe 'value equality' do
      it 'has a working value equality' do
        string = Lotus::Utils::PathPrefix.new('lotus')
        other  = Lotus::Utils::PathPrefix.new('lotus')
        assert string.eql?(other)
      end

      it 'has a working value equality with raw strings' do
        string = Lotus::Utils::PathPrefix.new('lotus')
        assert string.eql?('lotus')
      end
    end

    describe 'identity equality' do
      it 'has a working identity equality' do
        string = Lotus::Utils::PathPrefix.new('lotus')
        assert string.equal?(string)
      end

      it 'has a working identity equality with raw strings' do
        string = Lotus::Utils::PathPrefix.new('lotus')
        assert !string.equal?('lotus')
      end
    end

    describe '#hash' do
      it 'returns the same hash result of ::String' do
        expected = 'hello'.hash
        actual   = Lotus::Utils::PathPrefix.new('hello').hash

        actual.must_equal expected
      end
    end
  end
end
