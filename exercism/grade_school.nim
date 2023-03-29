import std/algorithm

type
  Student* = object
    name*: string
    grade*: int

  School* = object
    students*: seq[Student]

proc roster*(school: School): seq[string] =
  ## Returns the names of every student in the `school`, sorted by grade then name.

  # https://nim-lang.org/docs/algorithm.html#sortedByIt.t%2Cuntyped%2Cuntyped
  for s in school.students.sortedByIt((it.grade, it.name)):
    result.add(s.name)

proc addStudent*(school: var School, name: string, grade: int) =
  ## Adds a student with `name` and `grade` to the `school`.
  ##
  ## Raises a `ValueError` if `school` already contains a student named `name`.
  for s in school.students:
    if s.name == name: raise new ValueError
  school.students.add(Student(name: name, grade: grade))

proc grade*(school: School, grade: int): seq[string] =
  ## Returns the names of the students in the given `school` and `grade`, in
  ## alphabetical order.
  for s in school.students.sortedByIt(it.name):
    if s.grade == grade: result.add(s.name)

echo "students are sorted by name in a grade"
var school = School()
school.addStudent("Franklin", 5)
school.addStudent("Bradley", 5)
school.addStudent("Jeff", 1)
echo school.grade(5)
