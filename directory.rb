
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
        print_count(students)
      else
        puts "You have not entered all the required info, please try again."
      end
    end
  end
  
  students
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

def print(students)
  students_by_cohort = Hash.new { |hash, key| hash[key] = [] }
  
  students.map { |student| 
    students_by_cohort[student[:cohort].to_sym].push(student[:name])
  }
  
  students_by_cohort.each do |cohort, student_names|
    names_as_string = student_names.join(", ")
    print_aligned("#{cohort}: #{names_as_string}")
  end
end

def print_footer(students)
   print_aligned("Overall, we have #{students.count} great students")
end

students = input_students
print_header
print(students)
print_footer(students)