return {
  'norcalli/nvim-colorizer.lua',
  lazy = false,
  config = function()
    -- Attaches to every FileType mode
    require 'colorizer'.setup()

    -- require("colorizer").setup({
    --   '*'; -- Highlight all files, but customize some others.
    --   '!vim'; -- Exclude vim from highlighting.
    --   '!markdown'; -- Exclude markdown from highlighting.
    --   '!text'; -- Exclude text from highlighting.
    --   '!html'; -- Exclude html from highlighting.
    --   '!css'; -- Exclude css from highlighting.
    --   '!javascript'; -- Exclude javascript from highlighting.
    --   '!typescript'; -- Exclude typescript from highlighting.
    -- }, {
    --   RGB = true;         -- #RGB hex codes
    --   RRGGBB = true;     -- #RRGGBB hex codes
    --   names = false;     -- "Name" codes like Blue or blue
    --   RRGGBBAA = true;   -- #RRGGBBAA hex codes
    --   rgb_fn = true;     -- CSS rgb() and rgba() functions
    --   hsl_fn = true;     -- CSS hsl() and hsla() functions
    -- })
  end,
}
