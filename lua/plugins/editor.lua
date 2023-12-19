return {
  "telescope.nvim",
  -- "nvim-telescope/telescope-file-browser",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
  },
  keys = {
    {
      "<leader>f1",
      function()
        local builtin = require("telescope.builtin")
        builtin.help_tags()
      end,
      desc = "설정 관련 도움말",
    },
    {
      "<leader>f2",
      function()
        local builtin = require("telescope.builtin")
        builtin.live_grep()
      end,
      desc = "루트 내 모든 파일의 내용 검색",
    },
    {
      "<leader>f3",
      function()
        local builtin = require("telescope.builtin")
        builtin.find_files({
          no_ignore = false,
          hidden = true,
        })
      end,
      desc = "파일 이름 검색",
    },
    {
      "<leader>f4",
      function()
        local builtin = require("telescope.builtin")
        builtin.buffers()
      end,
      desc = "최근 열었던 파일 목록",
    },
    {
      "<leader>f5",
      function()
        local builtin = require("telescope.builtin")
        builtin.resume()
      end,
      desc = "최근 열었던 파일 브라우저",
    },
    {
      "<leader>f6",
      function()
        require("telescope.builtin").find_files({
          cwd = require("lazy.core.config").options.root,
        })
      end,
      desc = "모든 플러그인 파일 검색",
    },
    {
      "<leader>f7",
      function()
        local builtin = require("telescope.builtin")
        builtin.diagnostics()
      end,
      desc = "Diagnostics 린트 진단",
    },
    {
      "<leader>f8",
      function()
        local builtin = require("telescope.builtin")
        builtin.treesitter()
      end,
      desc = "Treesitter Symbol 검색",
    },
    {
      ";;",
      function()
        local telescope = require("telescope")
        local function telescope_buffer_dir()
          return vim.fn.expand("%:p:h")
        end
        telescope.extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          layout_config = { height = 40 },
        })
      end,
      desc = "파일 브라우저 팝업",
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
        wrap_result = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          n = {},
        },
      })
      opts.pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      }
      opts.extensions = {
        file_browser = {
          theme = "dropdown",
          -- disalbled netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            ["n"] = {
              -- your custom normal mode mappings
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["/"] = function()
                vim.cmd("startinsert")
              end,
              ["<C-u>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
              ["<PageUp>"] = actions.preview_scrolling_up,
              ["<PageDown>"] = actions.preview_scrolling_downq,
            },
          },
        },
      }
      telescope.setup(opts)
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
    end,
  },
}
