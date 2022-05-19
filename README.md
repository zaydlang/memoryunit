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
Word foo = 0x1234;
writefln(foo[0]);    // prints out bit 0 of foo, which is 0
writefln(foo[2]);    // prints out bit 2 of foo, which is 1
writefln(foo[7..9]); // prints out bits 7-9 (inclusive) of foo, which is 4

foo[30] = 0;         // sets bit 30 of foo to 0
foo[28..29] = 1;     // sets bits 28-29 of foo to 3
writefln(foo);       // prints out 0x3234
```
