type
  # `RootObj` enables inheritance with runtime type information
  Person = ref object of RootObj
    name*: string # `*` allows other modules to access `name`
    age: int      # no `*` means that this field is hidden from other modules

                  # Student inherits from Person with an `id` field
  Student = ref object of Person
    id: int

var
  student: Student
  person: Person

assert student of Student # Hint: condition is always true

# object construction
student = Student(name: "Anton", age: 5, id: 2)

# echo student
# Error: type mismatch: got <Student>
# but expected one of:
# proc echo(x: varargs[typed, `$`])
#   first type mismatch at position: 1
#   required type for x: varargs[typed]
#   but expression 'student' is of type: Student

echo repr student
# ref 0x10cd05050 --> [id = 2,
# name = 0x10cd05090"Anton",
# age = 5]

echo student[]
# (id: 2, name: "Anton", age: 5)
