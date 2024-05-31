local function ListModels()
    local cwd = vim.loop.cwd()
    local folder_path = cwd .. "/Models"

    local files = vim.fn.globpath(folder_path, "*", false, true)

    local filenames = {}
    for _, file in ipairs(files) do
        local filename = vim.fn.fnamemodify(file, ":t:r")
        table.insert(filenames, t(filename))
    end

    return filenames
end

local function models_choice(index)
    local models_table = ListModels()
    return c(index, models_table)
end

local function Models(args, _)
    return sn(nil, { t("@model "), c(1, {
            sn(nil, { i(1), models_choice(2) }),
            sn(nil, { i(1), t("List<"), models_choice(2), t(">") }),
            sn(nil, { i(1, "IEnumarable"), t("<"), models_choice(2), t(">") }),
        }) }, {})
end

return {
    s("mo", { d(1, Models) })
}
