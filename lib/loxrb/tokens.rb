class Token
    attr_reader :type, :lexeme, :literal, :line

    def initialize(type, lexeme, literal, line)
        @type = type
        @lexeme = lexeme
        @literal = literal
        @line = line
    end
end

TokenType = {

    # single char tokens.
    :LEFT_PAREN => 0,
    :RIGHT_PAREN => 1,
    :LEFT_BRACE => 2,
    :RIGHT_BRACE => 3,

    :COMMA => 4,
    :DOT => 5,
    :MINUS => 6,
    :PLUS => 7,
    :SLASH => 8,
    :STAR => 9,
    :SEMICOLON => 10,


    # multiple char tokens
    :BANG => 11,
    :BANG_EQUAL => 12,
    :EQUAL => 13,
    :EQUAL_EQUAL => 14,
    :GREATER => 15,
    :GREATER_EQUAL => 16,
    :LESS => 17,
    :LESS_EQUAL => 18,

    # literals
    :IDENTIFIER => 19,
    :STRING => 20,
    :NUMBER => 21,
    
    # keywords
    :AND => 22,
    :CLASS => 23,
    :ELSE => 24,
    :FALSE => 25,
    :FUN => 26,
    :FOR => 27,
    :IF => 28,
    :NIL => 29,
    :OR => 30,
    :PRINT => 31,
    :RETURN => 32,
    :SUPER => 33,
    :THIS => 34,
    :TRUE => 35,
    :VAR => 36,
    :WHILE => 37,

    :EOF => 38
}

Keywords = {
    "and" => TokenType[:AND],
    "class" => TokenType[:CLASS],
    "else" => TokenType[:ELSE],
    "false" => TokenType[:FALSE],
    "fun" => TokenType[:FUN],
    "for" => TokenType[:FOR],
    "if" => TokenType[:IF],
    "nil" => TokenType[:NIL],
    "or" => TokenType[:OR],
    "print" => TokenType[:PRINT],
    "return" => TokenType[:RETURN],
    "super" => TokenType[:SUPER],
    "this" => TokenType[:THIS],
    "true" => TokenType[:TRUE],
    "var" => TokenType[:VAR],
    "while" => TokenType[:WHILE],
}