return {
  'stevearc/overseer.nvim',
  ---@module 'overseer'
  ---@type overseer.SetupOpts
  opts = {
    task_list = {
      direction = 'left',
      max_width = { 80, 0.4 },
      min_width = 40,
      min_height = 8,
    },
  },
  keys = {
    { '<leader>oo', '<cmd>OverseerToggle<cr>', desc = 'Overseer Toggle' },
    { '<leader>op', '<cmd>OverseerRun<cr>', desc = 'Overseer Pick' },
    { '<leader>or', function() local o = require('overseer'); o.run_task({tags = {o.TAG.RUN}, first = true}) end, desc = 'Run' },
    { '<leader>ob', function() local o = require('overseer'); o.run_task({tags = {o.TAG.BUILD}, first = true}) end, desc = 'Build' },
    { '<leader>ot', function() local o = require('overseer'); o.run_task({tags = {o.TAG.TEST}, first = true}) end, desc = 'Test' },
    { '<leader>oa', '<cmd>OverseerTaskAction<cr>', desc = 'Overseer Action' },
    { '<leader>os', '<cmd>OverseerShell<cr>', desc = 'Overseer Shell' },
  },
}
