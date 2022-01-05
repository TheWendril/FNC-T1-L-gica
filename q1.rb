require 'lexeme'

def get_tokens(sentence)

    begin 
        lexer = Lexeme.define do 

            token :disj => /^\#$/
            token :conj => /^\&$/
            token :impl => /^\>$/
            token :leftp => /^\($/
            token :rightp => /^\)$/
            token :neg => /^\-$/
            token :atom => /^(a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z)$/
        end

        tokens = lexer.analyze do
            from_string sentence

        end
        tokens

    rescue Exception => e
        false
    end
end


def verify_parentheses(sentence, tokens) 

    counter = sentence.count('(') - sentence.count(')')

    if counter != 0
        return false
    end

    counter = 0

    while counter < sentence.length - 1

        if tokens[counter].name == :leftp and counter != 0

            if tokens[counter - 1].name == :atom
                return false
            end

            if tokens[counter + 1].name == :disj or tokens[counter + 1].name == :conj or  tokens[counter + 1].name == :impl
                return false
            end

        end 

        if tokens[counter].name == :rightp and counter - 2 == sentence.length

            if tokens[counter - 1].name != :atom
                return false
            end

            if tokens[counter + 1].name == :atom
                return false

            end

        end

        counter += 1
    end

    return true
end


def verify_simbols(sentence, tokens)

    count = 0
    
    while count < sentence.length - 1

        if tokens[count].name == :disj or tokens[count].name == :conj or tokens[count].name == :impl

            if count == 0 or count == sentence.length - 2
                return false
            end
            
            if tokens[count - 1].name != :atom
                return false
            end
            
            if tokens[count + 1].name != :atom and tokens[count + 1].name != :leftp and tokens[count + 1].name != :neg
                return false
            end

        end

        if tokens[count].name == :neg and count != 0

            if tokens[count - 1].name == :rightp or tokens[count - 1].name == :atom
                return false
            end

            if tokens[count + 1].name != :atom and tokens[count + 1].name != :leftp 
                return false
            end

            if count == sentence.length - 2
                return false
            end

        end

        count += 1
    end

    return true
end

def verify_atoms(sentence, tokens)

    count = 0

    while count < sentence.length - 1

        if tokens[count].name == :atom and count > 0 and count < sentence.length - 2

            if tokens[count - 1].name == :rightp
                return false
            end

            if tokens[count + 1].name == :leftp
                return false
            end

        end

        count += 1
    end

    return true
end

def normalize(sentence)
    
    sentence.tr(' ', '')
end

def verify_sentence(sentence)

    sentence = normalize(sentence)
    tokens = get_tokens sentence

    if tokens == false

        puts 'Falha na tokenização'
        return false

    elsif verify_parentheses(sentence, tokens) == false
        
        puts 'Falha na verificação de parênteses'
        return false

    elsif verify_simbols(sentence, tokens) == false   

        puts 'Falha na verificação de simbolos'
        return false
    

    elsif verify_atoms(sentence, tokens) == false   

        puts 'Falha na verificação de atomos'
        return false

    end

    return true

end



def main

    sentence = gets
    puts verify_sentence sentence

end
