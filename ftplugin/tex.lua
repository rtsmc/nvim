vim.keymap.set("n", "<leader>c", vim.cmd.VimtexCompile)

--navigation keybind
vim.keymap.set({"i", "n", "v"}, ";;", '<Esc>/(<++>)<Enter>"_c6l')

--multiplication symbol
vim.keymap.set("i", ";*", '\\cdot')

--double quad
vim.keymap.set("i", ";2q", '\\quad \\quad')

--matrices (with brackets)
vim.keymap.set("i", ";bm", '\\begin{bmatrix}<Enter><Enter>\\end{bmatrix}<Esc>ki<Tab>')

--noindent
vim.keymap.set("i", ";ni", '\\noindent ')

--cursive math letters
vim.keymap.set("i", ";ms", '\\mathscr{}(<++>)<Esc>F}i')

--power
vim.keymap.set("i", ";^", '^{}(<++>)<Esc>F}i')

--relations
vim.keymap.set("i", ";op", '(),(<++>)<Esc>F)i')
vim.keymap.set("i", ";R", '\\mathrel{R}')
vim.keymap.set("i", ";nR", '\\not\\mathrel{R}')

--vertical space keybind
vim.keymap.set("i", ";vs", '\\vspace{}(<++>)<Esc>F}i')

vim.keymap.set("i", ";mb", '\\mathbb{}(<++>)<Esc>F}i')

--quantifiers
vim.keymap.set("i", ";fa", '\\forall')
vim.keymap.set("i", ";ex", '\\exists')

--emphasis
vim.keymap.set("i", ";em", '\\emph{}<Esc>i')
--enumerate
vim.keymap.set("i", ";en", '\\begin{enumerate}[]<Enter>\\item<Space>(<++>)<Enter>\\end{enumerate}<Esc>kkf]i')
--aligned
vim.keymap.set("i", ";al", '\\[<Enter>\\begin{aligned}<Enter>\\end{aligned}<Enter>\\]<Esc>kko')


--math mode
vim.keymap.set("i", ";mm", '\\[\\](<++>)<Esc>F\\i')
--inline math mode
vim.keymap.set("i", ";mi", '\\(\\)(<++>)<Esc>F\\i')
--left and right parenthesis
vim.keymap.set("i", ";(", '\\left(')
vim.keymap.set("i", ";)", '\\right)')

--sum
vim.keymap.set("i", ";su", '\\sum_{}^{(<++>)}(<++>)<Esc>F}F}i')
--integral
vim.keymap.set("i", ";in", '\\int_{}^{(<++>)}(<++>)<Esc>F}F}i')
--fraction
vim.keymap.set("i", ";fr", '\\frac{}{(<++>)}(<++>)<Esc>F}F}i')

--infinity
vim.keymap.set("i", ";if", '\\infty')
--alpha
vim.keymap.set("i", ";alpha", '\\alpha')
--beta
vim.keymap.set("i", ";beta", '\\beta')
--gamma
vim.keymap.set("i", ";gamma", '\\gamma')
--delta
vim.keymap.set("i", ";delta", '\\delta')
--epsilon
vim.keymap.set("i", ";epsilon", '\\epsilon')
--zeta
vim.keymap.set("i", ";zeta", '\\zeta')
--eta
vim.keymap.set("i", ";eta", '\\eta')
--theta
vim.keymap.set("i", ";theta", '\\theta')
--iota
vim.keymap.set("i", ";iota", '\\iota')
--phi
vim.keymap.set("i", ";phi", '\\phi')
--kappa
vim.keymap.set("i", ";kappa", '\\kappa')
--lambda
vim.keymap.set("i", ";lambda", '\\lambda')
--mu
vim.keymap.set("i", ";mu", '\\mu')
--pi
vim.keymap.set("i", ";pi", '\\pi')
--sigma
vim.keymap.set("i", ";sigma", '\\sigma')

--comparison/plusminus signs
vim.keymap.set("i", "<=", '\\leq')
vim.keymap.set("i", ">=", '\\geq')
vim.keymap.set("i", "+-", '\\pm')
vim.keymap.set("i", "-+", '\\mp')

--important symbols
vim.keymap.set("i", ";to", '\\to')
vim.keymap.set("i", ";not", '\\neg')
vim.keymap.set("i", ";and", '\\land')
vim.keymap.set("i", ";or", '\\lor')

--root symbol
vim.keymap.set("i", ";sq", '\\sqrt{}(<++>)<Esc>F}i')
