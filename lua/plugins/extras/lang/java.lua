local status_cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status_cmp_ok then
    return
end

capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

local status, jdtls = pcall(require, 'jdtls')
if not status then
    return
end

local mason_data_dir = vim.fn.stdpath('data') .. '/mason'
JDTLS_PATH = mason_data_dir .. '/packages/jdtls'

-- Determine OS
local home = os.getenv('HOME')
WORKSPACE_PATH = home .. '/workspace/'

if vim.fn.has('mac') == 1 then
    CONFIG = 'mac'
elseif vim.fn.has('unix') == 1 then
    CONFIG = 'linux'
else
    CONFIG = 'win'
end

-- Find root of project
local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers)
if root_dir == '' then
    return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = WORKSPACE_PATH .. project_name

-- TODO: Testing

JAVA_DAP_ACTIVE = true

local bundles = {}

if JAVA_DAP_ACTIVE then
    vim.list_extend(
        bundles,
        vim.split(
            vim.fn.glob(home .. '/source/repos/vscode-java-test/server/*.jar'),
            '\n'
        )
    )
    vim.list_extend(
        bundles,
        vim.split(
            vim.fn.glob(
                home
                    .. '/source/repos/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'
            ),
            '\n'
        )
    )
end

vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
)
vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
)
vim.cmd(
    "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
)
vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")

return {
    {
        'mfussenegger/nvim-jdtls',
        ft = { 'java' },
        opts = {
            -- The command that starts the language server
            -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
            cmd = {
                -- 'jdtls.cmd',

                -- 💀
                'java', -- or '/path/to/java11_or_newer/bin/java'
                -- depends on if `java` is in your $PATH env variable and if it points to the right version.

                '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                '-Dosgi.bundles.defaultStartLevel=4',
                '-Declipse.product=org.eclipse.jdt.ls.core.product',
                '-Dlog.protocol=true',
                '-Dlog.level=ALL',
                '-javaagent:' .. JDTLS_PATH .. '/lombok.jar',
                '-Xms1g',
                '--add-modules=ALL-SYSTEM',
                '--add-opens',
                'java.base/java.util=ALL-UNNAMED',
                '--add-opens',
                'java.base/java.lang=ALL-UNNAMED',

                -- 💀
                '-jar',
                vim.fn.glob(
                    JDTLS_PATH .. '/plugins/org.eclipse.equinox.launcher_*.jar'
                ),
                -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
                -- Must point to the                                                     Change this to
                -- eclipse.jdt.ls installation                                           the actual version

                -- 💀
                '-configuration',
                JDTLS_PATH .. '/config_' .. CONFIG,
                -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                -- Must point to the                      Change to one of `linux`, `win` or `mac`
                -- eclipse.jdt.ls installation            Depending on your system.

                -- 💀
                -- See `data directory configuration` section in the README
                '-data',
                workspace_dir,
            },

            on_attach = function(client, buffer)
                local lsp_utils = require('plugins.lsp.utils')
                lsp_utils.on_attach(function(client, buffer)
                    -- do some stuff here, keymap maybe?
                    -- local opts = { silent = true, noremap = true }
                    --
                    --
                    local Remap = require('keymap')
                    local nnoremap = Remap.nnoremap
                    local vnoremap = Remap.vnoremap
                    nnoremap(
                        '<leader>lo',
                        require('jdtls').organize_imports,
                        opts
                    )
                    nnoremap(
                        '<leader>lev',
                        require('jdtls').extract_variable,
                        opts
                    )
                    nnoremap(
                        '<leader>lec',
                        require('jdtls').extract_constant,
                        opts
                    )
                    nnoremap(
                        '<leader>lem',
                        require('jdtls').extract_method,
                        opts
                    )
                    nnoremap(
                        '<leader>lt',
                        require('jdtls').test_nearest_method,
                        opts
                    )
                    nnoremap('<leader>lT', require('jdtls').test_class, opts)
                    nnoremap('<leader>lu', '<cmd>JdtUpdateConfig<CR>', opts)

                    vnoremap(
                        '<leader>lev',
                        "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
                        opts
                    )

                    vnoremap(
                        '<leader>lec',
                        "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>",
                        opts
                    )

                    vnoremap(
                        '<leader>lem',
                        "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>",
                        opts
                    )
                end)
            end,

            capabilities = capabilities,

            -- 💀
            -- This is the default if not provided, you can remove it. Or adjust as needed.
            -- One dedicated LSP server & client will be started per unique root_dir
            root_dir = root_dir,

            -- Here you can configure eclipse.jdt.ls specific settings
            -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
            -- or https://github.com/redhat-developer/vscode-java#supported-vs-code-settings
            -- for a list of options
            settings = {
                java = {
                    -- jdt = {
                    --   ls = {
                    --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
                    --   }
                    -- },
                    eclipse = {
                        downloadSources = true,
                    },
                    configuration = {
                        updateBuildConfiguration = 'interactive',
                    },
                    maven = {
                        downloadSources = true,
                    },
                    implementationsCodeLens = {
                        enabled = true,
                    },
                    referencesCodeLens = {
                        enabled = true,
                    },
                    references = {
                        includeDecompiledSources = true,
                    },
                    inlayHints = {
                        parameterNames = {
                            enabled = 'all', -- literals, all, none
                        },
                    },
                    format = {
                        enabled = false,
                        -- settings = {
                        --   profile = "asdf"
                        -- }
                    },
                },
                signatureHelp = { enabled = true },
                completion = {
                    favoriteStaticMembers = {
                        'org.hamcrest.MatcherAssert.assertThat',
                        'org.hamcrest.Matchers.*',
                        'org.hamcrest.CoreMatchers.*',
                        'org.junit.jupiter.api.Assertions.*',
                        'java.util.Objects.requireNonNull',
                        'java.util.Objects.requireNonNullElse',
                        'org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.*',
                        'org.mockito.Mockito.*',
                    },
                    guessMethodArguments = true,
                },
                contentProvider = { preferred = 'fernflower' },
                extendedClientCapabilities = extendedClientCapabilities,
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                    },
                },
                codeGeneration = {
                    toString = {
                        template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                    },
                    useBlocks = true,
                },
            },

            flags = {
                allow_incremental_sync = true,
            },

            -- Language server `initializationOptions`
            -- You need to extend the `bundles` with paths to jar files
            -- if you want to use additional eclipse.jdt.ls plugins.
            --
            -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
            --
            -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
            init_options = {
                -- bundles = {},
                bundles = bundles,
            },
        },
        config = function(_, config)
            local root_markers =
                { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
            local root_dir = require('jdtls.setup').find_root(root_markers)
            if root_dir == '' then
                return
            end

            local jdtls = require('jdtls')

            -- jdtls.start_or_attach(config)
        end,
    },
}
