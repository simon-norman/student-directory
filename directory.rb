def print_aligned(text)
  puts text.center(100)
end

def input_students 
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  
  # create an empty array
  students = []
  
  # get the first name
  name = gets.chomp
  
  # while the name is not empty, repeat this code
  while !name.empty? do 
    # add the student hash to the array
    students << {name: name, cohort: :november}
    print_aligned("Now we have #{students.count} students")
    
    # get another name from the user
    name = gets.chomp
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