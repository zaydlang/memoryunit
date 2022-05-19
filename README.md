# memoryunit
A D-library for easy bitmanip

MemoryUnit allows you to create wrapper types over integers. Here's an example of how to create your own MemoryUnit types:
```D
alias Word = MemoryUnit!uint;
alias Half = MemoryUnit!ushort;
alias Byte = MemoryUnit!ubyte;
```

This creates three types, Word/Half/Byte, which are wrappers over the types uint/ushort/ubyte.

You can now use them like so:
```D
Half foo = 0x1234;
writeln(foo[0]);    // prints out bit 0 of foo, which is 0
writeln(foo[2]);    // prints out bit 2 of foo, which is 1
writeln(foo[7..9]); // prints out bits 7-9 (inclusive) of foo, which is 4

foo[15] = 0;         // sets bit 15 of foo to 0
foo[13..14] = 3;     // sets bits 13-14 of foo to 3
writeln(foo);       // prints out 0x7234 (29236 in decimal)
```

The cool part is that, when compiling with optimizations on, this library incurs no additional overhead compared to manual bitmanip (via bitwise ands / ors and whatnot).

Feel free to contribute! :)
