return {
    s("tag", fmt([[<{}{}>{}</{}>]], { i(1), i(2), i(3), rep(1) })),
    s("stag", fmt([[<{}/>]], {i(1, "input")})),
    s("al", fmt([[<a asp-controller="{}" asp-action="{}">{}</a>]],
        { i(1, "controller"), i(2, "Index"), i(3, "Cheese") })),
    s("par", fmt([[<partial name="{}" {}>]], { i(1, "name"), i(2) })),
}
