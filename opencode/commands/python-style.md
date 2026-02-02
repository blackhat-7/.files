# Code Guide
- Always think of a SHORT and SIMPLE solution. Avoid complexity where possible.
- Keep things generic and extensible. We need a BALANCE between SHORT and SIMPLE VS GENERIC and EXTENSIBLE.
- TYPE HINT always. Avoid using `any` type
- Never use blank `Exception`. check what specific exceptions need to be CAUGHT and what need to be RERAISED.
- use PYDANTIC classes to validate data interacting without outside code. Use DATACLASSES in other cases, never default python classes.
- use classes only when it makes sense eg. data models, too many args in a function, common logic/variables for multiple functions etc.
- AVOID OBVIOUS COMMENTS. comments should only be to explain AMBIGUOUS or COMPLEX logic

