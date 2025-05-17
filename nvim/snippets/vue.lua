return {
  s(
    "scr",
    fmt(
      [[
    <script setup lang="ts">
      {}
    </script>
        ]],
      { i(0) }
    )
  ),
  s(
    "tem",
    fmt(
      [[
    <template>
      {}
    </template>
          ]],
      { i(0) }
    )
  ),

  s(
    "sty",
    fmt(
      [[
    <style scoped>{}</style>
  ]],
      { i(0) }
    )
  ),
}
