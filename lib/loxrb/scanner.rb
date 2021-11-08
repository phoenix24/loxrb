require_relative "tokens"

class Scanner
    def initialize(source)
        @source = source
        @tokens = []
        @line = 1
        @start = 0
        @current = 0
    end

    def scan_tokens()
        until end?
            @start = @current
            scan_token
        end

        @tokens << Token.new(TokenType[:EOF], "", nil, @line)
        @tokens
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
        when '!' then add_token(match('=') ? TokenType[:BANG_EQUAL] : TokenType[:BANG])
        when '=' then add_token(match('=') ? TokenType[:EQUAL_EQUAL] : TokenType[:EQUAL])
        when '<' then add_token(match('=') ? TokenType[:GREATER_EQUAL] : TokenType[:GREATER])
        when '>' then add_token(match('=') ? TokenType[:LESS_EQUAL] : TokenType[:LESS])
        when '/'
            if match('/')
                until peek != '\n' && end? do
                    advance!
                end
            else
                add_token(TokenType[:SLASH])
            end
        
        when ' ', '\r', '\t'
        
        when '\n'
            @line += 1

        when '"' 
            string!

        else 
            if digit?(c)
                number!

            elsif alpha?(c)
                identifier!

            else
                raise Exception.new, "unexpected token encountered #{c}"
            end
        end
    end

    def match(expected) 
        return false if end?
        return false if @source[@current] != expected
        @current += 1
        true
    end

    def peek
        return '\0' if end?
        @source[@current]
    end

    def peekn
        return '\0' if @current + 1 >= @source.length 
        @source[@current+1]
    end

    def advance!
        @current += 1
        @source.chars[@current-1]
    end

    def add_token(type, literal = nil)
        text = @source[@start..@current]
        @tokens << Token.new(type, text, literal, @line)
    end

    def end?
        @current >= @source.length 
    end

    def string! 
        # capture the string
        while peek != '"' && !end?
            if peek == '\n'
                @line += 1
            end
            advance!
        end
        
        if end?
            puts "Lox.Error, un-terminated string!"
        end

        # complete/ close string capture
        advance!

        value = @source[@start+1 ... @current-1]
        add_token(TokenType[:STRING], value)
    end

    def digit?(char)
        char.ord >= 48 && char.ord <= 57
    end

    def alpha?(char)
        (char >= 'a' && char <= 'z') || 
        (char >= 'A' && char <= 'Z') || 
        char == '_'
    end

    def alphanum?(char) 
        alpha?(char) || digit?(char)
    end

    def number!
        while digit?(peek) do
            advance!
        end

        if peek == '.' && digit?(peekn) 
            advance!
            while digit?(peek) do
                advance!
            end
        end

        value = @source[@start...@current].to_f
        add_token(TokenType[:NUMBER], value.to_f)
    end

    def identifier!
        while alphanum?(peek) do
            advance!
        end

        text = @source[@start...@current]
        type = Keywords[text]
        add_token(type.nil? ? TokenType[:IDENTIFIER] : type)
    end
end