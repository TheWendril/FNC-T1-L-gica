require_relative 'q1'


def get_left_first_ocurrency(sentence, count, symbol)

    auxCount = count

    while auxCount > 0 
        
        if sentence[auxCount] == symbol    
            return auxCount
        end
        auxCount -= 1
    end 

    return 0
end

def get_right_first_ocurrency(sentence, count, symbol)

    auxCount = count

    while auxCount < sentence.length - 1
        
        if sentence[auxCount] == symbol    
            return auxCount
        end
        auxCount += 1
    end 

    return sentence.length - 1
end

def inside_p?(sentence, count)

    auxCount = count 

    while auxCount >= 0 

        if sentence[auxCount] == ')'
            return false
        end

        if sentence[auxCount] == '(' 
            return true
        end

        auxCount -= 1
    end

    return false

end

def remove_impl(sentence)

    count = 0

    while count < sentence.length - 1

        if sentence[count] == '>'

            auxA = nil
            auxB = nil

            if inside_p?(sentence, count)

                left_p = get_left_first_ocurrency(sentence, count, '(')
                right_p = get_right_first_ocurrency(sentence, count, ')')

                auxA = sentence[left_p, count - left_p]
                auxA.sub!('(', '')
            
                auxB = sentence[count + 1, right_p - count - 1]
               
                auxA.insert 0, '-('
                auxA.insert auxA.size, ')'

                sentence.gsub!(sentence[left_p + 1, right_p - left_p - 1], auxA + '#' + auxB)

            else

                auxA = sentence[get_left_first_ocurrency(sentence, count - 1, '>'), count]
                
                auxA.insert 0, '-('
                auxA.insert auxA.size, ')'
      
                auxB = sentence[count + 1, sentence.length - 1]

                sentence = auxA + '#' + auxB
  
            end

        end 

        count +=1
    end
    
    return sentence

end




def remove_complex_neg(sentence)

    count = 0

    while count < sentence.length - 1

        if sentence[count] == '-' and sentence[count + 1] == '('

            sentence.slice!(count)

            left_p = count + 1
            right_p = get_right_first_ocurrency(sentence, count, ')')

            auxcount = left_p

            while auxcount < right_p

       
                if sentence[auxcount].match(/[a-z]/)
                    sentence.insert(auxcount, '-')
                    auxcount += 1
                    count += 1
                    right_p = get_right_first_ocurrency(sentence, auxcount, ')')
                end

                if sentence[auxcount] == '#'
                    sentence[auxcount] = '&'

                elsif sentence[auxcount] == '&'
                    sentence[auxcount] = '#'
                end

                auxcount += 1

            end

        end
    
        count += 1
    end

    return sentence
end



def remove_duplicate_neg(sentence)

    count = 0

    while count < sentence.length - 1

        if sentence[count] == '-' and sentence[count + 1] == '-'
            sentence.slice!(count)
            sentence.slice!(count)
        end

        count += 1

    end

end

def separate_subforms(sentence)

end

def apply_dist(sentence)

end


sentence = gets
sentence = normalize(sentence)  
a = remove_impl(sentence)
remove_duplicate_neg remove_complex_neg(a)
puts a