pragma(inline, true) {
    auto create_mask(size_t start, size_t end) {
        return (1 << (end - start + 1)) - 1;
    }

    T bits(T)(T value, size_t start, size_t end) {
        auto mask = create_mask(start, end);
        return (value >> start) & mask;
    }

    bool bit(T)(T value, size_t index) {
        return (value >> index) & 1;
    }

    pure T rotate_right(T)(T value, size_t shift) 
    if (isIntegral!T) {
        return cast(T) ((value >> shift) | (value << (T.sizeof * 8 - shift)));
    }
}

struct MemoryUnit(T) {
    T value;
    
    alias value this;

    this(S)(S value) {
        this.value = cast(T) value;
    }
    
    this(T value) {
        this.value = value;
    }

    MemoryUnit!T opUnary(string s)() {
        return mixin(
            "MemoryUnit!T(" ~ s ~ "this.value)"
        );
    }

    MemoryUnit!T opBinary(string s)(MemoryUnit!T other) {
        return mixin(
            "MemoryUnit!T(this.value " ~ s ~ " other.value)"
        );
    }

    MemoryUnit!T opBinary(string s)(T other) {
        return mixin(
            "MemoryUnit!T(this.value " ~ s ~ " other)"
        );
    }

    MemoryUnit!T opSlice(size_t start, size_t end) {
        return MemoryUnit!T(this.value.bits(start, end));
    }

    bool opIndex(size_t index) {
        return this.value.bit(index) & 1;
    }

    T opCast(T)() {
        return cast(T) value;
    }

    MemoryUnit!T rotate_right(size_t shift) {
        return MemoryUnit!T(
            util.rotate_right(this.value, shift)
        );
    }

    void opSliceAssign(S)(S value_s, size_t start, size_t end) {
        T value = cast(T) value_s;

        auto mask = create_mask(start, end);
        value &= mask;

        this.value &= ~(mask << start);
        this.value |=  value << start;
    }

    void opIndexAssign(S)(S value_s, size_t index) {
        T value = cast(T) value_s;

        this.value &= ~(1     << index);
        this.value |=  (value << index);
    }

    void opIndexOpAssign(string s)(bool value, size_t index) {
        bool old_value = this.value.bit(index) & 1;
        mixin("bool new_value = old_value " ~ s ~ " value;");

        this.value &= ~(1         << index);
        this.value |=  (new_value << index);
    }

    void opAssign(S)(S value) {
        this.value = cast(T) value;
    }

    Byte get_byte(int i) {
        return Byte(value.bits(i * 8, (i + 1) * 8 - 1));
    }

    void set_byte(S)(int i, S b) {
        this.value &= ~(     0xFF  << 8 * i);
        this.value |=  ((b & 0xFF) << 8 * i);
    }
}
