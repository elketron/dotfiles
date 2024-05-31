return {
    s("if", fmt([[
        @if (<>)
        {
            <>
        }
    ]], { i(1, "condition"), i(2) }, { delimiters = "<>" })),
    s("eif", fmt([[
        else if (<>)
        {
            <>
        }
    ]], { i(1, "condition"), i(2) }, { delimiters = "<>" })),
    s("sw", fmt([[
        @switch (<>)
        {
            <>
        }
    ]], { i(1, "value"), i(2) }, { delimiters = "<>" })),
    s("ca", fmt([[
        case <>:
            <>
            break;
    ]], { i(1, "value"), i(2) }, { delimiters = "<>" })),

}
