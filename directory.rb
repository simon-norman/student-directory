

def interactive_menu
  students = []
    
  loop do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
    
    selection = gets.chomp
    
    case selection
      when "1"
        students = input_students
      when "2"
        print_header
        print(students)
        print_footer(students)
      when "9"
        exit # this will cause the program to terminate
      else
        puts "I don't know what you meant, try again"
    end
  end
end

def input_students 
  students = []
    
  while true do
  
    puts "Please enter the name of a student"
    puts "To exit, enter 'exit'"
    name = user_input
  
    if name == 'exit'
      break
    end
    
    puts "Please enter the cohort of the student"
    puts "To exit, enter 'exit"
    cohort = user_input
    
    if cohort == 'exit'
      break
    end
      
    students << {name: name, cohort: cohort.to_sym}
    print_count(students)
  end
  
  students
end

def user_input
  while true do
    input = gets.sub("\n", "")
    
    if input == ""
      puts "This is an invalid response, please try again."
    else
      return input
    end
  end
end

def print_count(students)
  if students.count == 1
    puts "Now we have #{students.count} student"
  else
    puts "Now we have #{students.count} students"
  end
end

def print_header
  print_aligned("The students of Villains Academy")
  print_aligned("-------------")
end

def print_aligned(text)
  puts text.center(100)
end

def group_students_by_cohort(students)
  students_by_cohort = Hash.new { |hash, key| hash[key] = [] }
    
  students.map { |student| 
    students_by_cohort[student[:cohort].to_sym].push(student[:name])
  }
  
  return students_by_cohort
end

def print(students)
  students_by_cohort = group_students_by_cohort(students)
    
  students_by_cohort.each do |cohort, student_names|
    names_as_string = student_names.join(", ")
    print_aligned("#{cohort}: #{names_as_string}")
  end

end

def print_footer(students)
   print_aligned("Overall, we have #{students.count} great students")
end

interactive_menu