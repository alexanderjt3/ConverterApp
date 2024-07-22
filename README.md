# ConverterApp

ConverterApp is a simple command-line application written in Zig written to help me familiarize myself with the language. The application converts between different units of measurement: miles to kilometers, kilometers to miles, Fahrenheit to Celsius, and Celsius to Fahrenheit.

## Running and Using the Project

### Building

To build the project, run:

```sh
zig build
```

### Using the Project

To run the application, use:

#### Ex.

To convert 10 miles to kilometers:

```sh
zig-out/bin/ConverterApp miles 10
```

To convert 25 Celsius to Fahrenheit:

```sh
zig-out/bin/ConverterApp celsius 25
```

## Notes

### Why is stdout passed as an argument, would it be possible to redeclare or make it available to all functions?

- Passing `stdout` as an argument makes the functions more flexible and easier to test. By doing so, we can pass different writers (like a file writer) if needed without changing the function's internal logic.
- While it is possible to redeclare `stdout` within each function, it is not recommended as it can lead to code duplication and makes the code less flexible.
- An alternative is to declare `stdout` as a global variable, but this is generally discouraged in Zig because it can lead to issues with testability and side effects.

### Why does Zig not accept strings in switch statements?

- Zig does not support switching on strings because strings can be of arbitrary length, making it inefficient and complex to handle directly in a switch statement.
- Instead, Zig encourages the use of enums for fixed sets of values, which are more efficient and safer to use in switch statements.

### In a switch statement that uses the enum an error was thrown when we had an else statement because all conditions were matched, why is this so, it seems like it would be good practice.

- In Zig, switch statements on enums must cover all possible values explicitly. If an else statement is used, it is redundant and not allowed because the compiler ensures all enum cases are handled.
- This is designed to prevent unhandled cases, making the code more robust and explicit.

### What are the basic types in Zig, I see there is f64 and u8.

Zig has several basic types, including:

- Integers: `i8`, `u8`, `i16`, `u16`, `i32`, `u32`, `i64`, `u64`, `isize`, `usize`
- Floating-point: `f32`, `f64`
- Booleans: `bool`
- Pointers: `*T` (pointer to T), `[*]T` (slice of T), `[?]T` (nullable pointer to T)
- Arrays: `[N]T` (array of N elements of type T)
- Strings: `[]const u8` (constant string slice), `[]u8` (mutable string slice)

### The if statement uses std.mem.eql what does this mean, also why are the types needed in the if statement.

- `std.mem.eql` is a function that checks if two slices are equal, comparing their contents element by element.
- The types are needed to specify the element type of the slices being compared. In this case, `u8` indicates that the slices contain bytes.

### What is the effect of not using defer.

- Not using `defer` means that resources allocated within a function (like memory) may not be freed properly if the function exits early due to an error or return statement.
- `defer` ensures that cleanup code is executed regardless of how the function exits, preventing resource leaks and ensuring proper resource management.

### Explain this try stdout.print("{:.2} miles is {:.2} kilometers\n", .{ miles, km }); I don't understand the {:.2} specifically also why is the \n needed.

- `try stdout.print("{:.2} miles is {:.2} kilometers\n", .{ miles, km });`:
  - `try`: Ensures that any error returned by `stdout.print` is properly handled by propagating it up the call stack.
  - `stdout.print`: Function to print formatted output to standard output.
  - `{:.2}`: Format specifier for floating-point numbers, indicating that the number should be printed with 2 decimal places.
  - `\n`: Newline character, ensuring that the output moves to the next line after printing.
  - `.{ miles, km }`: List of arguments to be interpolated into the format string, similar to template literals in JavaScript.

## Usage

To build the project, run:

```sh
zig build
```
