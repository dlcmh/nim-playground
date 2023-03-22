type
  Person = ref object of RootObj # `RootObj` enables inheritance with runtime type information
    name*: string # `*` allows other modules to access `name`
