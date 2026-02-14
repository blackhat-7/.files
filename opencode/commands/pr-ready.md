# PR Ready
Make sure to go through each of the following list of things:
## General
- Prefer concise and brief code, no unused code
- Proactively suggest code shortening opportunities (inline variables, remove redundant logic, use built-ins)
- Flag verbose code patterns and suggest more concise alternatives
- Prefer idiomatic programming: look for things that novices miss but experts don't
- type hints always. Avoid using `any` type
- no useless comments, debug/print statements
- "Use early returns": Avoid else blocks and deep nesting by returning or continuing as soon as a condition is met.
- "Use classes when beneficial": Write classes if they lead to better code reuse, but prefer simple functions or primitives when they suffice.
- use PYDANTIC classes to validate data interacting without outside code. Use DATACLASSES in other cases, never default python classes.
- "Avoid local variables used once": Inline variables directly into the function call or return statement if they aren't needed for clarity elsewhere.
- no new LSP errors or warnings
- Treat your users like experienced programmers

## Python
- No blank exception blocks. No meaningless raises if the code is already raising a specific exception.
- Prefer specific exception types and custom domain exceptions; avoid bare except: or except Exception:
- Use list comprehensions, any()/all(), and tuple unpacking if short and readable
- "Prefer ternary operators": Replace simple if/else blocks with a single ternary line if short and readable
- "Leverage built-ins": prefer using standard library or built-in function (like sum(), map(), or filter()) instead of writing a manual for loop if readable.
- Use context managers (with statements) wherever applicable
- no nested functions

## Golang
- No errors using the blank identifier
- convert strings to constants or enums as required if used multiple times
