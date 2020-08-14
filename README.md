# tyoeerUtils
Utility stuff for Löve2D the way I like things.
This is basically a collection of stuff I had a tendency to copy over, so the way things work and are documentated (if they are) differ.

# Initialization
```Lua
local TU = require("path.to.tyoeerUtils.folder")(require("path.to.middleclass"))
```
You have to pass a middleclass instance for the following two reasons:
1.	I wasn't in the mood to work with nested libraries because of having ot fulfill license terms
	(aka I didn't know where to include the license copy)
2.	I already use middleclass in my projects

You can load modules using direct requires after initialization, or with `TU("moduleName")` or `TU[moduleName]`
Trying to load stuff with direct requires before initialization does not come with proper error messages, and can fail quietly.
After initialization, you can also get the loader directly:
```Lua
local TU = require("path.to.tyoeerUtils")
```

# Modules:
-	`async`: system to limit how much of a function gets executing during a frame.
	Does not use OOP. Horribly undocumented, but it'sn't impossible to deduce the workings from the source code (I think).
-	`datastructures`: infinite grid and a stack.
	They both use their own OOP. Documentation in comments in the source file.
-	`entitypool`: datastructure providing fast adding, removal, and iteration.
	Uses external OOP. Documentation in comments in the source file.
-	`oop`: Wrapper around the middleclass class creater that makes the name optional (defaults to "Unnamed").
	Function signature is `Class([name,] [parent])` (figure out the , yourself).
-	`input`: Input manager that allows configurable actions depending on complex input-states.
	Does not use OOP on the public part, but does use OOP in some internals. Horribly undocumented.

# License

 tyoeerUtils by tyoeer is licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0).
