require 'test/unit/assertions'
require 'test/unit/testcase'
include Test::Unit::Assertions


class Verify_Sentence_Test_Class < Test::Unit::TestCase


    def test_sentences_true
        assert_equal verify_sentence('a > b # (c > a)'), true
        assert_equal verify_sentence('a & b > (c # d)'), true
    end

    def test_sentences_false
        assert_equal verify_sentence('a & b > & (c # d)'), false
        assert_equal verify_sentence('a & b (> c # d)'), false
        assert_equal verify_sentence('ac > d'), false
        assert_equal verify_sentence('a > b &'), false
        
    end

end