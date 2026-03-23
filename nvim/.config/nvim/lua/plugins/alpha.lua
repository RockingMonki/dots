return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function ()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    -- The Graphic (ASCII Art)
    dashboard.section.header.val = {
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    }

    -- This clears the default "Find file", "New file", etc.
    dashboard.section.buttons.val = {}

    -- Optional: If you want to remove the footer (e.g., "75 plugins loaded")
    dashboard.section.footer.val = "Live a life of greatness!"

    alpha.setup(dashboard.opts)
  end
}
