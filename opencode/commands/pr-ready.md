# PR Ready
Make sure to go through each of the following list of things:
## General
- code is as short and minimalistic as possible, no unneeded code
- type hints always. Avoid using `any` type
- no useless comments, debug/print statements
- "Use early returns": Avoid else blocks and deep nesting by returning or continuing as soon as a condition is met.
- "No boilerplate": Explicitly forbid creating classes, interfaces, or complex design patterns if a simple function or primitive data structure (like a dictionary/object) can do the job.
- "Avoid local variables used once": Inline variables directly into the function call or return statement if they aren't needed for clarity elsewhere.
- no new LSP errors or warnings
- remove unused/duplicate imports

## Python
- No blank exception blocks. No meaningless raises if the code is already raising a specific exception.
- Use list comprehensions, any()/all(), and tuple unpacking if short and readable
- "Prefer ternary operators": Replace simple if/else blocks with a single ternary line if short and readable
- "Leverage built-ins": Instruct the AI to always use a standard library or built-in function (like sum(), map(), or filter()) instead of writing a manual for loop.
- Use with statements for resources that must be closed and wherever it is shorter and simpler
- no nested functions
