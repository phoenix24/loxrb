class Scanner
    def initialize(source)
        @source = source
        @tokens = []
        @line = 1
        @start = 0
        @current = 0
    end

    def scan_tokens()
        unless end?
            start = current
            scan_token
        end

        tokens << Token.new(TokenType[:EOF], "", nil, line)
        tokens
    end

    def scan_token
        c = advance!
        case c
        when '(' then add_token(TokenType[:LEFT_PAREN])
        when ')' then add_token(TokenType[:RIGHT_PAREN])
        when '{' then add_token(TokenType[:LEFT_BRACE])
        when '}' then add_token(TokenType[:RIGHT_BRACE])
        when ',' then add_token(TokenType[:COMMA])
        when '.' then add_token(TokenType[:DOT])
        when '-' then add_token(TokenType[:MINUS])
        when '+' then add_token(TokenType[:PLUS])
        when '*' then add_token(TokenType[:STAR])
        when ';' then add_token(TokenType[:SEMICOLON])
        else raise Exception.new, "unexpected error #{c}"
        end
    end

    def advance!
        @current += 1
        @source.chars[@current]
    end

    def add_token(type, literal = nil)
        text = @source[@start..@current]
        @tokens << Token.new(type, text, literal, @line)
    end

    def end?
        @current >= @source.length 
    end
end