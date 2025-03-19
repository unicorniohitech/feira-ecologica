CREATE FUNCTION public.atualizar_estoque() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE public.produtos
    SET quantidade_estoque = quantidade_estoque - NEW.quantidade
    WHERE id_produto = NEW.id_produto;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.atualizar_estoque() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 17026)
-- Name: administradores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.administradores (
    id_admin integer NOT NULL,
    nome character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    senha_hash text NOT NULL,
    data_cadastro timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.administradores OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17025)
-- Name: administradores_id_admin_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.administradores_id_admin_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.administradores_id_admin_seq OWNER TO postgres;

--
-- TOC entry 4963 (class 0 OID 0)
-- Dependencies: 220
-- Name: administradores_id_admin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.administradores_id_admin_seq OWNED BY public.administradores.id_admin;


--
-- TOC entry 223 (class 1259 OID 17038)
-- Name: fornecedores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fornecedores (
    id_fornecedor integer NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(20),
    email character varying(255)
);


ALTER TABLE public.fornecedores OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17037)
-- Name: fornecedores_id_fornecedor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fornecedores_id_fornecedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fornecedores_id_fornecedor_seq OWNER TO postgres;

--
-- TOC entry 4964 (class 0 OID 0)
-- Dependencies: 222
-- Name: fornecedores_id_fornecedor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fornecedores_id_fornecedor_seq OWNED BY public.fornecedores.id_fornecedor;


--
-- TOC entry 235 (class 1259 OID 17131)
-- Name: itens_venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.itens_venda (
    id_venda integer NOT NULL,
    id_produto integer NOT NULL,
    quantidade integer NOT NULL,
    preco_unitario numeric(10,2) NOT NULL,
    CONSTRAINT itens_venda_quantidade_check CHECK ((quantidade > 0))
);


ALTER TABLE public.itens_venda OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17084)
-- Name: metodos_pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.metodos_pagamento (
    id_metodo_pagamento integer NOT NULL,
    nome_metodo character varying(50) NOT NULL
);


ALTER TABLE public.metodos_pagamento OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17083)
-- Name: metodos_pagamento_id_metodo_pagamento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.metodos_pagamento_id_metodo_pagamento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metodos_pagamento_id_metodo_pagamento_seq OWNER TO postgres;

--
-- TOC entry 4965 (class 0 OID 0)
-- Dependencies: 229
-- Name: metodos_pagamento_id_metodo_pagamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.metodos_pagamento_id_metodo_pagamento_seq OWNED BY public.metodos_pagamento.id_metodo_pagamento;


--
-- TOC entry 234 (class 1259 OID 17112)
-- Name: pagamentos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagamentos (
    id_pagamento integer NOT NULL,
    id_venda integer NOT NULL,
    id_metodo_pagamento integer NOT NULL,
    valor_total numeric(10,2) NOT NULL,
    status_pagamento character varying(20) NOT NULL,
    CONSTRAINT pagamentos_status_pagamento_check CHECK (((status_pagamento)::text = ANY ((ARRAY['pendente'::character varying, 'realizado'::character varying, 'cancelado'::character varying])::text[])))
);


ALTER TABLE public.pagamentos OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17111)
-- Name: pagamentos_id_pagamento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pagamentos_id_pagamento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pagamentos_id_pagamento_seq OWNER TO postgres;

--
-- TOC entry 4966 (class 0 OID 0)
-- Dependencies: 233
-- Name: pagamentos_id_pagamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pagamentos_id_pagamento_seq OWNED BY public.pagamentos.id_pagamento;


--
-- TOC entry 228 (class 1259 OID 17071)
-- Name: produtos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produtos (
    id_produto integer NOT NULL,
    nome character varying(255) NOT NULL,
    preco_unitario numeric(10,2) NOT NULL,
    quantidade_estoque integer NOT NULL,
    id_vendedor integer NOT NULL,
    CONSTRAINT produtos_quantidade_estoque_check CHECK ((quantidade_estoque >= 0))
);


ALTER TABLE public.produtos OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17070)
-- Name: produtos_id_produto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produtos_id_produto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produtos_id_produto_seq OWNER TO postgres;

--
-- TOC entry 4967 (class 0 OID 0)
-- Dependencies: 227
-- Name: produtos_id_produto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produtos_id_produto_seq OWNED BY public.produtos.id_produto;


--
-- TOC entry 218 (class 1259 OID 17002)
-- Name: usuario_login; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_login (
    id_usuario integer NOT NULL,
    email character varying(255) NOT NULL,
    senha_hash text NOT NULL,
    data_criacao timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.usuario_login OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17001)
-- Name: usuario_login_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_login_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_login_id_usuario_seq OWNER TO postgres;

--
-- TOC entry 4968 (class 0 OID 0)
-- Dependencies: 217
-- Name: usuario_login_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_login_id_usuario_seq OWNED BY public.usuario_login.id_usuario;


--
-- TOC entry 219 (class 1259 OID 17013)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(20),
    endereco text,
    data_nascimento date
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17093)
-- Name: vendas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendas (
    id_venda integer NOT NULL,
    id_usuario integer NOT NULL,
    data_venda timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    valor_total numeric(10,2) NOT NULL
);


ALTER TABLE public.vendas OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17092)
-- Name: vendas_id_venda_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendas_id_venda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendas_id_venda_seq OWNER TO postgres;

--
-- TOC entry 4969 (class 0 OID 0)
-- Dependencies: 231
-- Name: vendas_id_venda_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendas_id_venda_seq OWNED BY public.vendas.id_venda;


--
-- TOC entry 225 (class 1259 OID 17047)
-- Name: vendedores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendedores (
    id_vendedor integer NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(20),
    sitio character varying(255) NOT NULL,
    localizacao text,
    certificacoes text
);


ALTER TABLE public.vendedores OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17055)
-- Name: vendedores_fornecedores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendedores_fornecedores (
    id_vendedor integer NOT NULL,
    id_fornecedor integer NOT NULL
);


ALTER TABLE public.vendedores_fornecedores OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17046)
-- Name: vendedores_id_vendedor_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendedores_id_vendedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendedores_id_vendedor_seq OWNER TO postgres;

--
-- TOC entry 4970 (class 0 OID 0)
-- Dependencies: 224
-- Name: vendedores_id_vendedor_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendedores_id_vendedor_seq OWNED BY public.vendedores.id_vendedor;


--
-- TOC entry 4745 (class 2604 OID 17029)
-- Name: administradores id_admin; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administradores ALTER COLUMN id_admin SET DEFAULT nextval('public.administradores_id_admin_seq'::regclass);


--
-- TOC entry 4747 (class 2604 OID 17041)
-- Name: fornecedores id_fornecedor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedores ALTER COLUMN id_fornecedor SET DEFAULT nextval('public.fornecedores_id_fornecedor_seq'::regclass);


--
-- TOC entry 4750 (class 2604 OID 17087)
-- Name: metodos_pagamento id_metodo_pagamento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metodos_pagamento ALTER COLUMN id_metodo_pagamento SET DEFAULT nextval('public.metodos_pagamento_id_metodo_pagamento_seq'::regclass);


--
-- TOC entry 4753 (class 2604 OID 17115)
-- Name: pagamentos id_pagamento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamentos ALTER COLUMN id_pagamento SET DEFAULT nextval('public.pagamentos_id_pagamento_seq'::regclass);


--
-- TOC entry 4749 (class 2604 OID 17074)
-- Name: produtos id_produto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos ALTER COLUMN id_produto SET DEFAULT nextval('public.produtos_id_produto_seq'::regclass);


--
-- TOC entry 4743 (class 2604 OID 17005)
-- Name: usuario_login id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_login ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_login_id_usuario_seq'::regclass);


--
-- TOC entry 4751 (class 2604 OID 17096)
-- Name: vendas id_venda; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendas ALTER COLUMN id_venda SET DEFAULT nextval('public.vendas_id_venda_seq'::regclass);


--
-- TOC entry 4748 (class 2604 OID 17050)
-- Name: vendedores id_vendedor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedores ALTER COLUMN id_vendedor SET DEFAULT nextval('public.vendedores_id_vendedor_seq'::regclass);


--
-- TOC entry 4942 (class 0 OID 17026)
-- Dependencies: 221
-- Data for Name: administradores; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.administradores (id_admin, nome, email, senha_hash, data_cadastro) VALUES (1, 'Fernanda da Mota', 'mariane32@cunha.br', 'hash_admin_fernanda', '2022-11-28 00:00:00');
INSERT INTO public.administradores (id_admin, nome, email, senha_hash, data_cadastro) VALUES (2, 'Emilly Barbosa', 'vicente23@bol.com.br', 'hash_admin_emilly', '2023-09-29 00:00:00');
INSERT INTO public.administradores (id_admin, nome, email, senha_hash, data_cadastro) VALUES (3, 'Rafaela Fernandes', 'isis42@freitas.com', 'hash_admin_rafaela', '2023-03-24 00:00:00');
INSERT INTO public.administradores (id_admin, nome, email, senha_hash, data_cadastro) VALUES (4, 'Pietra Caldeira', 'ana-luizacampos@lima.br', 'hash_admin_pietra', '2024-03-01 00:00:00');
INSERT INTO public.administradores (id_admin, nome, email, senha_hash, data_cadastro) VALUES (5, 'Maria Cecília Duarte', 'carolinajesus@bol.com.br', 'hash_admin_maria', '2020-02-01 00:00:00');
INSERT INTO public.administradores (id_admin, nome, email, senha_hash, data_cadastro) VALUES (6, 'Laura Nogueira', 'caldeiraana-vitoria@aragao.br', 'hash_admin_laura', '2021-05-23 00:00:00');
INSERT INTO public.administradores (id_admin, nome, email, senha_hash, data_cadastro) VALUES (7, 'Juliana Dias', 'enrico21@almeida.br', 'hash_admin_juliana', '2020-05-18 00:00:00');
INSERT INTO public.administradores (id_admin, nome, email, senha_hash, data_cadastro) VALUES (8, 'Sr. Vitor Hugo Mendes', 'sofia11@duarte.br', 'hash_admin_sr.', '2021-08-16 00:00:00');
INSERT INTO public.administradores (id_admin, nome, email, senha_hash, data_cadastro) VALUES (9, 'Guilherme Nunes', 'castropaulo@uol.com.br', 'hash_admin_guilherme', '2023-12-28 00:00:00');
INSERT INTO public.administradores (id_admin, nome, email, senha_hash, data_cadastro) VALUES (10, 'Cauã Gonçalves', 'saleshenrique@hotmail.com', 'hash_admin_cauã', '2020-10-04 00:00:00');


--
-- TOC entry 4944 (class 0 OID 17038)
-- Dependencies: 223
-- Data for Name: fornecedores; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (1, 'Martins', '+55 84 2266 2061', 'ana-lauracosta@das.com');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (2, 'da Mata', '71 6522 4263', 'vinicius24@yahoo.com.br');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (3, 'Mendes', '51 4310 6103', 'barrosian@sales.br');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (4, 'Mendes', '(031) 3005 3957', 'claricefreitas@farias.br');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (5, 'Carvalho', '84 0255-5694', 'luiz-otaviocosta@gmail.com');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (6, 'Cunha', '84 9510-4120', 'tvieira@ig.com.br');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (7, 'Correia Ltda.', '11 8670 7507', 'fernando08@cardoso.br');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (8, 'Ribeiro Ltda.', '(031) 8454-9691', 'maria93@castro.net');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (9, 'Sales S.A.', '0900-693-4177', 'kamilly70@uol.com.br');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (10, 'da Mata S/A', '41 1396-9937', 'castrocamila@yahoo.com.br');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (11, 'Novaes', '(051) 7338-3089', 'cardosojulia@alves.br');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (12, 'da Mota da Costa - EI', '0800 616 2117', 'da-pazhenrique@uol.com.br');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (13, 'Freitas', '+55 81 2072-9767', 'moraesmaysa@ig.com.br');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (14, 'Vieira S.A.', '84 3637 4887', 'aliciarodrigues@hotmail.com');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (15, 'da Rocha', '+55 (084) 0994 5204', 'da-cunhalucas-gabriel@gmail.com');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (16, 'Souza', '0900 936 5589', 'davi-luizda-costa@hotmail.com');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (17, 'Carvalho', '+55 61 1826-2997', 'leticia68@nogueira.br');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (18, 'Castro - ME', '+55 41 1145-8850', 'fernandesluigi@ig.com.br');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (19, 'Gonçalves Ltda.', '+55 71 4914 9920', 'noah91@gmail.com');
INSERT INTO public.fornecedores (id_fornecedor, nome, telefone, email) VALUES (20, 'Nunes', '+55 (084) 0864 7440', 'bcarvalho@uol.com.br');


--
-- TOC entry 4956 (class 0 OID 17131)
-- Dependencies: 235
-- Data for Name: itens_venda; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (6, 40, 8, 34.36);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (6, 76, 2, 36.22);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (6, 77, 10, 8.25);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (6, 70, 3, 34.77);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (7, 78, 2, 41.36);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (7, 79, 7, 23.98);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (7, 23, 10, 15.13);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (7, 58, 10, 49.07);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (8, 98, 3, 21.49);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (8, 16, 2, 45.47);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (9, 8, 10, 24.65);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (10, 79, 5, 23.98);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (11, 77, 4, 8.25);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (11, 30, 2, 9.83);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (11, 70, 1, 34.77);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (12, 66, 3, 16.74);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (12, 49, 4, 39.47);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (12, 97, 2, 26.77);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (12, 8, 4, 24.65);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (13, 90, 4, 29.34);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (13, 16, 9, 45.47);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (14, 37, 3, 41.38);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (14, 93, 10, 28.90);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (14, 63, 1, 4.05);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (14, 98, 7, 21.49);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (15, 21, 4, 3.65);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (15, 1, 3, 35.17);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (15, 80, 3, 34.38);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (16, 50, 1, 37.16);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (16, 72, 7, 45.55);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (16, 49, 10, 39.47);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (17, 47, 4, 26.76);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (18, 100, 3, 31.43);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (18, 34, 6, 32.59);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (18, 17, 3, 35.96);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (18, 2, 9, 29.68);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (19, 40, 10, 34.36);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (19, 18, 5, 12.12);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (19, 80, 2, 34.38);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (20, 27, 3, 10.88);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (20, 1, 7, 35.17);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (20, 14, 10, 47.63);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (21, 35, 7, 32.62);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (21, 81, 4, 24.22);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (21, 21, 5, 3.65);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (21, 55, 6, 3.55);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (21, 41, 3, 12.75);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (22, 8, 9, 24.65);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (22, 64, 2, 36.11);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (22, 92, 7, 14.42);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (22, 58, 5, 49.07);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (23, 32, 6, 13.85);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (23, 30, 7, 9.83);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (23, 52, 4, 35.44);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (23, 67, 8, 14.91);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (23, 52, 6, 35.44);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (24, 10, 9, 22.99);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (24, 89, 6, 42.28);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (24, 49, 2, 39.47);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (24, 4, 7, 33.29);
INSERT INTO public.itens_venda (id_venda, id_produto, quantidade, preco_unitario) VALUES (25, 40, 4, 34.36);


--
-- TOC entry 4951 (class 0 OID 17084)
-- Dependencies: 230
-- Data for Name: metodos_pagamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.metodos_pagamento (id_metodo_pagamento, nome_metodo) VALUES (1, 'Pix');
INSERT INTO public.metodos_pagamento (id_metodo_pagamento, nome_metodo) VALUES (2, 'Cartão de Crédito');
INSERT INTO public.metodos_pagamento (id_metodo_pagamento, nome_metodo) VALUES (3, 'Cartão de Débito');
INSERT INTO public.metodos_pagamento (id_metodo_pagamento, nome_metodo) VALUES (4, 'Dinheiro');
INSERT INTO public.metodos_pagamento (id_metodo_pagamento, nome_metodo) VALUES (5, 'Boleto Bancário');


--
-- TOC entry 4955 (class 0 OID 17112)
-- Dependencies: 234
-- Data for Name: pagamentos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (2, 6, 3, 108.43, 'cancelado');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (3, 7, 3, 140.80, 'pendente');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (4, 8, 1, 253.78, 'cancelado');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (5, 9, 1, 39.88, 'realizado');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (6, 10, 3, 181.10, 'cancelado');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (7, 11, 4, 226.35, 'cancelado');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (8, 12, 1, 36.08, 'cancelado');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (9, 13, 4, 175.88, 'pendente');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (10, 14, 3, 29.68, 'pendente');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (11, 15, 4, 123.71, 'realizado');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (12, 16, 4, 242.49, 'pendente');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (13, 17, 5, 183.11, 'cancelado');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (14, 18, 1, 203.00, 'cancelado');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (15, 19, 2, 92.01, 'pendente');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (16, 20, 2, 263.35, 'cancelado');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (17, 21, 4, 213.51, 'cancelado');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (18, 22, 2, 90.54, 'realizado');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (19, 23, 2, 261.14, 'realizado');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (20, 24, 2, 261.83, 'realizado');
INSERT INTO public.pagamentos (id_pagamento, id_venda, id_metodo_pagamento, valor_total, status_pagamento) VALUES (21, 25, 2, 85.02, 'cancelado');


--
-- TOC entry 4949 (class 0 OID 17071)
-- Dependencies: 228
-- Data for Name: produtos; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (3, 'Perspiciatis Orgânico', 43.29, 428, 11);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (5, 'Exercitationem Orgânico', 48.19, 445, 16);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (6, 'Nulla Orgânico', 7.14, 123, 5);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (7, 'Dolores Orgânico', 12.44, 153, 8);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (9, 'Autem Orgânico', 31.08, 350, 17);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (11, 'Aspernatur Orgânico', 45.28, 263, 1);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (12, 'Esse Orgânico', 19.03, 288, 12);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (13, 'Et Orgânico', 46.38, 395, 5);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (15, 'Ex Orgânico', 49.72, 63, 13);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (19, 'Quibusdam Orgânico', 35.06, 174, 13);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (20, 'Aliquam Orgânico', 30.43, 37, 13);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (22, 'Non Orgânico', 5.09, 357, 9);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (24, 'Eaque Orgânico', 38.82, 51, 1);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (25, 'Cumque Orgânico', 10.68, 168, 15);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (26, 'Ab Orgânico', 8.43, 351, 6);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (28, 'Quod Orgânico', 16.19, 176, 8);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (29, 'Esse Orgânico', 7.87, 340, 3);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (31, 'Alias Orgânico', 43.87, 458, 19);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (33, 'Eveniet Orgânico', 11.98, 425, 9);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (36, 'Explicabo Orgânico', 17.89, 315, 16);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (38, 'Nobis Orgânico', 49.59, 237, 13);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (39, 'Repellendus Orgânico', 20.77, 79, 18);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (42, 'Animi Orgânico', 25.13, 176, 8);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (43, 'Excepturi Orgânico', 20.87, 241, 5);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (44, 'Repudiandae Orgânico', 5.38, 35, 18);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (45, 'Iste Orgânico', 18.29, 90, 5);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (46, 'Sequi Orgânico', 12.14, 156, 1);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (48, 'Rem Orgânico', 34.05, 158, 11);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (51, 'Molestias Orgânico', 24.86, 480, 4);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (53, 'Nisi Orgânico', 41.67, 280, 16);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (54, 'Repudiandae Orgânico', 49.58, 131, 5);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (56, 'Mollitia Orgânico', 5.36, 25, 19);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (57, 'Pariatur Orgânico', 4.24, 337, 20);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (59, 'Expedita Orgânico', 38.01, 184, 19);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (60, 'Atque Orgânico', 48.44, 213, 10);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (61, 'Laudantium Orgânico', 29.54, 421, 19);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (62, 'Et Orgânico', 28.15, 208, 9);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (65, 'Vel Orgânico', 12.43, 90, 11);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (68, 'Optio Orgânico', 11.05, 107, 12);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (69, 'Eum Orgânico', 41.96, 455, 14);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (71, 'Est Orgânico', 20.87, 363, 17);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (73, 'Quia Orgânico', 39.21, 99, 18);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (74, 'Labore Orgânico', 17.16, 189, 10);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (75, 'Magni Orgânico', 42.94, 459, 16);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (82, 'Accusantium Orgânico', 38.74, 91, 5);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (83, 'Animi Orgânico', 21.58, 370, 16);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (84, 'Quo Orgânico', 21.80, 141, 18);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (85, 'Dolor Orgânico', 37.68, 435, 2);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (86, 'Sint Orgânico', 27.34, 144, 1);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (87, 'Magnam Orgânico', 26.25, 21, 12);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (88, 'Nemo Orgânico', 32.33, 409, 19);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (91, 'Illum Orgânico', 40.48, 256, 16);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (94, 'Quae Orgânico', 49.85, 99, 13);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (95, 'Unde Orgânico', 40.22, 280, 14);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (96, 'Eveniet Orgânico', 49.24, 108, 15);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (99, 'Cupiditate Orgânico', 33.59, 381, 9);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (76, 'Corporis Orgânico', 36.22, 442, 8);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (78, 'Eligendi Orgânico', 41.36, 86, 4);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (23, 'Quam Orgânico', 15.13, 142, 11);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (79, 'Dolor Orgânico', 23.98, 144, 11);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (77, 'Sequi Orgânico', 8.25, 11, 3);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (70, 'Est Orgânico', 34.77, 306, 15);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (66, 'Error Orgânico', 16.74, 393, 10);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (97, 'Debitis Orgânico', 26.77, 193, 17);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (90, 'Ad Orgânico', 29.34, 84, 10);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (16, 'Blanditiis Orgânico', 45.47, 260, 12);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (37, 'Tenetur Orgânico', 41.38, 471, 15);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (93, 'Ullam Orgânico', 28.90, 321, 17);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (63, 'Illum Orgânico', 4.05, 426, 7);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (98, 'Dignissimos Orgânico', 21.49, 42, 19);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (50, 'Sunt Orgânico', 37.16, 262, 1);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (72, 'Quidem Orgânico', 45.55, 224, 3);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (47, 'Fugiat Orgânico', 26.76, 236, 19);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (100, 'Repellat Orgânico', 31.43, 271, 3);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (34, 'Accusamus Orgânico', 32.59, 268, 6);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (17, 'Numquam Orgânico', 35.96, 61, 14);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (2, 'Ullam Orgânico', 29.68, 404, 2);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (18, 'Repudiandae Orgânico', 12.12, 137, 3);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (80, 'Asperiores Orgânico', 34.38, 345, 20);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (27, 'Vel Orgânico', 10.88, 455, 1);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (1, 'Iure Orgânico', 35.17, 62, 15);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (14, 'Sunt Orgânico', 47.63, 214, 7);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (35, 'Consequuntur Orgânico', 32.62, 493, 20);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (81, 'Nemo Orgânico', 24.22, 68, 10);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (21, 'Possimus Orgânico', 3.65, 403, 12);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (55, 'Corporis Orgânico', 3.55, 245, 19);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (41, 'Dolorum Orgânico', 12.75, 141, 15);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (8, 'Ullam Orgânico', 24.65, 232, 20);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (64, 'Dolorem Orgânico', 36.11, 137, 15);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (92, 'Impedit Orgânico', 14.42, 417, 5);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (58, 'Assumenda Orgânico', 49.07, 212, 20);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (32, 'Consequuntur Orgânico', 13.85, 333, 3);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (30, 'Rem Orgânico', 9.83, 487, 17);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (67, 'Earum Orgânico', 14.91, 363, 8);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (52, 'Molestias Orgânico', 35.44, 322, 9);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (10, 'Mollitia Orgânico', 22.99, 106, 14);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (89, 'Ipsam Orgânico', 42.28, 151, 13);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (49, 'Sed Orgânico', 39.47, 191, 17);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (4, 'Optio Orgânico', 33.29, 426, 2);
INSERT INTO public.produtos (id_produto, nome, preco_unitario, quantidade_estoque, id_vendedor) VALUES (40, 'Delectus Orgânico', 34.36, 207, 1);


--
-- TOC entry 4939 (class 0 OID 17002)
-- Dependencies: 218
-- Data for Name: usuario_login; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (56, 'barbosaleandro@bol.com.br', 'hash_bernardo', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (57, 'meloluiza@yahoo.com.br', 'hash_luiz', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (58, 'gustavonogueira@melo.br', 'hash_ian', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (59, 'tda-rosa@carvalho.org', 'hash_pedro', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (60, 'yda-paz@peixoto.net', 'hash_marina', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (61, 'fjesus@hotmail.com', 'hash_leandro', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (62, 'alana71@cavalcanti.com', 'hash_joão', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (63, 'lucca44@da.br', 'hash_dra.', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (64, 'maria-aliceda-cunha@lopes.br', 'hash_elisa', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (65, 'lorenasales@ig.com.br', 'hash_carlos', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (66, 'fjesus@castro.com', 'hash_daniel', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (67, 'alanacampos@yahoo.com.br', 'hash_alexandre', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (68, 'moreiralorenzo@ig.com.br', 'hash_vitória', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (69, 'alice06@gmail.com', 'hash_manuela', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (70, 'kaique54@ferreira.org', 'hash_dr.', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (71, 'ramosgabriel@nunes.br', 'hash_dra.', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (72, 'augusto46@yahoo.com.br', 'hash_alice', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (73, 'maria-fernandada-rocha@hotmail.com', 'hash_stephany', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (74, 'teixeirajulia@campos.br', 'hash_sophia', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (75, 'davi-luiz03@moura.br', 'hash_lucas', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (76, 'cardosoana-vitoria@ig.com.br', 'hash_laís', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (77, 'arthur56@ig.com.br', 'hash_valentina', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (78, 'laviniapereira@bol.com.br', 'hash_ana', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (79, 'fmartins@hotmail.com', 'hash_stella', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (80, 'da-rosaigor@santos.org', 'hash_sr.', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (81, 'ccosta@ig.com.br', 'hash_daniela', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (82, 'joaquim96@rocha.br', 'hash_valentina', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (83, 'brodrigues@gmail.com', 'hash_marcela', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (84, 'lucasnascimento@yahoo.com.br', 'hash_thomas', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (85, 'martinsrafaela@gmail.com', 'hash_theo', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (86, 'ana-clarafernandes@ig.com.br', 'hash_sra.', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (87, 'teixeirabianca@hotmail.com', 'hash_luiz', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (88, 'maria17@uol.com.br', 'hash_lucas', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (89, 'emanuellymartins@bol.com.br', 'hash_milena', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (90, 'isis13@yahoo.com.br', 'hash_milena', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (91, 'juliarezende@castro.net', 'hash_augusto', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (92, 'xalmeida@ig.com.br', 'hash_henrique', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (93, 'pedro-miguel99@uol.com.br', 'hash_marcos', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (94, 'mrodrigues@lopes.com', 'hash_vicente', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (95, 'raulcostela@cunha.br', 'hash_davi', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (96, 'eduarda16@yahoo.com.br', 'hash_cauê', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (97, 'costelaelisa@peixoto.br', 'hash_mariana', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (98, 'davi-lucas67@hotmail.com', 'hash_heloísa', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (99, 'caue22@vieira.br', 'hash_elisa', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (100, 'fariasnoah@carvalho.br', 'hash_letícia', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (101, 'clarafarias@nascimento.com', 'hash_sra.', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (102, 'luiz-henrique29@ig.com.br', 'hash_leonardo', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (103, 'bernardonovaes@ig.com.br', 'hash_rebeca', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (104, 'raulcastro@ig.com.br', 'hash_luiza', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (105, 'ppires@teixeira.com', 'hash_stephany', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (106, 'souzapedro-lucas@uol.com.br', 'hash_fernanda', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (107, 'danielgomes@uol.com.br', 'hash_arthur', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (108, 'ana-livia15@moraes.br', 'hash_isaac', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (109, 'bmartins@hotmail.com', 'hash_lorenzo', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (110, 'fda-costa@cardoso.br', 'hash_fernanda', '2025-03-17 12:16:19.891948');
INSERT INTO public.usuario_login (id_usuario, email, senha_hash, data_criacao) VALUES (111, 'joao.lima@email.com', 'hash_joao', '2025-03-17 12:21:27.540516');


--
-- TOC entry 4940 (class 0 OID 17013)
-- Dependencies: 219
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (56, 'Bernardo Caldeira', '+55 (061) 7893-0791', 'Favela Martins, 81, Vila Nova Cachoeirinha 2ª Seção, 06079-425 Ramos da Mata / MT', '2006-05-09');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (57, 'Luiz Henrique Pereira', '+55 41 1793 8302', 'Jardim Silva, 17, Bonfim, 43077353 das Neves do Campo / AL', '1965-12-03');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (58, 'Ian da Rosa', '+55 (041) 6650 8107', 'Trevo Maria Eduarda da Cunha, 97, Zilah Sposito, 35036-806 Novaes do Campo / MA', '1987-06-15');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (59, 'Pedro Henrique Cunha', '+55 (084) 7855 7631', 'Lago de Caldeira, 77, Vila Ipiranga, 13396-519 Melo / AM', '1979-01-02');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (60, 'Marina Correia', '81 6221 5903', 'Chácara de Moraes, 8, Grota, 69678980 Moreira Grande / MA', '1961-03-24');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (61, 'Leandro Porto', '81 1200 9525', 'Recanto de Silveira, 53, Jardim Do Vale, 56020-004 da Rocha / AM', '1979-10-30');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (62, 'João Lucas Nascimento', '84 5755-4704', 'Rodovia Raquel Souza, 26, Marieta 2ª Seção, 70775-334 Freitas / SE', '1959-08-06');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (63, 'Dra. Larissa Aragão', '+55 21 2025-2315', 'Rua Freitas, 857, Bonsucesso, 73441-205 Nunes / DF', '1992-06-08');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (64, 'Elisa Costela', '81 6089-9378', 'Chácara Daniela Moreira, 975, Ápia, 95506282 Rezende / DF', '1991-08-07');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (65, 'Carlos Eduardo Costela', '(031) 0078 2628', 'Aeroporto de da Mota, 74, Santa Margarida, 18599792 Carvalho / RJ', '1996-06-01');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (66, 'Daniel Gonçalves', '71 7790 0263', 'Alameda de Porto, Vila Nova Gameleira 1ª Seção, 61869-336 Cunha dos Dourados / MA', '1993-08-18');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (67, 'Alexandre Fernandes', '+55 71 3775 5478', 'Viela Levi Gonçalves, 28, Paraíso, 45387-271 Moura do Galho / PI', '1986-01-11');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (68, 'Vitória Vieira', '11 6869 9501', 'Travessa de Correia, 35, Santana Do Cafezal, 09179603 Novaes / MA', '1971-08-19');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (69, 'Manuela Jesus', '+55 21 3625 9595', 'Esplanada Costa, 52, Europa, 27497550 Nunes da Mata / SP', '1990-09-06');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (70, 'Dr. Lucca da Cunha', '+55 (081) 9528 8417', 'Jardim Vitor Gabriel Dias, 45, Vila São Paulo, 25240055 Fernandes / PI', '2003-01-03');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (71, 'Dra. Isabel Santos', '+55 (041) 1401 0485', 'Campo Ramos, 72, Marieta 3ª Seção, 55171-934 Costela / SE', '1976-12-04');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (72, 'Alice da Luz', '+55 (071) 2173-8195', 'Trecho de Duarte, 77, Dom Joaquim, 12915-119 Alves / RN', '2005-01-06');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (73, 'Stephany da Costa', '+55 11 1983 7190', 'Trevo Rodrigues, 58, Vila São Dimas, 24110912 Vieira / RJ', '1979-07-30');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (74, 'Sophia da Conceição', '+55 (021) 7163-7298', 'Conjunto de Melo, 912, Nova Pampulha, 00859-452 Cavalcanti / PB', '1967-10-05');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (75, 'Lucas Martins', '0500 830 4740', 'Área Moura, 23, Estoril, 90154-984 da Paz / RR', '1962-09-18');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (76, 'Laís Costela', '(011) 1763 3186', 'Recanto Lucas Gabriel Campos, Xodo-Marize, 64800887 Oliveira / AP', '1983-09-01');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (77, 'Valentina Lopes', '+55 81 8743 8160', 'Jardim Pereira, 58, Ambrosina, 52645-702 Fogaça / PB', '1996-09-10');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (78, 'Ana Sophia Duarte', '+55 (041) 3136 8704', 'Trecho Cavalcanti, 75, Céu Azul, 85848572 Porto / RR', '1965-01-01');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (79, 'Stella da Conceição', '41 5117-3166', 'Condomínio João Gabriel Aragão, 9, Trevo, 76358859 Rocha / RN', '2006-03-27');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (80, 'Sr. João Alves', '21 7062 7922', 'Viela Ribeiro, 637, Luxemburgo, 18704379 Nunes da Mata / PB', '1984-07-14');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (81, 'Daniela Rocha', '(061) 9599-9734', 'Residencial Gustavo Henrique Campos, 23, Vila Engenho Nogueira, 42703404 Pereira do Norte / AC', '1986-09-11');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (82, 'Valentina Novaes', '84 0668-6048', 'Núcleo Monteiro, 1, Mariano De Abreu, 00150296 Duarte / SE', '1964-09-10');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (83, 'Marcela da Cruz', '(051) 8435 8311', 'Núcleo de Azevedo, 37, Bom Jesus, 45647117 Campos / MT', '1968-11-02');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (84, 'Thomas Cardoso', '(084) 5841-4840', 'Chácara Gomes, 9, Dom Bosco, 94164540 Costa da Mata / TO', '1999-07-05');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (85, 'Theo Ramos', '61 6998 4427', 'Avenida de Gomes, 3, Mariquinhas, 02125-499 Nogueira / RS', '1968-08-21');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (86, 'Sra. Nina Cavalcanti', '+55 31 9577 0898', 'Rodovia Renan Pereira, Ademar Maldonado, 14693903 Farias da Prata / MS', '1964-09-25');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (87, 'Luiz Fernando Alves', '51 0575 6909', 'Trevo Arthur Campos, 60, Candelaria, 51472-004 Fogaça / BA', '1966-08-31');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (88, 'Lucas Rodrigues', '+55 61 0453-7806', 'Morro Farias, Ventosa, 77715253 das Neves / AC', '1973-10-14');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (89, 'Milena da Cunha', '+55 11 1644 7631', 'Aeroporto de Monteiro, 6, São Vicente, 02637843 Pereira do Sul / CE', '1959-10-17');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (90, 'Milena Campos', '+55 (061) 1285 5131', 'Alameda de da Rosa, 5, Boa Vista, 77666943 das Neves das Flores / CE', '1986-01-06');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (91, 'Augusto Gomes', '0800-695-9748', 'Via de Barbosa, 15, Maria Virgínia, 09127-085 Cardoso / SP', '1988-10-24');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (92, 'Henrique Pereira', '(084) 4702 0214', 'Colônia Carolina Farias, 269, Pongelupe, 62772-888 Barros / TO', '1980-01-17');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (93, 'Marcos Vinicius Rocha', '+55 (041) 7831 9172', 'Rodovia de Rezende, 69, Zilah Sposito, 83216955 Teixeira / MG', '1971-02-01');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (94, 'Vicente Vieira', '0500-053-9207', 'Núcleo Moura, 76, Barro Preto, 74489-034 Nascimento / BA', '1968-11-03');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (95, 'Davi Lucas Moreira', '21 0869-3064', 'Conjunto Peixoto, 969, Laranjeiras, 93600-679 Lima / SP', '1998-07-26');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (96, 'Cauê Silva', '+55 (051) 7768-1676', 'Sítio Giovanna Campos, 76, Aparecida 7ª Seção, 15320-299 Nascimento da Praia / PA', '1969-12-19');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (97, 'Mariana Teixeira', '+55 (031) 3356 4664', 'Praia Lima, 77, Santo André, 98425-224 Melo / PB', '1961-08-23');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (98, 'Heloísa Freitas', '11 4544-4064', 'Favela Rezende, 2, Concórdia, 07769-330 Mendes / TO', '1971-08-17');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (99, 'Elisa Lopes', '+55 11 4936 9028', 'Recanto Thiago Campos, 78, Boa Vista, 49215000 Oliveira de Goiás / DF', '1960-04-26');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (100, 'Letícia Silveira', '31 1621 7410', 'Conjunto de Caldeira, 294, Planalto, 60057-608 Azevedo das Flores / CE', '1989-09-07');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (101, 'Sra. Isadora Cardoso', '0900 334 6929', 'Setor Maria Vitória Moraes, 288, Jardim Dos Comerciarios, 51868-182 Melo do Amparo / GO', '2004-10-29');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (102, 'Leonardo Rodrigues', '+55 21 9811 7462', 'Jardim Moura, 64, Pompéia, 03419-609 da Mota / SC', '1982-09-15');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (103, 'Rebeca Teixeira', '(051) 8834 7642', 'Núcleo de Lopes, 31, Santa Maria, 70291640 Porto / MA', '1967-04-03');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (104, 'Luiza Monteiro', '+55 81 3796 3034', 'Trevo Lima, 3, Vila Santo Antônio, 64009-169 Barbosa do Norte / RN', '1973-07-22');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (105, 'Stephany Silva', '+55 11 8986-4794', 'Área da Mata, 64, Vila Nova Paraíso, 58362-205 Nogueira da Mata / PB', '1969-06-14');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (106, 'Fernanda Rezende', '+55 41 0058-0087', 'Morro Sabrina Nunes, 546, Baleia, 75555-190 Rocha de Monteiro / DF', '1964-04-06');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (107, 'Arthur Porto', '+55 61 3831 4884', 'Quadra Novaes, 8, Novo Ouro Preto, 78845-715 Cardoso / RO', '1966-08-27');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (108, 'Isaac Nascimento', '41 3338-7222', 'Travessa Henrique Ferreira, Santa Rosa, 45599179 da Costa / AP', '1966-03-13');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (109, 'Lorenzo Porto', '0500 680 6985', 'Vila de Almeida, 25, Nossa Senhora De Fátima, 05944-897 Carvalho do Amparo / TO', '1967-11-15');
INSERT INTO public.usuarios (id_usuario, nome, telefone, endereco, data_nascimento) VALUES (111, 'João Lima', '11911111111', 'Rua A, 100', '1985-03-22');


--
-- TOC entry 4953 (class 0 OID 17093)
-- Dependencies: 232
-- Data for Name: vendas; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (6, 56, '2025-03-17 12:25:08.205261', 25.79);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (7, 65, '2025-03-17 12:25:08.205261', 254.55);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (8, 58, '2025-03-17 12:25:08.205261', 110.58);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (9, 59, '2025-03-17 12:25:08.205261', 49.10);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (10, 97, '2025-03-17 12:25:08.205261', 215.64);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (11, 62, '2025-03-17 12:25:08.205261', 108.43);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (12, 82, '2025-03-17 12:25:08.205261', 140.80);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (13, 59, '2025-03-17 12:25:08.205261', 253.78);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (14, 76, '2025-03-17 12:25:08.205261', 39.88);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (15, 63, '2025-03-17 12:25:08.205261', 181.10);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (16, 60, '2025-03-17 12:25:08.205261', 226.35);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (17, 72, '2025-03-17 12:25:08.205261', 36.08);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (18, 74, '2025-03-17 12:25:08.205261', 175.88);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (19, 84, '2025-03-17 12:25:08.205261', 29.68);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (20, 60, '2025-03-17 12:25:08.205261', 123.71);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (21, 98, '2025-03-17 12:25:08.205261', 242.49);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (22, 89, '2025-03-17 12:25:08.205261', 183.11);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (23, 91, '2025-03-17 12:25:08.205261', 203.00);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (24, 102, '2025-03-17 12:25:08.205261', 92.01);
INSERT INTO public.vendas (id_venda, id_usuario, data_venda, valor_total) VALUES (25, 110, '2025-03-17 12:25:08.205261', 263.35);


--
-- TOC entry 4946 (class 0 OID 17047)
-- Dependencies: 225
-- Data for Name: vendedores; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (1, 'Sra. Larissa da Mota', '84 3471 2568', 'Sítio Ea', 'Campos', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (2, 'Sophie Costa', '+55 11 0548 6579', 'Sítio Soluta', 'Gomes de Santos', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (3, 'Caroline Silva', '+55 (051) 0449-8566', 'Sítio Illum', 'da Rocha', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (4, 'Sophia Almeida', '(011) 9071-3300', 'Sítio Blanditiis', 'Freitas de Goiás', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (5, 'Diego Silveira', '+55 11 2524 6098', 'Sítio Excepturi', 'Rezende de Goiás', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (6, 'Luna da Luz', '(011) 0496-5554', 'Sítio Dignissimos', 'Gomes de Ribeiro', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (7, 'Dr. Renan Lopes', '71 4342-3314', 'Sítio Iusto', 'Azevedo de da Cunha', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (8, 'Ana Lívia Nascimento', '0800 393 6117', 'Sítio Voluptatum', 'das Neves', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (9, 'Ana Luiza Lima', '+55 (031) 6280-8651', 'Sítio Ipsam', 'Martins de Pereira', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (10, 'Bruna Gonçalves', '+55 (081) 0969-1124', 'Sítio Corporis', 'Farias dos Dourados', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (11, 'Maria Luiza Castro', '81 7913 8806', 'Sítio Natus', 'Dias da Mata', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (12, 'Ana Clara Monteiro', '(071) 8046 0382', 'Sítio Minus', 'Mendes do Galho', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (13, 'Letícia Rocha', '(021) 4180 4901', 'Sítio Expedita', 'Carvalho', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (14, 'Maria Julia Silva', '(081) 5333 9937', 'Sítio Sequi', 'Porto', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (15, 'Pedro Miguel Lopes', '(071) 6488 5949', 'Sítio Deleniti', 'Cardoso', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (16, 'Antônio Gomes', '+55 (071) 9362-8865', 'Sítio Error', 'Cardoso do Oeste', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (17, 'Gustavo Henrique Nunes', '(061) 2182-9443', 'Sítio Fuga', 'Freitas de da Cruz', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (18, 'Alexandre Pereira', '31 4749 2086', 'Sítio Corporis', 'Moraes', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (19, 'Maria Fernanda Pinto', '+55 51 4549 2027', 'Sítio Neque', 'Duarte', 'Orgânico, Agroecológico');
INSERT INTO public.vendedores (id_vendedor, nome, telefone, sitio, localizacao, certificacoes) VALUES (20, 'Enzo Gabriel Gonçalves', '+55 11 6309-0344', 'Sítio Natus', 'Melo', 'Orgânico, Agroecológico');


--
-- TOC entry 4947 (class 0 OID 17055)
-- Dependencies: 226
-- Data for Name: vendedores_fornecedores; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (9, 12);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (20, 6);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (8, 11);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (6, 14);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (17, 14);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (10, 3);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (5, 1);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (12, 3);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (16, 9);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (19, 7);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (12, 19);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (5, 16);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (16, 11);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (17, 8);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (4, 11);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (16, 14);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (10, 15);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (10, 5);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (4, 20);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (10, 19);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (14, 16);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (3, 8);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (11, 8);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (18, 12);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (16, 17);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (18, 19);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (11, 7);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (11, 10);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (16, 20);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (2, 1);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (15, 2);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (8, 12);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (17, 4);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (17, 16);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (3, 14);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (13, 1);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (15, 14);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (17, 2);
INSERT INTO public.vendedores_fornecedores (id_vendedor, id_fornecedor) VALUES (1, 19);


--
-- TOC entry 4971 (class 0 OID 0)
-- Dependencies: 220
-- Name: administradores_id_admin_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.administradores_id_admin_seq', 10, true);


--
-- TOC entry 4972 (class 0 OID 0)
-- Dependencies: 222
-- Name: fornecedores_id_fornecedor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fornecedores_id_fornecedor_seq', 20, true);


--
-- TOC entry 4973 (class 0 OID 0)
-- Dependencies: 229
-- Name: metodos_pagamento_id_metodo_pagamento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.metodos_pagamento_id_metodo_pagamento_seq', 6, true);


--
-- TOC entry 4974 (class 0 OID 0)
-- Dependencies: 233
-- Name: pagamentos_id_pagamento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pagamentos_id_pagamento_seq', 21, true);


--
-- TOC entry 4975 (class 0 OID 0)
-- Dependencies: 227
-- Name: produtos_id_produto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produtos_id_produto_seq', 100, true);


--
-- TOC entry 4976 (class 0 OID 0)
-- Dependencies: 217
-- Name: usuario_login_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_login_id_usuario_seq', 113, true);


--
-- TOC entry 4977 (class 0 OID 0)
-- Dependencies: 231
-- Name: vendas_id_venda_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendas_id_venda_seq', 25, true);


--
-- TOC entry 4978 (class 0 OID 0)
-- Dependencies: 224
-- Name: vendedores_id_vendedor_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendedores_id_vendedor_seq', 20, true);


--
-- TOC entry 4764 (class 2606 OID 17036)
-- Name: administradores administradores_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administradores
    ADD CONSTRAINT administradores_email_key UNIQUE (email);


--
-- TOC entry 4766 (class 2606 OID 17034)
-- Name: administradores administradores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administradores
    ADD CONSTRAINT administradores_pkey PRIMARY KEY (id_admin);


--
-- TOC entry 4768 (class 2606 OID 17045)
-- Name: fornecedores fornecedores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fornecedores
    ADD CONSTRAINT fornecedores_pkey PRIMARY KEY (id_fornecedor);


--
-- TOC entry 4776 (class 2606 OID 17091)
-- Name: metodos_pagamento metodos_pagamento_nome_metodo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metodos_pagamento
    ADD CONSTRAINT metodos_pagamento_nome_metodo_key UNIQUE (nome_metodo);


--
-- TOC entry 4778 (class 2606 OID 17089)
-- Name: metodos_pagamento metodos_pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metodos_pagamento
    ADD CONSTRAINT metodos_pagamento_pkey PRIMARY KEY (id_metodo_pagamento);


--
-- TOC entry 4782 (class 2606 OID 17118)
-- Name: pagamentos pagamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamentos
    ADD CONSTRAINT pagamentos_pkey PRIMARY KEY (id_pagamento);


--
-- TOC entry 4774 (class 2606 OID 17077)
-- Name: produtos produtos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos
    ADD CONSTRAINT produtos_pkey PRIMARY KEY (id_produto);


--
-- TOC entry 4758 (class 2606 OID 17012)
-- Name: usuario_login usuario_login_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_login
    ADD CONSTRAINT usuario_login_email_key UNIQUE (email);


--
-- TOC entry 4760 (class 2606 OID 17010)
-- Name: usuario_login usuario_login_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_login
    ADD CONSTRAINT usuario_login_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4762 (class 2606 OID 17019)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4780 (class 2606 OID 17100)
-- Name: vendas vendas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_pkey PRIMARY KEY (id_venda);


--
-- TOC entry 4772 (class 2606 OID 17059)
-- Name: vendedores_fornecedores vendedores_fornecedores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedores_fornecedores
    ADD CONSTRAINT vendedores_fornecedores_pkey PRIMARY KEY (id_vendedor, id_fornecedor);


--
-- TOC entry 4770 (class 2606 OID 17054)
-- Name: vendedores vendedores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedores
    ADD CONSTRAINT vendedores_pkey PRIMARY KEY (id_vendedor);


--
-- TOC entry 4792 (class 2620 OID 17149)
-- Name: itens_venda trigger_atualizar_estoque; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_atualizar_estoque AFTER INSERT ON public.itens_venda FOR EACH ROW EXECUTE FUNCTION public.atualizar_estoque();


--
-- TOC entry 4784 (class 2606 OID 17065)
-- Name: vendedores_fornecedores fk_fornecedor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedores_fornecedores
    ADD CONSTRAINT fk_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES public.fornecedores(id_fornecedor) ON DELETE CASCADE;


--
-- TOC entry 4788 (class 2606 OID 17124)
-- Name: pagamentos fk_metodo_pagamento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamentos
    ADD CONSTRAINT fk_metodo_pagamento FOREIGN KEY (id_metodo_pagamento) REFERENCES public.metodos_pagamento(id_metodo_pagamento) ON DELETE RESTRICT;


--
-- TOC entry 4790 (class 2606 OID 17143)
-- Name: itens_venda fk_produto_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_venda
    ADD CONSTRAINT fk_produto_item FOREIGN KEY (id_produto) REFERENCES public.produtos(id_produto) ON DELETE RESTRICT;


--
-- TOC entry 4783 (class 2606 OID 17020)
-- Name: usuarios fk_usuario_login; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT fk_usuario_login FOREIGN KEY (id_usuario) REFERENCES public.usuario_login(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 4787 (class 2606 OID 17101)
-- Name: vendas fk_usuario_venda; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT fk_usuario_venda FOREIGN KEY (id_usuario) REFERENCES public.usuario_login(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 4791 (class 2606 OID 17138)
-- Name: itens_venda fk_venda_item; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_venda
    ADD CONSTRAINT fk_venda_item FOREIGN KEY (id_venda) REFERENCES public.vendas(id_venda) ON DELETE CASCADE;


--
-- TOC entry 4789 (class 2606 OID 17119)
-- Name: pagamentos fk_venda_pagamento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamentos
    ADD CONSTRAINT fk_venda_pagamento FOREIGN KEY (id_venda) REFERENCES public.vendas(id_venda) ON DELETE CASCADE;


--
-- TOC entry 4785 (class 2606 OID 17060)
-- Name: vendedores_fornecedores fk_vendedor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedores_fornecedores
    ADD CONSTRAINT fk_vendedor FOREIGN KEY (id_vendedor) REFERENCES public.vendedores(id_vendedor) ON DELETE CASCADE;


--
-- TOC entry 4786 (class 2606 OID 17078)
-- Name: produtos fk_vendedor_produto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produtos
    ADD CONSTRAINT fk_vendedor_produto FOREIGN KEY (id_vendedor) REFERENCES public.vendedores(id_vendedor) ON DELETE CASCADE;


-- Completed on 2025-03-19 10:01:14

--
-- PostgreSQL database dump complete
--

