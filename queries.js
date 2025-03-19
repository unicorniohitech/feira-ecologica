const queries = [
    {
        title: 'Listar todas as vendas com produtos e quantidades ',
        query: 'SELECT  v.id_venda,  v.data_venda,  u.nome AS cliente,  p.nome AS produto,  iv.quantidade,  iv.preco_unitario, (iv.quantidade * iv.preco_unitario) AS total_item FROM public.vendas v JOIN public.itens_venda iv ON v.id_venda = iv.id_venda JOIN public.produtos p ON iv.id_produto = p.id_produto JOIN public.usuario_login ul ON v.id_usuario = ul.id_usuario JOIN public.usuarios u ON ul.id_usuario = u.id_usuario ORDER BY v.data_venda DESC;'
    },

    {
        title: 'Produtos mais vendidos (ranking por quantidade total)',
        query: 'SELECT  p.nome AS produto, SUM(iv.quantidade) AS quantidade_vendida FROM public.itens_venda iv JOIN public.produtos p ON iv.id_produto = p.id_produto GROUP BY p.nome ORDER BY quantidade_vendida DESC;'
    },

    {
        title: 'Total de vendas (valor e quantidade) por cliente',
        query: 'SELECT  u.nome AS cliente, COUNT(DISTINCT v.id_venda) AS total_vendas, SUM(iv.quantidade * iv.preco_unitario) AS total_gasto FROM public.vendas v JOIN public.itens_venda iv ON v.id_venda = iv.id_venda JOIN public.usuario_login ul ON v.id_usuario = ul.id_usuario JOIN public.usuarios u ON ul.id_usuario = u.id_usuario GROUP BY u.nome ORDER BY total_gasto DESC;'
    },

    {
        title: 'Total vendido por vendedor',
        query: 'SELECT  ve.nome AS vendedor, SUM(iv.quantidade * iv.preco_unitario) AS total_vendido, COUNT(DISTINCT v.id_venda) AS total_vendas FROM public.vendas v JOIN public.itens_venda iv ON v.id_venda = iv.id_venda JOIN public.produtos p ON iv.id_produto = p.id_produto JOIN public.vendedores ve ON p.id_vendedor = ve.id_vendedor GROUP BY ve.nome ORDER BY total_vendido DESC;'
    },

    {
        title: 'Pagamentos realizados por método de pagamento',
        query: "SELECT  mp.nome_metodo AS metodo_pagamento, SUM(pg.valor_total) AS total_pago FROM public.pagamentos pg JOIN public.metodos_pagamento mp ON pg.id_metodo_pagamento = mp.id_metodo_pagamento WHERE pg.status_pagamento = 'realizado' GROUP BY mp.nome_metodo ORDER BY total_pago DESC;"
    },

    {
        title: 'Diagnóstico de nomes de vendedores cadastrados ',
        query: 'SELECT id_vendedor, nome FROM public.vendedores;'
    },

    {
        title: 'Listar todos os usuarios',
        query: 'SELECT id_usuario, nome, telefone, endereco FROM usuarios;'
    },

    {
        title: 'Listar todas as vendas feitas por um usuário específico',
        query: 'SELECT * FROM vendas WHERE id_usuario = 12; '
    },

    {
        title: 'Produtos vendidos por cada vendedor:',
        query: 'SELECT v.nome AS vendedor, p.nome AS produto, p.quantidade_estoque FROM produtos p JOIN vendedores v ON p.id_vendedor = v.id_vendedor;'
    },

    // {
    //     title: 'Inserir um novo usuário:',
    //     query: "INSERT INTO usuario_login (email, senha_hash) VALUES ('usuario@example.com', 'senha123');"
    // },
    // {
    //     title: 'Inserir um novo usuário:',
    //     query: "INSERT INTO usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES ((SELECT id_usuario FROM usuario_login WHERE email = 'usuario@example.com'), 'João Silva', '(11) 91234-5678', 'Rua das Flores, 123', '1990-01-01');"
    // },

    // {
    //     title: 'Inserir um novo usuário:',
    //     query: "INSERT INTO vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (1, 1);"
    // },

    // {
    //     title: 'Atualizar telefone de um usuário:',
    //     query: "UPDATE usuarios SET telefone = '(11) 99876-5432' WHERE id_usuario = 1;"
    // },

    // {
    //     title: 'Atualizar status de pagamento:',
    //     query: "UPDATE pagamentos SET status_pagamento = 'cancelado' WHERE id_pagamento = 1;"
    // },

    // {
    //     title: 'Remover um item específico de uma venda:',
    //     query: 'DELETE FROM itens_venda WHERE id_venda = --id-- AND id_produto = --id--;'
    // },
    //   {
    //     title: 'Associar um vendedor a um fornecedor:',
    //     query: 'INSERT INTO vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (1, 1);'
    // }
]


module.exports = {
    queries
};