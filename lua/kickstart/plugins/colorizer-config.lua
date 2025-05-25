return {
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      -- require('colorizer').setup()
      require('colorizer').setup({
        '*',
      }, {
        RGB = true, -- #RGB hex codes #00f
        RRGGBB = true, -- #RRGGBB hex codes #0000ff
        names = true, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes #0000ffff
        rgb_fn = true, -- CSS rgb() and rgba() functions rgb(0,0,255)
        hsl_fn = true, -- CSS hsl() and hsla() functions hsl(240, 100%, 50%)
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        mode = 'background', -- Set the display mode.
      })
    end,
  }, -- hex
}
