class Token
    def initialize(type, lexeme, literal, line)
        @type = type
        @lexeme = lexeme
        @literal = literal
        @line = line
    end
end

TokenType = {
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

    :EOF => 11
}