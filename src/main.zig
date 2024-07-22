const std = @import("std");

const Unit = enum {
    Miles,
    Kilometers,
    Fahrenheit,
    Celsius,
};

// Define an error for unknown unit
const Error = error{UnknownUnit};

fn parseUnit(unit: []const u8) !Unit {
    if (std.mem.eql(u8, unit, "miles")) {
        return Unit.Miles;
    } else if (std.mem.eql(u8, unit, "km")) {
        return Unit.Kilometers;
    } else if (std.mem.eql(u8, unit, "fahrenheit")) {
        return Unit.Fahrenheit;
    } else if (std.mem.eql(u8, unit, "celsius")) {
        return Unit.Celsius;
    } else {
        return Error.UnknownUnit;
    }
}
// main is the entry point into the program simlilar to <App/> in React
pub fn main() !void {
    // Get a writer for standard output. (stdout)
    const stdout = std.io.getStdOut().writer();

    // Allocate memory for command line arguments.
    const args = try std.process.argsAlloc(std.heap.page_allocator);

    // defer will ensure that the allocated memory is freed when the function exits
    // Notice that we access the function process.argsFree and the first argument is the page_allocator that was used to allocate the memory.
    // The second argument is the const args that we allocated.
    // This is similar to try/catch/finally in JS
    // Below is clean up code
    defer std.process.argsFree(std.heap.page_allocator, args);

    // Check if the correct number of argunments are passed
    // .len is used to get the length of the array
    // {} is used to interpolate the value of args[0] into the string
    if (args.len != 3) {
        try stdout.print("Usage: {s} <miles/km/fahrenheit/celsius> <value>\n", .{args[0]});
        return;
    }

    const unit = try parseUnit(args[1]);
    const value = try std.fmt.parseFloat(f64, args[2]);

    switch (unit) {
        Unit.Miles => try convertMilesToKm(stdout, value),
        Unit.Kilometers => try convertKmToMiles(stdout, value),
        Unit.Fahrenheit => try convertFtoC(stdout, value),
        Unit.Celsius => try convertCtoF(stdout, value),
    }
}

// Funtions for conversion

// Function to convert miles to km
// Its strange to me that stdout is passed as an argument
fn convertMilesToKm(stdout: anytype, miles: f64) !void {
    const km = miles * 1.60934;
    try stdout.print("{:.2} miles is {:.2} kilometers\n", .{ miles, km });
}

fn convertKmToMiles(stdout: anytype, km: f64) !void {
    const miles = km / 1.60934;
    try stdout.print("{:.2} kilometers is {:.2} miles\n", .{ km, miles });
}

fn convertFtoC(stdout: anytype, fahrenheit: f64) !void {
    const celsius = (fahrenheit - 32) * 5 / 9;
    try stdout.print("{:.2} Fahrenheit is {:.2} Celsius\n", .{ fahrenheit, celsius });
}

fn convertCtoF(stdout: anytype, celsius: f64) !void {
    const fahrenheit = celsius * 9 / 5 + 32;
    try stdout.print("{:.2} Celsius is {:.2} Fahrenheit\n", .{ celsius, fahrenheit });
}
