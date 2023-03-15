#[
  The `when` statement is almost identical to the `if` statement, but with these differences:
  - Each condition must be a constant expression since it is evaluated by the compiler.
  - The statements within a branch do not open a new scope.
  - The compiler checks the semantics and produces code _only_ for the statements that belong to the first condition that evaluates to true.

  The when statement is useful for writing platform-specific code, similar to the `#ifdef` construct in the C programming language.
]#

echo "`when defined macosx:`"
when defined windows:
  echo "-> running on Windows!"
elif defined macosx:
  echo "-> running on macOS!"
elif defined linux:
  echo "-> running on Linux!"
else:
  echo "unknown operating system"

echo "\n--\n"

echo "`when hostOS == \"macosx\":`"
when hostOS == "windows":
  echo "-> running on Windows!"
elif hostOS == "macosx":
  echo "-> running on macOS!"
elif hostOS == "linux":
  echo "-> running on Linux!"
else:
  echo "unknown operating system"
