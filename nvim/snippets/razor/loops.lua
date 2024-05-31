return {
    s("for", fmt([[
        @for (var <> = <>; <> << <>; <>++)
        {
            <>
        }
    ]],
        { i(1, "i"), i(2, "0"), rep(1), i(3), rep(1), i(4) },
        { delimiters = "<>" })
    ),
    s("fe", fmt([[
        @foreach(var <> in <>)
        {
            <>
        }
    ]],
        { i(1, "item"), i(2, "collection"), i(3) },
        { delimiters = "<>" })
    ),
    s("wh", fmt([[
        @{ var <> = <>;}
        @while (<> << <>)
        {
            <>
        }
    ]],
        { i(1, "i"), i(2, "0"), rep(1), i(3), i(4) },
        { delimiters = "<>" })
    ),
}
