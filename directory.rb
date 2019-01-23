def print_aligned(text)
  puts text.center(100)
end

def input_students 
  students = []
  puts "Please enter the name of students and their cohort
      separated by a comma and space (e.g. 'Tom, November'"
  puts "To finish, just hit return twice"
    
  while true do
  
    input = gets.chomp
    if input.empty?
      break
    else
      student = input.split(", ")
      
      if student[0] && student[1]
        students << {name: student[0], cohort: student[1].to_sym}
        puts "Now we have #{students.count} students"
      else
        puts "You have not entered all the required info, please try again."
      end
    end
  end
  
  students
end

def print_header
  print_aligned("The students of Villains Academy")
  print_aligned("-------------")
end

def print(students)
  index = 0
  
  while index < students.length
    student = students[index]
    
    print_aligned("The details for each student are as follows: ")
    if student[:name].start_with?("A") && student[:name].length < 12
      student.each do |key, value|
  
        print_aligned("#{key}: #{value}")
      end
    end
    
    index += 1
  end
  
end

def print_footer(students)
   print_aligned("Overall, we have #{students.count} great students")
end

students = input_students
print_header
print(students)
print_footer(students)