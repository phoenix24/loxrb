# frozen_string_literal: true

require "test_helper"

class ScannerTest < Minitest::Test
  def test_basic_expression
    scanner = Scanner.new("")
    assert scanner.end?
    refute scanner.match("=")

    scanner = Scanner.new("asd")
    refute scanner.end?
    refute scanner.match("=")
  end

  def test_match
    scanner = Scanner.new("=")
    refute scanner.end?
    assert scanner.match("=")
    assert scanner.end?
  end

  def test_scan_token1
    exception = assert_raises Exception do
        scanner = Scanner.new("######")
        scanner.scan_token
    end
    assert_equal "unexpected token encountered #", exception.message
  end

  def test_scan_plus
    scanner = Scanner.new("+")
    tokens = scanner.scan_tokens
    assert_equal 2, tokens.length
    assert_equal 1, tokens[0].line
    assert_equal '+', tokens[0].lexeme
    assert_equal TokenType[:PLUS], tokens[0].type
  end

  def test_scan_slash_slash
    scanner = Scanner.new("// this is a comment")
    tokens = scanner.scan_tokens
    assert_equal 1, tokens.length
    assert_equal '', tokens[0].lexeme
    assert_equal TokenType[:EOF], tokens[0].type
  end

  def test_scan_blanks
    scanner = Scanner.new("     ")
    tokens = scanner.scan_tokens
    assert_equal 1, tokens.length
    assert_equal '', tokens[0].lexeme
    assert_equal TokenType[:EOF], tokens[0].type
  end

  def test_scan_string
    scanner = Scanner.new("\"this is a string\"")
    tokens = scanner.scan_tokens
    assert_equal 2, tokens.length
    assert_equal TokenType[:STRING], tokens[0].type
    assert_equal "\"this is a string\"", tokens[0].lexeme
  end

  def test_scan_number
    scanner = Scanner.new("123")
    tokens = scanner.scan_tokens
    assert_equal 2, tokens.length
    assert_equal TokenType[:NUMBER], tokens[0].type
    assert_equal "123", tokens[0].lexeme
    assert_equal 123.0, tokens[0].literal
  end

  def test_scan_two_numbers_and_comments
    scanner = Scanner.new("1 + 2 //adads")
    tokens = scanner.scan_tokens
    assert_equal 4, tokens.length

    one, plus, two, _ = tokens
    assert_equal TokenType[:PLUS], plus.type
    assert_equal "+ ", plus.lexeme
    assert_nil plus.literal

    assert_equal TokenType[:NUMBER], one.type
    assert_equal "1 ", one.lexeme
    assert_equal 1.0, one.literal

    assert_equal TokenType[:NUMBER], two.type
    assert_equal "2 ", two.lexeme
    assert_equal 2.0, two.literal
  end

  def test_lox_expression1
    scanner = Scanner.new("var a")
    tokens = scanner.scan_tokens
    assert_equal 3, tokens.length

    var_kw, var_a, _ = tokens
    assert_equal TokenType[:VAR], var_kw.type
    assert_equal "var ", var_kw.lexeme
    assert_nil var_kw.literal

    assert_equal TokenType[:IDENTIFIER], var_a.type
    assert_equal "a", var_a.lexeme
    assert_nil var_a.literal
  end

  def test_lox_expression2
    scanner = Scanner.new("var a = 42")
    tokens = scanner.scan_tokens
    assert_equal 5, tokens.length

    var_kw, var_a, eq, forty2, _ = tokens
    assert_equal TokenType[:VAR], var_kw.type
    assert_equal "var ", var_kw.lexeme
    assert_nil var_kw.literal

    assert_equal TokenType[:IDENTIFIER], var_a.type
    assert_equal "a ", var_a.lexeme
    assert_nil var_a.literal

    assert_equal TokenType[:EQUAL], eq.type
    assert_equal "= ", eq.lexeme
    assert_nil eq.literal

    assert_equal TokenType[:NUMBER], forty2.type
    assert_equal "42", forty2.lexeme
    assert_equal 42.0, forty2.literal
  end
end