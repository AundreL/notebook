let
    message = "Hello, World!";
    value_a = 3;
    value_b = 20;
    addition = { x, y}: x + y;
in
    { message = message; value_a = value_a; value_b = value_b; value_c = addition { x=2; y=4;}; }
