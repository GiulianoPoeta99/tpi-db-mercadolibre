--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0 (Debian 16.0-1.pgdg120+1)
-- Dumped by pg_dump version 16.0 (Debian 16.0-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categoria; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.categoria (
    id_categoria integer NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.categoria OWNER TO mercado_libre_db;

--
-- Name: categoria_id_categoria_seq; Type: SEQUENCE; Schema: public; Owner: mercado_libre_db
--

CREATE SEQUENCE public.categoria_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categoria_id_categoria_seq OWNER TO mercado_libre_db;

--
-- Name: categoria_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mercado_libre_db
--

ALTER SEQUENCE public.categoria_id_categoria_seq OWNED BY public.categoria.id_categoria;


--
-- Name: categoria_subcategoria; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.categoria_subcategoria (
    tiene_categoria integer NOT NULL,
    es_subcategoria integer NOT NULL
);


ALTER TABLE public.categoria_subcategoria OWNER TO mercado_libre_db;

--
-- Name: direccion; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.direccion (
    id_direccion integer NOT NULL,
    codigo_postal character varying(10) NOT NULL,
    calle character varying(255) NOT NULL,
    altura integer NOT NULL
);


ALTER TABLE public.direccion OWNER TO mercado_libre_db;

--
-- Name: direccion_id_direccion_seq; Type: SEQUENCE; Schema: public; Owner: mercado_libre_db
--

CREATE SEQUENCE public.direccion_id_direccion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.direccion_id_direccion_seq OWNER TO mercado_libre_db;

--
-- Name: direccion_id_direccion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mercado_libre_db
--

ALTER SEQUENCE public.direccion_id_direccion_seq OWNED BY public.direccion.id_direccion;


--
-- Name: empresa; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.empresa (
    usuario integer NOT NULL,
    cuit character varying(15) NOT NULL,
    nombre_fantasia character varying(255) NOT NULL,
    fecha_creacion date NOT NULL
);


ALTER TABLE public.empresa OWNER TO mercado_libre_db;

--
-- Name: envio; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.envio (
    id_envio integer NOT NULL,
    tipo_envio character varying(255) NOT NULL,
    CONSTRAINT envio_tipo_envio_check CHECK (((tipo_envio)::text = ANY ((ARRAY['envio rapido'::character varying, 'envio normal a domicilio'::character varying, 'envio a correo'::character varying, 'retiro en sucursal'::character varying])::text[])))
);


ALTER TABLE public.envio OWNER TO mercado_libre_db;

--
-- Name: envio_id_envio_seq; Type: SEQUENCE; Schema: public; Owner: mercado_libre_db
--

CREATE SEQUENCE public.envio_id_envio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.envio_id_envio_seq OWNER TO mercado_libre_db;

--
-- Name: envio_id_envio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mercado_libre_db
--

ALTER SEQUENCE public.envio_id_envio_seq OWNED BY public.envio.id_envio;


--
-- Name: producto; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.producto (
    numero_articulo integer NOT NULL,
    es_nuevo boolean NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    detalle character varying(255),
    descripcion_producto text,
    nombre_producto character varying(255) NOT NULL,
    stock integer NOT NULL,
    calificacion integer NOT NULL,
    CONSTRAINT producto_calificacion_check CHECK (((calificacion >= 1) AND (calificacion <= 5)))
);


ALTER TABLE public.producto OWNER TO mercado_libre_db;

--
-- Name: resenia; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.resenia (
    id_resenia integer NOT NULL,
    resenia_producto text NOT NULL,
    calificacion integer NOT NULL,
    producto integer NOT NULL
);


ALTER TABLE public.resenia OWNER TO mercado_libre_db;

--
-- Name: getcalificacionpromedio; Type: VIEW; Schema: public; Owner: mercado_libre_db
--

CREATE VIEW public.getcalificacionpromedio AS
 SELECT p.numero_articulo,
        CASE
            WHEN (avg(r.calificacion) IS NULL) THEN 0.00
            ELSE avg(r.calificacion)
        END AS promedio
   FROM (public.producto p
     LEFT JOIN public.resenia r ON ((p.numero_articulo = r.producto)))
  GROUP BY p.numero_articulo
  ORDER BY p.numero_articulo;


ALTER VIEW public.getcalificacionpromedio OWNER TO mercado_libre_db;

--
-- Name: imagen; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.imagen (
    producto integer NOT NULL,
    imagen character varying(255) NOT NULL
);


ALTER TABLE public.imagen OWNER TO mercado_libre_db;

--
-- Name: item; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.item (
    id_item integer NOT NULL,
    cantidad integer NOT NULL,
    estado character varying(255) NOT NULL,
    tipo_entrega character varying(255) NOT NULL,
    envio_domicilio boolean NOT NULL,
    usuario integer NOT NULL,
    producto integer NOT NULL,
    direccion integer NOT NULL,
    pedido integer NOT NULL,
    CONSTRAINT item_estado_check CHECK (((estado)::text = ANY ((ARRAY['Preparando el envio'::character varying, 'Listo para enviar'::character varying, 'Enviado'::character varying, 'Recibido'::character varying])::text[])))
);


ALTER TABLE public.item OWNER TO mercado_libre_db;

--
-- Name: item_envio; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.item_envio (
    item integer NOT NULL,
    envio integer NOT NULL
);


ALTER TABLE public.item_envio OWNER TO mercado_libre_db;

--
-- Name: item_id_item_seq; Type: SEQUENCE; Schema: public; Owner: mercado_libre_db
--

CREATE SEQUENCE public.item_id_item_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.item_id_item_seq OWNER TO mercado_libre_db;

--
-- Name: item_id_item_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mercado_libre_db
--

ALTER SEQUENCE public.item_id_item_seq OWNED BY public.item.id_item;


--
-- Name: metodo_de_pago; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.metodo_de_pago (
    id_tarjeta integer NOT NULL,
    titular character varying(255) NOT NULL,
    numero_tarjeta character varying(16) NOT NULL,
    clave_seguridad character varying(10) NOT NULL,
    fecha_caducidad date NOT NULL,
    empresa_emisora character varying(255) NOT NULL,
    tipo character varying(255) NOT NULL,
    usuario integer NOT NULL,
    CONSTRAINT metodo_de_pago_empresa_emisora_check CHECK (((empresa_emisora)::text = ANY ((ARRAY['Visa'::character varying, 'MasterCard'::character varying, 'American Express'::character varying, 'Maestro'::character varying])::text[]))),
    CONSTRAINT metodo_de_pago_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['Crédito'::character varying, 'Debito'::character varying])::text[])))
);


ALTER TABLE public.metodo_de_pago OWNER TO mercado_libre_db;

--
-- Name: metodo_de_pago_id_tarjeta_seq; Type: SEQUENCE; Schema: public; Owner: mercado_libre_db
--

CREATE SEQUENCE public.metodo_de_pago_id_tarjeta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metodo_de_pago_id_tarjeta_seq OWNER TO mercado_libre_db;

--
-- Name: metodo_de_pago_id_tarjeta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mercado_libre_db
--

ALTER SEQUENCE public.metodo_de_pago_id_tarjeta_seq OWNED BY public.metodo_de_pago.id_tarjeta;


--
-- Name: montos_item; Type: VIEW; Schema: public; Owner: mercado_libre_db
--

CREATE VIEW public.montos_item AS
 SELECT i.pedido,
        CASE
            WHEN ((e.tipo_envio)::text = 'envio rapido'::text) THEN (((i.cantidad)::numeric * p.precio_unitario) + (400)::numeric)
            WHEN ((e.tipo_envio)::text = 'envio normal a domicilio'::text) THEN (((i.cantidad)::numeric * p.precio_unitario) + (200)::numeric)
            WHEN ((e.tipo_envio)::text = 'envio a correo'::text) THEN (((i.cantidad)::numeric * p.precio_unitario) + (150)::numeric)
            WHEN ((e.tipo_envio)::text = 'retiro en sucursal'::text) THEN ((i.cantidad)::numeric * p.precio_unitario)
            ELSE NULL::numeric
        END AS monto
   FROM (((public.item i
     JOIN public.producto p ON ((i.producto = p.numero_articulo)))
     JOIN public.item_envio ie ON ((ie.item = i.id_item)))
     JOIN public.envio e ON ((e.id_envio = ie.envio)))
  GROUP BY
        CASE
            WHEN ((e.tipo_envio)::text = 'envio rapido'::text) THEN (((i.cantidad)::numeric * p.precio_unitario) + (400)::numeric)
            WHEN ((e.tipo_envio)::text = 'envio normal a domicilio'::text) THEN (((i.cantidad)::numeric * p.precio_unitario) + (200)::numeric)
            WHEN ((e.tipo_envio)::text = 'envio a correo'::text) THEN (((i.cantidad)::numeric * p.precio_unitario) + (150)::numeric)
            WHEN ((e.tipo_envio)::text = 'retiro en sucursal'::text) THEN ((i.cantidad)::numeric * p.precio_unitario)
            ELSE NULL::numeric
        END, i.pedido
  ORDER BY i.pedido;


ALTER VIEW public.montos_item OWNER TO mercado_libre_db;

--
-- Name: oferta; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.oferta (
    id_oferta integer NOT NULL,
    porcentaje numeric(5,2) NOT NULL,
    fecha_desde date NOT NULL,
    fecha_hasta date NOT NULL
);


ALTER TABLE public.oferta OWNER TO mercado_libre_db;

--
-- Name: oferta_id_oferta_seq; Type: SEQUENCE; Schema: public; Owner: mercado_libre_db
--

CREATE SEQUENCE public.oferta_id_oferta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.oferta_id_oferta_seq OWNER TO mercado_libre_db;

--
-- Name: oferta_id_oferta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mercado_libre_db
--

ALTER SEQUENCE public.oferta_id_oferta_seq OWNED BY public.oferta.id_oferta;


--
-- Name: oferta_producto; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.oferta_producto (
    oferta integer NOT NULL,
    producto integer NOT NULL
);


ALTER TABLE public.oferta_producto OWNER TO mercado_libre_db;

--
-- Name: particular; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.particular (
    usuario integer NOT NULL,
    dni character varying(15) NOT NULL,
    fecha_nacimiento date NOT NULL,
    nombre character varying(255) NOT NULL,
    apellido character varying(255) NOT NULL
);


ALTER TABLE public.particular OWNER TO mercado_libre_db;

--
-- Name: pedido; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.pedido (
    numero_de_pedido integer NOT NULL,
    fecha_pedido date NOT NULL,
    metodo_pago integer NOT NULL,
    particular integer NOT NULL,
    resenia integer NOT NULL
);


ALTER TABLE public.pedido OWNER TO mercado_libre_db;

--
-- Name: pedido_numero_de_pedido_seq; Type: SEQUENCE; Schema: public; Owner: mercado_libre_db
--

CREATE SEQUENCE public.pedido_numero_de_pedido_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pedido_numero_de_pedido_seq OWNER TO mercado_libre_db;

--
-- Name: pedido_numero_de_pedido_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mercado_libre_db
--

ALTER SEQUENCE public.pedido_numero_de_pedido_seq OWNED BY public.pedido.numero_de_pedido;


--
-- Name: pregunta; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.pregunta (
    id_pregunta integer NOT NULL,
    preguntas_del_producto text NOT NULL,
    fecha_de_la_pregunta date NOT NULL
);


ALTER TABLE public.pregunta OWNER TO mercado_libre_db;

--
-- Name: pregunta_id_pregunta_seq; Type: SEQUENCE; Schema: public; Owner: mercado_libre_db
--

CREATE SEQUENCE public.pregunta_id_pregunta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pregunta_id_pregunta_seq OWNER TO mercado_libre_db;

--
-- Name: pregunta_id_pregunta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mercado_libre_db
--

ALTER SEQUENCE public.pregunta_id_pregunta_seq OWNED BY public.pregunta.id_pregunta;


--
-- Name: pregunta_producto_usuario; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.pregunta_producto_usuario (
    pregunta integer NOT NULL,
    producto integer NOT NULL,
    usuario integer NOT NULL
);


ALTER TABLE public.pregunta_producto_usuario OWNER TO mercado_libre_db;

--
-- Name: pregunta_respuesta; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.pregunta_respuesta (
    pregunta integer NOT NULL,
    respuesta integer NOT NULL
);


ALTER TABLE public.pregunta_respuesta OWNER TO mercado_libre_db;

--
-- Name: producto_categoria; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.producto_categoria (
    producto integer NOT NULL,
    categoria integer NOT NULL
);


ALTER TABLE public.producto_categoria OWNER TO mercado_libre_db;

--
-- Name: producto_detallado; Type: VIEW; Schema: public; Owner: mercado_libre_db
--

CREATE VIEW public.producto_detallado AS
SELECT
    NULL::integer AS numero_articulo,
    NULL::numeric(10,2) AS precio,
    NULL::character varying(255) AS nombre_producto,
    NULL::text AS descripcion_producto,
    NULL::text AS vendedor,
    NULL::boolean AS es_nuevo,
    NULL::integer AS stock,
    NULL::bigint AS cantidad_vendido,
    NULL::numeric AS calificacion,
    NULL::character varying[] AS categorias,
    NULL::bigint AS cantidad_preguntas,
    NULL::text[] AS preguntas,
    NULL::bigint AS cantidad_resenias,
    NULL::text[] AS resenias;


ALTER VIEW public.producto_detallado OWNER TO mercado_libre_db;

--
-- Name: producto_numero_articulo_seq; Type: SEQUENCE; Schema: public; Owner: mercado_libre_db
--

CREATE SEQUENCE public.producto_numero_articulo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.producto_numero_articulo_seq OWNER TO mercado_libre_db;

--
-- Name: producto_numero_articulo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mercado_libre_db
--

ALTER SEQUENCE public.producto_numero_articulo_seq OWNED BY public.producto.numero_articulo;


--
-- Name: resenia_id_resenia_seq; Type: SEQUENCE; Schema: public; Owner: mercado_libre_db
--

CREATE SEQUENCE public.resenia_id_resenia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.resenia_id_resenia_seq OWNER TO mercado_libre_db;

--
-- Name: resenia_id_resenia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mercado_libre_db
--

ALTER SEQUENCE public.resenia_id_resenia_seq OWNED BY public.resenia.id_resenia;


--
-- Name: usuario; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.usuario (
    numero_cliente integer NOT NULL,
    correo_electronico character varying(255) NOT NULL,
    telefono character varying(20) NOT NULL,
    contrasenia character varying(255) NOT NULL
);


ALTER TABLE public.usuario OWNER TO mercado_libre_db;

--
-- Name: usuario_direccion; Type: TABLE; Schema: public; Owner: mercado_libre_db
--

CREATE TABLE public.usuario_direccion (
    usuario integer NOT NULL,
    direccion integer NOT NULL
);


ALTER TABLE public.usuario_direccion OWNER TO mercado_libre_db;

--
-- Name: usuario_numero_cliente_seq; Type: SEQUENCE; Schema: public; Owner: mercado_libre_db
--

CREATE SEQUENCE public.usuario_numero_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_numero_cliente_seq OWNER TO mercado_libre_db;

--
-- Name: usuario_numero_cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mercado_libre_db
--

ALTER SEQUENCE public.usuario_numero_cliente_seq OWNED BY public.usuario.numero_cliente;


--
-- Name: categoria id_categoria; Type: DEFAULT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id_categoria SET DEFAULT nextval('public.categoria_id_categoria_seq'::regclass);


--
-- Name: direccion id_direccion; Type: DEFAULT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.direccion ALTER COLUMN id_direccion SET DEFAULT nextval('public.direccion_id_direccion_seq'::regclass);


--
-- Name: envio id_envio; Type: DEFAULT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.envio ALTER COLUMN id_envio SET DEFAULT nextval('public.envio_id_envio_seq'::regclass);


--
-- Name: item id_item; Type: DEFAULT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.item ALTER COLUMN id_item SET DEFAULT nextval('public.item_id_item_seq'::regclass);


--
-- Name: metodo_de_pago id_tarjeta; Type: DEFAULT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.metodo_de_pago ALTER COLUMN id_tarjeta SET DEFAULT nextval('public.metodo_de_pago_id_tarjeta_seq'::regclass);


--
-- Name: oferta id_oferta; Type: DEFAULT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.oferta ALTER COLUMN id_oferta SET DEFAULT nextval('public.oferta_id_oferta_seq'::regclass);


--
-- Name: pedido numero_de_pedido; Type: DEFAULT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.pedido ALTER COLUMN numero_de_pedido SET DEFAULT nextval('public.pedido_numero_de_pedido_seq'::regclass);


--
-- Name: pregunta id_pregunta; Type: DEFAULT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.pregunta ALTER COLUMN id_pregunta SET DEFAULT nextval('public.pregunta_id_pregunta_seq'::regclass);


--
-- Name: producto numero_articulo; Type: DEFAULT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.producto ALTER COLUMN numero_articulo SET DEFAULT nextval('public.producto_numero_articulo_seq'::regclass);


--
-- Name: resenia id_resenia; Type: DEFAULT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.resenia ALTER COLUMN id_resenia SET DEFAULT nextval('public.resenia_id_resenia_seq'::regclass);


--
-- Name: usuario numero_cliente; Type: DEFAULT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.usuario ALTER COLUMN numero_cliente SET DEFAULT nextval('public.usuario_numero_cliente_seq'::regclass);


--
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.categoria (id_categoria, nombre) FROM stdin;
1	Electrónica
2	Ropa y Accesorios
3	Calzado
4	Belleza y Cuidado Personal
5	Hogar
6	Jardín
7	Deportes y Actividades al Aire Libre
8	Juguetes y Juegos
9	Libros y Material de Oficina
10	Electrodomésticos
11	Muebles
12	Alimentos y Bebidas
13	Automóviles y Accesorios
14	Instrumentos Musicales
15	Arte y Manualidades
16	Electrónica de Consumo
17	Salud y Bienestar
18	Maletas y Equipaje
19	Productos para Bebés y Niños
20	Joyas y Relojes
21	Electrodomésticos de Cocina
22	Herramientas y Mejoras para el Hogar
23	Productos para Mascotas
24	Equipamiento para Negocios
25	Productos para el Cuidado del Cabello
26	Cámaras y Fotografía
27	Equipamiento para Deportes y Fitness
28	Equipos de Oficina
29	Juegos de Mesa y Rompecabezas
30	Suministros para Fiestas y Eventos
31	Equipamiento para Viajes y Aventuras
32	Productos para el Cuidado de la Piel
33	Equipamiento para Acampar y Excursionismo
34	Equipamiento para Actividades Acuáticas
35	Electrodomésticos para la Limpieza
36	Equipamiento para la Playa y Piscina
37	Equipos de Sonido y Audio
38	Equipamiento para Ciclismo
39	Equipamiento para Deportes de Invierno
40	Productos para el Cuidado de la Salud
41	Equipamiento para Deportes de Raqueta
42	Equipamiento para Deportes de Pelota
43	Equipamiento para Deportes de Combate
44	Productos para el Cuidado Oral
45	Equipamiento para Deportes de Equipo
46	Productos para el Cuidado de los Ojos
47	Productos de Higiene Personal
48	Equipamiento para Deportes de Agua
49	Equipamiento para Deportes de Aventura
50	Productos para el Cuidado de las Uñas
51	Equipamiento para Deportes de Montaña
52	Equipamiento para Deportes de Escalada
53	Equipamiento para Deportes de Motor
54	Productos para el Cuidado de la Barba
55	Equipamiento para Deportes de Vuelo
56	Equipamiento para Deportes de Tiro
57	Productos de Aseo Personal
58	Equipamiento para Deportes de Lucha
\.


--
-- Data for Name: categoria_subcategoria; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.categoria_subcategoria (tiene_categoria, es_subcategoria) FROM stdin;
1	10
1	16
1	26
1	37
2	3
2	20
4	17
4	25
4	47
4	50
4	54
4	57
5	6
5	11
5	22
7	27
7	31
7	33
7	34
7	36
7	38
7	39
7	41
7	42
7	43
7	45
7	48
7	49
7	51
7	52
7	53
7	55
7	56
7	58
8	29
9	24
9	28
10	21
10	35
17	32
17	40
17	44
17	46
\.


--
-- Data for Name: direccion; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.direccion (id_direccion, codigo_postal, calle, altura) FROM stdin;
1	1734	Av. Pte. Perón	9620
2	2161	Boulevard Alem	5199
3	6165	Diagonal Güemes	2512
4	7126	Calle Mitre	1492
5	1187	Avenida Catamarca	6441
6	4319	Diag. Entre Ríos	7722
7	1123	Boulevard G. Brown	1904
8	1564	Avenida 2	5481
9	7074	Av. 6	5799
10	7165	Avenida 9	4565
11	8848	Calle Buenos Aires	9447
12	7541	Calle San Martin	813
13	9425	Calle 9	1267
14	9142	Diagonal Alvear	1454
15	5890	Boulevard Constitución	8025
16	2071	Av. Omar Nuñez	7659
17	2789	Diag. 3	1211
18	6183	Camino Constitución	8511
19	7740	Avenida La Pampa	5862
20	7391	Avenida Viedma	4864
21	7446	Calle Belgrano	9550
22	3932	Diagonal La Rioja	3163
23	7816	Calle Santa Fe	2783
24	7822	Av. 163 B	1755
25	2706	Avenida 6	3805
26	2552	Calle Misiones	7768
27	9033	Av. San Martin	4543
28	7824	Av. Paraná	7889
29	4441	Calle Malvinas Argentinas	7995
30	5352	Calle Buenos Aires	5576
31	5594	Calle San Martin	1284
32	1698	Calle Catamarca	3826
33	4210	Av. Saavedra	7444
34	5301	Av. 2	582
35	5199	Calle 4	264
36	6993	Blv. Belgrano	954
37	5197	Calle Buenos Aires	7366
38	5252	Avenida Pte. Perón	3738
39	6184	Avenida 8	2520
40	4962	Diagonal Entre Ríos	6265
41	9241	Av. Alvear	1802
42	4948	Av. Malvinas Argentinas	901
43	2774	Av. Güemes	2831
44	5699	Av. San Juan	5634
45	1447	Diagonal Santa Rosa	2011
46	9431	Avenida Ushuaia	9075
47	7738	Av. Pte. Perón	4493
48	9424	Avenida Rawson	8948
49	3153	Avenida Santa Fe	2926
50	2792	Camino Paraná	4685
51	8593	Calle Omar Nuñez	854
52	3141	Calle 9	3162
53	3102	Diagonal Rawson	525
54	1910	Blv. Santa Fe	6823
55	7269	Av. Ciudad Autónoma de Buenos Aires	1549
56	6335	Avenida J.J. Castelli	5326
57	2846	Av. J.M. de Rosas	4490
58	7482	Avenida Pte. Perón	5258
59	7392	Diag. San Salvador de Jujuy	5428
60	6708	Diagonal 5	8299
61	4404	Avenida 5	5799
62	5208	Boulevard Malvinas Argentinas	9087
63	7041	Av. 5	5316
64	1950	Diagonal Neuquén	88
65	6204	Av. Mitre	5681
66	4890	Av. J.J. Castelli	5681
67	1143	Avenida Río Gallegos	5832
68	3455	Diagonal San Martin	6515
69	1317	Blv. Santa Fe	8980
70	2320	Av. Malvinas Argentinas	198
71	9200	Avenida Rivadavia	4506
72	8316	Diagonal Alem	349
73	2521	Diag. San Juan	4519
74	9348	Diagonal G. Brown	2698
75	8826	Avenida Viedma	3633
76	5382	Av. Tucumán	256
77	9256	Calle 2	1120
78	9165	Av. 7	8714
79	8379	Avenida 6	9984
80	2693	Camino Viedma	6569
81	9316	Av. La Plata	3383
82	5974	Camino Alem	2442
83	6075	Av. Catamarca	1922
84	8668	Diagonal Malvinas Argentinas	4610
85	6991	Av. Córdoba	5684
86	9430	Avenida Saavedra	328
87	6238	Diagonal Mitre	193
88	5536	Avenida J.M. de Rosas	1622
89	5612	Avenida J.B. Alberdi	2075
90	3984	Avenida Omar Nuñez	3617
91	5016	Av. Corrientes	8717
92	6481	Avenida J.B. Alberdi	9290
93	2869	Camino La Pampa	6231
94	1397	Avenida San Luis	121
95	8233	Camino Corrientes	3099
96	8883	Av. San Juan	6539
97	8690	Diag. Neuquén	3912
98	4187	Diagonal 8	6544
99	4831	Boulevard 124 Bis	4004
100	6201	Avenida Chilecito	9832
101	8056	Av. Comodoro Rivadavia	3488
102	5296	Avenida Rawson	164
103	1611	Avenida Corrientes	539
104	3316	Camino 6	7179
105	7006	Av. Córdoba	2493
106	3169	Blv. Tucumán	2288
107	6307	Avenida 7	6395
108	2369	Boulevard 129 B	7401
109	6407	Diagonal 1	9327
110	1213	Diag. 180 Bis	9292
111	3502	Camino Santa Fe	4988
112	1211	Av. Güemes	4822
113	1623	Diagonal Chaco	8543
114	6730	Diagonal 2	2144
115	8472	Avenida Saavedra	9302
116	8898	Avenida 7	1772
117	2421	Av. 2	9166
118	8741	Avenida 2	4954
119	1994	Avenida Rivadavia	5787
120	6125	Calle Santa Rosa	9124
121	6824	Avenida Buenos Aires	1268
122	1864	Avenida San Luis	5510
123	7010	Diagonal Salta	8401
124	7980	Diagonal J.B. Alberdi	862
125	6689	Calle Chilecito	1248
126	3632	Diagonal Tierra del Fuego	9563
127	8379	Av. 5	8722
128	1379	Diagonal Pte. Perón	7226
129	8589	Blv. Rosario	6120
130	6788	Calle Río Negro	5376
131	1162	Av. Alem	6767
132	8670	Av. San Luis	9090
133	1506	Avenida San Martin	7428
134	4791	Calle Santiago del Estero	536
135	4501	Boulevard La Pampa	6504
136	3267	Calle 9	3392
137	1051	Av. 8	7303
138	5261	Diagonal Formosa	2717
139	6417	Blv. Güemes	7858
140	4865	Avenida 9	2756
141	1678	Diag. Güemes	1331
142	1482	Calle 4	4707
143	5433	Av. San Salvador de Jujuy	2073
144	8184	Diag. Viedma	4581
145	4843	Diagonal Omar Nuñez	6257
146	2778	Camino Merlo	1766
147	3855	Avenida Misiones	4370
148	3579	Avenida 9	5911
149	2847	Avenida Saavedra	1973
150	3031	Diagonal J.J. Castelli	8276
151	4100	Avenida Tucumán	7704
152	7814	Boulevard Malvinas Argentinas	4442
153	4566	Avenida Merlo	8323
154	6081	Av. San Juan	1179
155	2586	Boulevard 8	8223
156	6905	Calle La Rioja	5140
157	3520	Avenida Entre Ríos	1014
158	8265	Av. J.M. de Rosas	850
159	5186	Boulevard Tucumán	1092
160	4885	Av. 3	595
161	4387	Avenida 5	2992
162	2841	Camino Rosario	1348
163	8730	Calle La Pampa	7590
164	3778	Calle Salta	9532
165	8603	Camino Córdoba	3677
166	9079	Boulevard Santa Rosa	3112
167	5876	Av. Saavedra	6019
168	1108	Diagonal 7	3472
169	9156	Avenida Constitución	6691
170	1278	Diagonal Santiago del Estero	7896
171	4736	Camino 120 A	2734
172	4493	Av. Mitre	442
173	3344	Calle San Martin	4509
174	7030	Diag. San Juan	3407
175	6281	Diagonal 2	8660
176	1070	Diag. Santa Fe	8174
177	6035	Diagonal J.J. Castelli	1446
178	1686	Calle 4	2618
179	8684	Boulevard 114 Bis	9423
180	8385	Avenida 4	3751
181	5696	Calle Alem	1571
182	7506	Camino Corrientes	15
183	3592	Diagonal 4	1986
184	4433	Diagonal Saavedra	8308
185	4298	Calle Paraná	5066
186	2116	Avenida 4	2934
187	8138	Blv. Salta	3353
188	2129	Av. Merlo	3151
189	6964	Diagonal Tierra del Fuego	3262
190	2697	Diagonal Saavedra	4204
191	2712	Diagonal Santiago del Estero	2716
192	7316	Avenida J.M. de Rosas	5984
193	8248	Calle Alem	103
194	3138	Calle 8	8215
195	8873	Blv. Rosario	8317
196	2288	Avenida 9	2768
197	8631	Calle J.B. Alberdi	9719
198	6784	Av. Formosa	6644
199	7688	Camino Río Gallegos	3443
200	5197	Av. Tierra del Fuego	5554
\.


--
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.empresa (usuario, cuit, nombre_fantasia, fecha_creacion) FROM stdin;
160	42-36051971-5	CrimsonCove	1979-12-23
146	71-81370087-7	BlissfulBoutique	1981-06-02
125	27-34366541-9	EmeraldHaven	1976-02-04
288	33-72539709-4	GoldenKey	1986-01-13
264	08-50098944-8	OceanPearls	1975-08-04
80	13-51440195-1	EmpireBuilders	2015-11-24
287	47-38026900-7	SparklingShores	1978-08-22
185	20-84695040-4	RoyalRidge	2023-06-27
170	24-90955904-6	HarmonyHomes	2002-01-15
241	01-82007788-7	UrbanNest	1994-04-23
184	46-29684693-0	SunriseVista	1997-07-18
210	99-68062312-1	UrbanHarvest	2005-12-20
132	15-26114903-4	BlueHorizon	2001-11-13
20	70-09455706-6	GlobalGenius	1982-01-23
13	12-96010460-5	SilverLining	1980-05-20
105	78-63663235-4	StarlightSplendor	2011-04-12
47	08-07866638-7	DiamondView	2013-10-12
205	24-15428440-1	UrbanVibe	1991-02-02
289	32-89972894-9	OceanBreeze	1979-10-26
117	10-58438068-0	FreshMarket	1995-08-22
22	55-07807183-9	MajesticHomes	2004-05-20
75	98-61223021-1	NatureNest	1981-10-28
246	08-15453702-2	AmbientGlow	2021-03-11
69	16-90887362-3	OceanVoyage	1976-06-03
16	76-27159296-2	EmeraldEchoes	2022-11-09
279	94-96787559-8	PacificPearls	1994-12-28
38	03-42659435-0	SwiftFoods	2014-07-21
115	66-63510695-7	ParadisePoint	2016-12-08
214	26-97364524-6	SunsetVoyage	1986-04-27
234	60-96978585-3	RadiantRidge	1983-12-04
126	77-04914173-1	SeaBreeze	1986-08-09
43	51-24368948-4	DreamCove	1995-07-30
85	51-48989553-8	StarrySkies	1986-06-25
180	48-98740865-6	WhisperingWinds	1985-05-20
54	56-52564822-3	StarView	2006-03-28
242	29-45980712-8	TechSolutions	1979-07-19
192	39-40226706-5	NaturalLiving	2021-08-17
293	59-59857208-5	TranquilHomes	1989-06-04
92	40-22381478-1	WhimsicalWoods	2020-06-28
55	36-34655531-1	CosmicCreations	1990-11-24
15	31-75994284-8	WhimsicalWaters	1986-10-24
267	12-41376607-5	LuxeDesigns	2020-01-17
95	06-64941283-5	DreamBuilders	1990-03-14
120	69-67592893-4	DC	1982-11-23
275	71-65103712-0	SunriseHomes	2000-02-10
222	49-28572533-1	NatureFresh	1984-05-24
62	87-17127064-6	OceanfrontVilla	2001-07-16
135	78-96152780-6	UrbanMix	1982-03-24
9	63-75628688-0	DreamyInteriors	1984-07-01
61	55-94126501-1	GoldenFields	1973-12-12
174	49-03070478-9	UrbanAura	2009-08-05
21	27-20362497-0	SecretSunrise	2015-02-01
211	43-30814362-8	UrbanEscape	1996-06-02
263	47-15729040-4	DazzlingDunes	1998-02-13
213	95-13257797-5	HarmonyHaven	1983-06-17
136	39-01660913-9	HarborVista	2014-11-08
245	50-06573589-8	EnchantedGardens	2005-01-22
48	72-58227481-2	InnovaTech	2009-10-03
258	16-46753428-6	ZenithBuilders	1980-11-15
26	29-39176237-4	Popper	2022-03-20
208	71-64167421-2	RadiantGrove	1975-10-04
7	80-74083823-5	DreamyDwellings	1989-04-01
240	59-58902261-8	WhisperingPines	1978-05-15
219	87-61397137-6	SunsetView	1982-06-02
25	55-48251740-5	DiamondBeauty	1998-07-15
134	97-95698813-3	SeasideEscape	2014-05-25
79	39-76058585-6	TimelessTreasures	2015-05-25
239	34-10570813-2	LuxuryLiving	1996-02-15
154	28-91956293-1	StellaMaris	1999-08-01
164	25-76443015-6	SportMax	1983-07-17
186	04-71761480-7	EnchantedSpaces	1984-08-13
188	67-37179327-6	NovaBuilders	1994-03-27
179	34-83379175-2	GoldenSunrise	1983-07-27
116	97-15842470-4	UrbanStyle	2008-03-16
19	06-70989045-9	IdeaFactory	2015-09-12
72	07-11353336-1	MoonlitMajesty	2003-06-16
238	42-61753862-6	EcoHarbor	2000-03-30
150	64-98692261-6	EliteEvents	1980-07-07
93	09-72902610-6	AmberWaves	2002-08-05
84	48-50376144-7	TechNova	1978-11-24
32	01-71375508-7	GreenSolutions	1988-01-31
147	98-39925658-9	SkylineInnovations	2008-02-26
283	29-35650819-0	NaturalElegance	1989-12-30
183	43-35322042-5	GlobalGourmet	1997-10-25
141	57-49927779-3	RainbowDesigns	1983-09-26
30	68-92334586-1	GreenPower	1985-04-14
254	16-81804489-3	BlueWave	2013-07-04
249	81-32708252-2	GoldenHarbor	1990-09-06
6	79-40250600-0	Urban	1980-01-22
66	44-91476630-4	SmartSolutions	1988-09-24
139	41-28369057-3	GoldenCoast	1985-07-22
243	87-69970883-3	OceanVista	1977-03-21
261	27-84827851-0	RadiantHomes	1979-04-22
98	69-82740492-7	Ardidas	2000-04-19
271	69-31875020-2	CreativeWorks	1995-01-10
33	11-31202191-4	MysticMinds	1993-11-17
207	55-73837924-0	StarElectronics	2022-09-11
265	58-14230444-2	SkyHighAdventures	2003-05-19
142	05-32028660-4	Mike	1992-09-29
56	76-68531852-5	GreenVibes	1991-08-02
\.


--
-- Data for Name: envio; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.envio (id_envio, tipo_envio) FROM stdin;
1	envio rapido
2	envio a correo
3	envio a correo
4	envio rapido
5	envio normal a domicilio
6	envio rapido
7	envio normal a domicilio
8	retiro en sucursal
9	envio rapido
10	envio normal a domicilio
11	envio rapido
12	envio normal a domicilio
13	envio normal a domicilio
14	retiro en sucursal
15	retiro en sucursal
16	retiro en sucursal
17	envio a correo
18	envio a correo
19	envio normal a domicilio
20	envio a correo
21	envio a correo
22	envio a correo
23	envio normal a domicilio
24	retiro en sucursal
25	envio a correo
26	envio normal a domicilio
27	envio normal a domicilio
28	envio normal a domicilio
29	retiro en sucursal
30	retiro en sucursal
31	envio a correo
32	envio a correo
33	envio rapido
34	retiro en sucursal
35	envio rapido
36	envio normal a domicilio
37	retiro en sucursal
38	envio rapido
39	envio a correo
40	envio rapido
41	envio normal a domicilio
42	retiro en sucursal
43	envio rapido
44	envio normal a domicilio
45	envio rapido
46	retiro en sucursal
47	envio a correo
48	envio rapido
49	envio rapido
50	envio a correo
51	envio a correo
52	envio a correo
53	envio normal a domicilio
54	envio normal a domicilio
55	retiro en sucursal
56	envio normal a domicilio
57	retiro en sucursal
58	envio rapido
59	envio rapido
60	envio rapido
61	retiro en sucursal
62	envio rapido
63	envio normal a domicilio
64	envio normal a domicilio
65	envio normal a domicilio
66	envio a correo
67	retiro en sucursal
68	envio normal a domicilio
69	envio a correo
70	envio rapido
71	envio normal a domicilio
72	envio normal a domicilio
73	envio rapido
74	retiro en sucursal
75	envio a correo
76	envio normal a domicilio
77	envio normal a domicilio
78	retiro en sucursal
79	envio a correo
80	envio normal a domicilio
81	envio a correo
82	retiro en sucursal
83	envio a correo
84	envio a correo
85	envio a correo
86	envio rapido
87	envio normal a domicilio
88	envio normal a domicilio
89	retiro en sucursal
90	envio normal a domicilio
91	envio rapido
92	envio rapido
93	envio a correo
94	retiro en sucursal
95	envio normal a domicilio
96	envio normal a domicilio
97	envio a correo
98	envio rapido
99	envio a correo
100	envio rapido
101	retiro en sucursal
102	envio rapido
103	retiro en sucursal
104	retiro en sucursal
105	retiro en sucursal
106	envio rapido
107	envio rapido
108	envio a correo
109	envio rapido
110	envio a correo
111	envio normal a domicilio
112	envio rapido
113	retiro en sucursal
114	envio normal a domicilio
115	retiro en sucursal
116	envio normal a domicilio
117	envio normal a domicilio
118	envio normal a domicilio
119	envio rapido
120	envio normal a domicilio
121	envio normal a domicilio
122	envio normal a domicilio
123	retiro en sucursal
124	envio rapido
125	envio normal a domicilio
126	envio a correo
127	envio a correo
128	retiro en sucursal
129	retiro en sucursal
130	envio a correo
131	envio a correo
132	envio a correo
133	envio a correo
134	envio normal a domicilio
135	envio a correo
136	envio a correo
137	retiro en sucursal
138	envio rapido
139	envio rapido
140	envio rapido
141	retiro en sucursal
142	retiro en sucursal
143	envio normal a domicilio
144	retiro en sucursal
145	envio normal a domicilio
146	envio normal a domicilio
147	envio normal a domicilio
148	envio a correo
149	retiro en sucursal
150	envio normal a domicilio
151	envio a correo
152	envio a correo
153	envio a correo
154	envio rapido
155	envio normal a domicilio
156	envio normal a domicilio
157	retiro en sucursal
158	envio a correo
159	envio normal a domicilio
160	retiro en sucursal
161	envio a correo
162	retiro en sucursal
163	envio rapido
164	retiro en sucursal
165	retiro en sucursal
166	envio rapido
167	envio a correo
168	envio normal a domicilio
169	envio normal a domicilio
170	envio normal a domicilio
171	envio a correo
172	envio normal a domicilio
173	envio normal a domicilio
174	envio rapido
175	envio normal a domicilio
176	envio rapido
177	envio rapido
178	retiro en sucursal
179	envio rapido
180	retiro en sucursal
181	envio normal a domicilio
182	retiro en sucursal
183	envio normal a domicilio
184	envio a correo
185	envio a correo
186	envio a correo
187	envio normal a domicilio
188	envio normal a domicilio
189	envio rapido
190	envio rapido
191	envio normal a domicilio
192	retiro en sucursal
193	envio rapido
194	retiro en sucursal
195	envio a correo
196	envio a correo
197	retiro en sucursal
198	envio a correo
199	envio normal a domicilio
200	envio a correo
201	envio normal a domicilio
202	envio a correo
203	retiro en sucursal
204	retiro en sucursal
205	envio a correo
206	envio rapido
207	retiro en sucursal
208	envio a correo
209	retiro en sucursal
210	envio normal a domicilio
211	envio a correo
212	retiro en sucursal
213	retiro en sucursal
214	envio rapido
215	retiro en sucursal
216	envio rapido
217	envio a correo
218	envio a correo
219	envio rapido
220	envio normal a domicilio
221	envio rapido
222	envio rapido
223	envio rapido
224	envio rapido
225	envio normal a domicilio
226	envio normal a domicilio
227	envio rapido
228	retiro en sucursal
229	envio normal a domicilio
230	envio rapido
231	envio normal a domicilio
232	envio normal a domicilio
233	envio rapido
234	envio a correo
235	envio a correo
236	envio a correo
237	envio normal a domicilio
238	retiro en sucursal
239	retiro en sucursal
240	retiro en sucursal
241	envio normal a domicilio
242	envio a correo
243	envio rapido
244	envio normal a domicilio
245	retiro en sucursal
246	envio a correo
247	envio rapido
248	envio normal a domicilio
249	retiro en sucursal
250	retiro en sucursal
251	envio rapido
252	retiro en sucursal
253	retiro en sucursal
254	retiro en sucursal
255	envio a correo
256	envio a correo
257	envio normal a domicilio
258	retiro en sucursal
259	envio normal a domicilio
260	retiro en sucursal
261	envio rapido
262	retiro en sucursal
263	envio rapido
264	retiro en sucursal
265	retiro en sucursal
266	retiro en sucursal
267	envio a correo
268	retiro en sucursal
269	envio a correo
270	envio a correo
271	envio normal a domicilio
272	envio rapido
273	envio normal a domicilio
274	envio rapido
275	envio normal a domicilio
276	retiro en sucursal
277	retiro en sucursal
278	retiro en sucursal
279	envio normal a domicilio
280	envio a correo
281	envio rapido
282	envio rapido
283	envio rapido
284	envio rapido
285	envio a correo
286	envio rapido
287	envio rapido
288	envio a correo
289	envio rapido
290	retiro en sucursal
291	envio a correo
292	envio a correo
293	retiro en sucursal
294	envio rapido
295	envio a correo
296	envio a correo
297	envio a correo
298	envio rapido
299	envio a correo
300	envio rapido
\.


--
-- Data for Name: imagen; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.imagen (producto, imagen) FROM stdin;
272	model.JPEG
167	crime.JPEG
213	reality.JPEG
52	each.JPEG
150	color.JPEG
70	situation.JPEG
1	sense.JPEG
282	company.JPEG
158	at.JPEG
3	city.JPEG
54	themselves.JPEG
39	despite.JPEG
243	Republican.JPEG
24	truth.JPEG
55	painting.JPEG
197	course.JPEG
87	night.JPEG
1	book.JPEG
180	describe.JPEG
216	say.JPEG
203	both.JPEG
107	together.JPEG
291	prove.JPEG
174	white.JPEG
86	voice.JPEG
142	offer.JPEG
214	stop.JPEG
35	human.JPEG
278	increase.JPEG
233	nice.JPEG
270	you.JPEG
169	she.JPEG
218	spend.JPEG
59	bit.JPEG
154	eight.JPEG
291	answer.JPEG
113	oil.JPEG
41	audience.JPEG
35	practice.JPEG
143	stay.JPEG
237	down.JPEG
181	friend.JPEG
260	save.JPEG
37	power.JPEG
12	company.JPEG
246	must.JPEG
19	might.JPEG
209	look.JPEG
240	piece.JPEG
217	class.JPEG
199	alone.JPEG
141	seem.JPEG
225	these.JPEG
198	author.JPEG
80	cultural.JPEG
228	see.JPEG
197	end.JPEG
119	describe.JPEG
190	beat.JPEG
70	professional.JPEG
254	skin.JPEG
194	allow.JPEG
20	will.JPEG
239	account.JPEG
205	owner.JPEG
249	number.JPEG
164	from.JPEG
248	sign.JPEG
232	though.JPEG
208	indicate.JPEG
284	expert.JPEG
53	officer.JPEG
221	example.JPEG
180	point.JPEG
298	his.JPEG
192	heavy.JPEG
142	figure.JPEG
159	explain.JPEG
198	support.JPEG
32	beautiful.JPEG
268	president.JPEG
12	do.JPEG
299	them.JPEG
196	activity.JPEG
294	option.JPEG
24	investment.JPEG
67	word.JPEG
18	down.JPEG
128	though.JPEG
283	though.JPEG
150	try.JPEG
203	lose.JPEG
269	along.JPEG
56	item.JPEG
132	executive.JPEG
154	security.JPEG
191	science.JPEG
12	be.JPEG
128	garden.JPEG
236	follow.JPEG
213	turn.JPEG
64	military.JPEG
110	service.JPEG
61	southern.JPEG
176	sound.JPEG
160	last.JPEG
221	method.JPEG
121	wide.JPEG
220	appear.JPEG
189	why.JPEG
179	type.JPEG
217	near.JPEG
189	know.JPEG
130	yeah.JPEG
191	future.JPEG
9	participant.JPEG
102	tend.JPEG
7	health.JPEG
209	hour.JPEG
67	condition.JPEG
288	water.JPEG
108	participant.JPEG
276	wide.JPEG
211	rule.JPEG
19	remain.JPEG
278	floor.JPEG
287	then.JPEG
192	home.JPEG
168	hot.JPEG
211	whatever.JPEG
115	compare.JPEG
258	last.JPEG
81	education.JPEG
111	when.JPEG
244	bag.JPEG
161	clear.JPEG
109	how.JPEG
88	response.JPEG
239	vote.JPEG
160	wide.JPEG
184	beautiful.JPEG
243	everyone.JPEG
297	activity.JPEG
15	TV.JPEG
154	quickly.JPEG
143	task.JPEG
249	receive.JPEG
295	candidate.JPEG
152	spring.JPEG
193	wall.JPEG
239	agreement.JPEG
288	economic.JPEG
80	study.JPEG
264	story.JPEG
84	network.JPEG
233	better.JPEG
280	the.JPEG
218	one.JPEG
34	claim.JPEG
110	road.JPEG
200	media.JPEG
30	that.JPEG
29	dream.JPEG
35	will.JPEG
218	international.JPEG
90	himself.JPEG
216	TV.JPEG
133	down.JPEG
277	professional.JPEG
49	strategy.JPEG
218	thousand.JPEG
212	adult.JPEG
282	wife.JPEG
71	worker.JPEG
90	as.JPEG
201	watch.JPEG
36	wish.JPEG
127	star.JPEG
285	their.JPEG
173	toward.JPEG
133	stuff.JPEG
256	or.JPEG
274	order.JPEG
198	performance.JPEG
30	toward.JPEG
273	push.JPEG
291	save.JPEG
184	coach.JPEG
140	near.JPEG
97	effect.JPEG
149	bit.JPEG
43	conference.JPEG
236	should.JPEG
294	almost.JPEG
273	parent.JPEG
100	ok.JPEG
222	several.JPEG
61	clearly.JPEG
23	democratic.JPEG
271	bit.JPEG
170	above.JPEG
20	ahead.JPEG
198	quickly.JPEG
289	write.JPEG
231	speech.JPEG
289	fire.JPEG
120	although.JPEG
229	opportunity.JPEG
88	travel.JPEG
97	magazine.JPEG
124	however.JPEG
86	arm.JPEG
44	program.JPEG
284	bill.JPEG
112	learn.JPEG
159	their.JPEG
60	personal.JPEG
240	pretty.JPEG
110	wait.JPEG
117	see.JPEG
29	behind.JPEG
37	development.JPEG
2	partner.JPEG
66	whatever.JPEG
146	indicate.JPEG
288	involve.JPEG
170	just.JPEG
89	late.JPEG
217	reality.JPEG
14	arm.JPEG
36	certainly.JPEG
42	think.JPEG
155	cover.JPEG
190	might.JPEG
153	suddenly.JPEG
200	young.JPEG
4	nation.JPEG
163	participant.JPEG
1	father.JPEG
273	country.JPEG
121	pretty.JPEG
164	thousand.JPEG
168	animal.JPEG
240	school.JPEG
248	century.JPEG
117	owner.JPEG
155	best.JPEG
25	wind.JPEG
254	pick.JPEG
280	another.JPEG
194	reveal.JPEG
53	plant.JPEG
77	kind.JPEG
161	fine.JPEG
50	ball.JPEG
28	defense.JPEG
197	president.JPEG
250	company.JPEG
277	company.JPEG
154	night.JPEG
170	president.JPEG
45	international.JPEG
180	consumer.JPEG
115	they.JPEG
131	song.JPEG
285	capital.JPEG
41	American.JPEG
138	instead.JPEG
300	boy.JPEG
247	read.JPEG
165	southern.JPEG
143	whether.JPEG
72	sign.JPEG
169	stop.JPEG
87	land.JPEG
45	piece.JPEG
94	treatment.JPEG
21	great.JPEG
264	since.JPEG
284	fight.JPEG
14	lay.JPEG
156	father.JPEG
59	citizen.JPEG
39	real.JPEG
63	almost.JPEG
225	attack.JPEG
267	student.JPEG
240	carry.JPEG
199	question.JPEG
280	present.JPEG
83	with.JPEG
36	staff.JPEG
145	focus.JPEG
208	subject.JPEG
76	best.JPEG
260	country.JPEG
197	dream.JPEG
50	together.JPEG
233	science.JPEG
266	rule.JPEG
\.


--
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.item (id_item, cantidad, estado, tipo_entrega, envio_domicilio, usuario, producto, direccion, pedido) FROM stdin;
1	8	Recibido	envio a correo	t	104	232	163	112
2	4	Recibido	retiro en sucursal	t	45	234	139	154
3	1	Recibido	retiro en sucursal	t	45	28	161	237
4	4	Listo para enviar	envio rapido	f	260	193	128	82
5	3	Listo para enviar	retiro en sucursal	f	248	103	158	264
6	4	Preparando el envio	envio rapido	f	138	233	104	267
7	2	Enviado	envio normal a domicilio	t	277	182	79	244
8	9	Preparando el envio	envio rapido	f	248	205	105	24
9	1	Preparando el envio	envio normal a domicilio	f	284	280	86	32
10	4	Recibido	envio normal a domicilio	f	114	2	121	196
11	1	Enviado	envio a correo	f	113	187	22	178
12	4	Recibido	envio rapido	t	1	96	21	177
13	3	Recibido	envio normal a domicilio	f	31	213	18	128
14	5	Enviado	envio normal a domicilio	f	103	153	10	30
15	2	Listo para enviar	envio normal a domicilio	t	91	204	5	259
16	4	Enviado	retiro en sucursal	t	35	274	185	116
17	8	Listo para enviar	envio rapido	f	216	203	2	39
18	4	Preparando el envio	retiro en sucursal	t	209	84	181	222
19	8	Recibido	envio rapido	f	83	182	28	265
20	7	Recibido	envio normal a domicilio	t	52	232	54	112
21	1	Enviado	retiro en sucursal	t	14	281	4	9
22	1	Enviado	envio normal a domicilio	t	123	234	158	221
23	2	Preparando el envio	envio rapido	t	292	70	176	40
24	9	Listo para enviar	retiro en sucursal	t	173	95	121	76
25	8	Recibido	retiro en sucursal	t	91	103	155	179
26	5	Listo para enviar	envio a correo	f	294	259	200	215
27	5	Listo para enviar	retiro en sucursal	f	27	120	140	213
28	6	Recibido	retiro en sucursal	f	123	279	165	280
29	2	Preparando el envio	retiro en sucursal	f	197	120	138	239
30	4	Preparando el envio	envio rapido	t	228	180	94	174
31	1	Listo para enviar	envio a correo	f	190	25	25	79
32	2	Listo para enviar	envio rapido	f	108	31	78	144
33	2	Listo para enviar	envio normal a domicilio	f	255	51	100	260
34	1	Recibido	envio rapido	t	96	182	102	28
35	6	Recibido	envio a correo	f	153	263	194	157
36	1	Preparando el envio	envio normal a domicilio	f	44	5	146	89
37	3	Recibido	retiro en sucursal	f	152	238	164	296
38	6	Recibido	retiro en sucursal	f	190	234	157	55
39	8	Enviado	envio rapido	t	190	189	171	216
40	8	Recibido	retiro en sucursal	t	112	101	3	111
41	9	Enviado	retiro en sucursal	f	268	64	36	218
42	1	Listo para enviar	retiro en sucursal	t	36	40	141	73
43	4	Listo para enviar	envio normal a domicilio	f	209	39	141	131
44	4	Recibido	retiro en sucursal	t	155	204	151	222
45	2	Listo para enviar	envio normal a domicilio	t	101	182	139	45
46	6	Enviado	retiro en sucursal	t	199	32	41	191
47	3	Preparando el envio	envio rapido	f	4	22	190	42
48	3	Recibido	envio a correo	t	171	28	38	226
49	9	Preparando el envio	envio rapido	f	121	267	47	132
50	8	Listo para enviar	envio normal a domicilio	t	101	136	172	58
51	6	Preparando el envio	envio normal a domicilio	t	101	68	195	116
52	4	Recibido	envio normal a domicilio	f	101	135	31	110
53	7	Enviado	retiro en sucursal	f	107	159	200	85
54	4	Listo para enviar	retiro en sucursal	t	104	239	137	95
55	1	Preparando el envio	envio normal a domicilio	f	181	88	57	158
56	4	Preparando el envio	envio normal a domicilio	t	281	186	97	139
57	1	Listo para enviar	envio a correo	t	206	8	188	112
58	1	Listo para enviar	envio normal a domicilio	f	198	24	140	205
59	9	Enviado	envio normal a domicilio	t	220	130	139	273
60	2	Listo para enviar	envio rapido	f	172	179	17	256
61	7	Preparando el envio	envio normal a domicilio	f	177	20	85	239
62	9	Enviado	envio a correo	f	18	277	106	85
63	6	Preparando el envio	envio a correo	t	148	65	82	87
64	8	Listo para enviar	retiro en sucursal	t	145	276	34	231
65	6	Recibido	envio rapido	t	272	245	76	62
66	7	Listo para enviar	envio rapido	f	40	248	163	30
67	1	Preparando el envio	envio a correo	t	165	233	195	44
68	2	Recibido	envio rapido	f	253	297	28	55
69	4	Enviado	retiro en sucursal	t	200	167	15	156
70	7	Preparando el envio	retiro en sucursal	t	81	21	138	76
71	5	Enviado	envio a correo	f	197	81	58	148
72	1	Preparando el envio	envio a correo	t	167	92	176	92
73	5	Preparando el envio	envio rapido	f	168	286	29	20
74	9	Preparando el envio	envio normal a domicilio	f	114	26	71	228
75	3	Preparando el envio	envio rapido	f	89	83	50	299
76	6	Listo para enviar	envio rapido	t	165	274	19	275
77	4	Preparando el envio	retiro en sucursal	f	151	154	146	50
78	2	Preparando el envio	envio normal a domicilio	t	82	160	153	173
79	9	Preparando el envio	envio rapido	f	235	30	60	252
80	9	Enviado	envio a correo	t	63	65	70	95
81	6	Enviado	envio a correo	f	166	165	34	20
82	9	Enviado	retiro en sucursal	f	41	62	60	171
83	7	Listo para enviar	envio a correo	t	45	103	59	219
84	5	Listo para enviar	retiro en sucursal	f	253	29	184	61
85	1	Listo para enviar	retiro en sucursal	t	217	265	15	172
86	8	Recibido	envio normal a domicilio	f	145	30	182	185
87	8	Enviado	retiro en sucursal	t	106	30	52	248
88	2	Preparando el envio	envio a correo	f	255	46	121	153
89	1	Recibido	envio normal a domicilio	t	45	90	164	175
90	7	Preparando el envio	envio normal a domicilio	t	3	179	5	233
91	7	Preparando el envio	envio rapido	t	5	266	96	140
92	3	Listo para enviar	envio normal a domicilio	t	190	284	24	147
93	3	Listo para enviar	envio normal a domicilio	f	59	291	170	236
94	7	Recibido	envio rapido	f	68	114	129	22
95	2	Preparando el envio	envio normal a domicilio	f	300	275	195	212
96	4	Recibido	envio rapido	f	28	241	125	245
97	3	Enviado	envio rapido	t	247	183	97	159
98	1	Preparando el envio	envio a correo	f	209	27	167	8
99	5	Recibido	retiro en sucursal	t	64	139	158	9
100	6	Listo para enviar	envio normal a domicilio	f	272	230	129	126
101	3	Enviado	envio normal a domicilio	t	270	297	185	73
102	4	Listo para enviar	retiro en sucursal	f	58	96	62	288
103	1	Listo para enviar	retiro en sucursal	f	97	283	92	242
104	4	Enviado	envio a correo	f	172	212	50	15
105	1	Enviado	envio normal a domicilio	f	128	281	27	288
106	1	Listo para enviar	envio rapido	t	88	192	45	1
107	1	Enviado	envio rapido	f	37	281	130	293
108	1	Enviado	envio normal a domicilio	t	123	32	40	169
109	1	Enviado	envio a correo	t	18	75	116	11
110	3	Listo para enviar	envio a correo	t	177	170	98	109
111	6	Recibido	envio rapido	f	217	118	25	113
112	1	Recibido	retiro en sucursal	f	272	233	155	8
113	9	Preparando el envio	envio a correo	f	159	224	1	245
114	1	Enviado	envio normal a domicilio	f	91	241	98	79
115	4	Listo para enviar	envio normal a domicilio	t	291	134	5	72
116	8	Preparando el envio	envio rapido	f	226	20	52	83
117	7	Recibido	envio normal a domicilio	f	282	29	154	141
118	4	Preparando el envio	retiro en sucursal	t	138	148	37	154
119	1	Preparando el envio	envio normal a domicilio	f	291	149	112	83
120	5	Preparando el envio	envio normal a domicilio	f	103	256	130	78
121	7	Preparando el envio	retiro en sucursal	f	106	261	100	148
122	4	Preparando el envio	envio rapido	f	78	21	76	52
123	1	Enviado	envio rapido	f	196	13	25	292
124	9	Enviado	envio a correo	t	101	4	143	230
125	7	Recibido	envio normal a domicilio	f	99	297	17	200
126	9	Recibido	retiro en sucursal	t	193	99	173	199
127	2	Listo para enviar	envio rapido	t	1	75	34	102
128	5	Listo para enviar	retiro en sucursal	t	247	113	61	232
129	9	Listo para enviar	envio rapido	f	221	202	178	31
130	6	Recibido	envio normal a domicilio	t	68	27	143	183
131	9	Recibido	envio a correo	t	39	21	107	95
132	4	Listo para enviar	envio rapido	f	197	87	163	264
133	1	Recibido	envio a correo	f	276	112	65	24
134	6	Listo para enviar	retiro en sucursal	t	108	264	73	243
135	8	Enviado	envio rapido	t	18	266	69	248
136	2	Preparando el envio	envio normal a domicilio	t	159	268	178	173
137	2	Enviado	envio a correo	f	3	163	102	137
138	6	Preparando el envio	envio a correo	t	107	241	167	64
139	3	Listo para enviar	envio normal a domicilio	f	236	236	158	18
140	2	Listo para enviar	retiro en sucursal	f	272	257	72	211
141	7	Listo para enviar	retiro en sucursal	f	29	291	181	192
142	8	Listo para enviar	envio a correo	t	96	41	71	272
143	5	Preparando el envio	envio rapido	t	226	275	97	187
144	5	Listo para enviar	retiro en sucursal	t	281	230	63	96
145	2	Preparando el envio	envio rapido	t	172	300	69	179
146	3	Preparando el envio	envio normal a domicilio	f	67	100	115	235
147	6	Preparando el envio	envio rapido	f	67	113	150	297
148	1	Enviado	envio normal a domicilio	t	76	171	188	5
149	8	Preparando el envio	envio a correo	f	99	88	156	3
150	8	Listo para enviar	envio normal a domicilio	f	223	48	92	160
151	1	Enviado	envio rapido	t	203	95	88	275
152	3	Listo para enviar	envio normal a domicilio	t	118	222	130	44
153	2	Listo para enviar	envio a correo	f	223	12	88	74
154	9	Recibido	retiro en sucursal	f	104	166	120	162
155	8	Recibido	envio a correo	f	114	192	18	269
156	8	Recibido	envio normal a domicilio	f	106	221	77	185
157	2	Recibido	envio normal a domicilio	f	8	295	182	104
158	7	Enviado	envio normal a domicilio	f	44	255	108	52
159	6	Recibido	retiro en sucursal	t	171	205	32	60
160	3	Recibido	envio normal a domicilio	t	260	151	16	279
161	9	Preparando el envio	envio a correo	f	138	159	136	94
162	6	Recibido	envio a correo	t	175	116	176	231
163	1	Recibido	retiro en sucursal	t	212	251	115	44
164	8	Listo para enviar	envio a correo	t	285	126	112	19
165	8	Preparando el envio	envio a correo	t	273	284	69	223
166	4	Enviado	envio rapido	f	106	60	108	69
167	7	Recibido	envio a correo	f	256	228	146	130
168	4	Recibido	envio rapido	f	68	98	115	239
169	3	Enviado	envio normal a domicilio	f	299	264	124	276
170	9	Recibido	retiro en sucursal	f	286	243	3	85
171	1	Enviado	envio normal a domicilio	f	29	86	178	256
172	6	Enviado	envio normal a domicilio	t	277	21	106	282
173	8	Listo para enviar	envio a correo	t	34	136	47	183
174	4	Recibido	envio normal a domicilio	f	226	46	63	186
175	2	Enviado	retiro en sucursal	t	284	208	89	273
176	7	Recibido	envio a correo	f	196	264	43	85
177	1	Enviado	retiro en sucursal	f	163	244	49	276
178	9	Enviado	envio a correo	t	60	300	165	80
179	3	Enviado	envio rapido	f	295	45	153	142
180	1	Preparando el envio	envio normal a domicilio	f	178	154	7	299
181	3	Recibido	retiro en sucursal	t	3	187	154	10
182	3	Enviado	envio a correo	f	292	116	86	288
183	3	Listo para enviar	envio normal a domicilio	t	153	2	135	241
184	2	Recibido	envio a correo	t	83	13	174	119
185	1	Preparando el envio	envio rapido	f	60	71	26	165
186	4	Listo para enviar	retiro en sucursal	t	42	44	143	102
187	1	Recibido	envio normal a domicilio	f	113	52	8	239
188	2	Listo para enviar	envio a correo	t	253	29	190	181
189	1	Listo para enviar	envio rapido	t	97	280	139	294
190	7	Enviado	retiro en sucursal	f	122	164	176	85
191	6	Enviado	envio normal a domicilio	t	268	291	156	45
192	3	Enviado	envio normal a domicilio	f	70	270	128	260
193	2	Listo para enviar	envio a correo	t	149	128	28	216
194	9	Preparando el envio	retiro en sucursal	f	81	271	200	31
195	4	Enviado	envio normal a domicilio	t	272	289	119	294
196	6	Recibido	envio normal a domicilio	t	100	3	187	176
197	8	Enviado	envio a correo	t	18	10	179	124
198	1	Enviado	envio rapido	f	270	207	177	84
199	6	Enviado	retiro en sucursal	f	109	261	74	81
200	1	Preparando el envio	envio a correo	t	270	251	37	118
201	3	Preparando el envio	envio normal a domicilio	t	11	300	200	177
202	4	Listo para enviar	envio normal a domicilio	f	123	88	158	136
203	8	Recibido	retiro en sucursal	t	99	24	148	163
204	4	Listo para enviar	retiro en sucursal	f	268	34	43	83
205	8	Preparando el envio	envio a correo	f	51	32	88	236
206	6	Recibido	envio rapido	t	88	221	158	63
207	7	Listo para enviar	envio normal a domicilio	t	277	196	193	7
208	9	Preparando el envio	retiro en sucursal	t	94	45	148	145
209	2	Listo para enviar	envio rapido	f	128	199	43	57
210	1	Preparando el envio	retiro en sucursal	f	236	62	46	129
211	6	Recibido	envio rapido	t	31	264	176	7
212	9	Listo para enviar	envio normal a domicilio	t	281	249	3	86
213	4	Preparando el envio	envio normal a domicilio	t	73	198	110	169
214	7	Preparando el envio	retiro en sucursal	t	297	206	65	284
215	3	Recibido	envio a correo	t	169	202	90	122
216	1	Recibido	envio a correo	t	10	168	181	286
217	3	Enviado	envio a correo	t	191	104	56	241
218	2	Recibido	retiro en sucursal	f	209	41	73	46
219	9	Enviado	envio a correo	f	83	69	109	21
220	3	Recibido	envio rapido	f	177	282	48	123
221	4	Listo para enviar	envio rapido	t	109	123	99	86
222	1	Listo para enviar	retiro en sucursal	f	203	1	10	17
223	4	Recibido	envio a correo	f	37	209	8	127
224	3	Listo para enviar	envio a correo	f	300	206	113	297
225	5	Enviado	retiro en sucursal	t	149	152	131	10
226	4	Listo para enviar	envio a correo	t	182	61	187	13
227	3	Preparando el envio	envio a correo	f	223	10	167	246
228	5	Recibido	retiro en sucursal	t	203	234	156	219
229	4	Listo para enviar	retiro en sucursal	f	284	126	21	276
230	4	Enviado	retiro en sucursal	f	113	104	124	196
231	5	Enviado	retiro en sucursal	t	171	146	76	26
232	1	Preparando el envio	envio normal a domicilio	f	144	223	189	161
233	7	Enviado	envio rapido	t	244	102	173	73
234	8	Enviado	envio rapido	t	31	192	124	19
235	1	Recibido	envio a correo	t	209	129	53	124
236	7	Listo para enviar	retiro en sucursal	t	173	289	114	201
237	1	Listo para enviar	envio a correo	t	248	163	165	116
238	1	Listo para enviar	envio rapido	t	259	211	77	72
239	2	Enviado	envio rapido	t	131	299	6	41
240	5	Listo para enviar	envio normal a domicilio	t	273	186	56	150
241	6	Listo para enviar	envio a correo	t	197	258	166	95
242	7	Preparando el envio	envio rapido	t	278	72	5	114
243	6	Listo para enviar	envio rapido	f	108	179	169	84
244	2	Recibido	envio normal a domicilio	t	137	212	12	229
245	2	Preparando el envio	envio normal a domicilio	t	163	275	41	53
246	1	Preparando el envio	envio a correo	f	193	38	82	113
247	1	Enviado	envio rapido	t	94	271	155	87
248	6	Listo para enviar	envio a correo	f	29	64	35	66
249	8	Preparando el envio	envio rapido	f	284	189	10	130
250	9	Recibido	envio a correo	t	198	93	76	109
251	5	Preparando el envio	envio rapido	t	45	195	50	223
252	5	Enviado	envio a correo	f	27	152	44	165
253	3	Preparando el envio	envio rapido	t	226	273	164	107
254	2	Listo para enviar	envio rapido	f	217	194	182	165
255	3	Recibido	retiro en sucursal	t	5	205	67	65
256	5	Listo para enviar	envio rapido	f	41	8	192	113
257	6	Preparando el envio	envio a correo	f	237	134	151	167
258	1	Listo para enviar	retiro en sucursal	t	251	80	72	40
259	8	Listo para enviar	envio a correo	f	109	225	153	81
260	8	Enviado	envio normal a domicilio	f	119	260	130	137
261	7	Listo para enviar	retiro en sucursal	f	157	277	25	130
262	4	Recibido	envio a correo	f	233	101	9	238
263	1	Recibido	retiro en sucursal	t	181	200	8	68
264	8	Recibido	envio normal a domicilio	f	195	153	43	295
265	8	Preparando el envio	retiro en sucursal	t	273	145	24	224
266	4	Listo para enviar	envio rapido	t	233	295	164	40
267	3	Recibido	envio a correo	f	122	103	10	25
268	6	Listo para enviar	envio normal a domicilio	t	151	57	46	233
269	9	Preparando el envio	retiro en sucursal	t	177	247	124	121
270	3	Listo para enviar	envio rapido	t	37	44	81	219
271	1	Recibido	envio rapido	f	273	259	113	212
272	1	Listo para enviar	envio normal a domicilio	t	2	271	116	294
273	4	Enviado	envio a correo	t	145	102	33	109
274	7	Enviado	retiro en sucursal	f	200	283	93	253
275	2	Preparando el envio	retiro en sucursal	t	58	20	183	125
276	6	Enviado	envio a correo	f	128	182	38	103
277	6	Recibido	envio rapido	f	113	26	69	213
278	6	Listo para enviar	envio normal a domicilio	f	110	206	108	276
279	6	Enviado	envio rapido	f	159	22	29	265
280	3	Recibido	envio rapido	f	88	274	128	2
281	3	Listo para enviar	envio normal a domicilio	t	177	127	189	271
282	1	Preparando el envio	envio a correo	t	153	155	119	6
283	6	Enviado	envio normal a domicilio	f	121	86	128	84
284	3	Recibido	envio a correo	f	94	166	59	113
285	1	Enviado	envio rapido	t	229	228	35	283
286	4	Recibido	envio rapido	t	99	148	157	1
287	8	Listo para enviar	envio a correo	f	162	181	169	158
288	4	Listo para enviar	envio normal a domicilio	f	71	269	42	20
289	5	Preparando el envio	envio normal a domicilio	t	201	74	30	263
290	4	Enviado	envio a correo	f	83	291	117	270
291	8	Listo para enviar	envio a correo	f	119	298	160	178
292	2	Enviado	envio a correo	f	119	169	88	79
293	6	Preparando el envio	envio normal a domicilio	t	197	54	48	216
294	3	Preparando el envio	envio normal a domicilio	f	111	209	177	148
295	4	Preparando el envio	retiro en sucursal	t	74	154	20	121
296	4	Recibido	envio a correo	f	50	46	39	74
297	4	Enviado	envio a correo	t	148	59	84	59
298	3	Enviado	retiro en sucursal	t	64	197	34	166
299	2	Preparando el envio	envio normal a domicilio	f	194	250	160	108
300	2	Enviado	envio rapido	t	110	273	89	183
301	4	Recibido	envio rapido	f	253	83	129	240
302	5	Recibido	envio a correo	t	49	200	137	58
303	5	Preparando el envio	envio rapido	f	255	192	183	101
304	5	Enviado	envio normal a domicilio	f	161	110	137	202
305	1	Listo para enviar	envio normal a domicilio	t	182	186	127	27
306	9	Preparando el envio	envio rapido	f	297	188	116	24
307	4	Recibido	envio normal a domicilio	t	53	13	41	121
308	1	Recibido	envio normal a domicilio	t	237	198	135	19
309	7	Preparando el envio	envio rapido	f	230	53	182	217
310	6	Enviado	envio normal a domicilio	f	172	287	93	153
311	1	Enviado	envio a correo	f	195	26	72	293
312	9	Listo para enviar	envio rapido	t	282	88	170	298
313	1	Listo para enviar	envio rapido	f	5	27	4	280
314	8	Recibido	envio a correo	f	200	36	23	278
315	1	Preparando el envio	retiro en sucursal	t	102	53	42	263
316	1	Recibido	envio normal a domicilio	f	196	74	50	74
317	8	Enviado	envio rapido	t	140	103	95	172
318	1	Enviado	envio normal a domicilio	t	89	80	56	38
319	2	Listo para enviar	envio rapido	t	290	26	5	248
320	2	Enviado	retiro en sucursal	f	297	294	95	34
321	7	Recibido	envio a correo	t	295	200	75	224
322	5	Recibido	envio rapido	f	215	275	146	245
323	6	Preparando el envio	retiro en sucursal	f	198	219	167	246
324	3	Preparando el envio	envio normal a domicilio	f	228	194	121	290
325	3	Preparando el envio	envio a correo	f	128	120	154	299
326	5	Listo para enviar	envio a correo	f	230	210	87	158
327	4	Preparando el envio	envio rapido	f	137	221	12	104
328	8	Recibido	envio normal a domicilio	t	99	118	181	221
329	1	Recibido	envio normal a domicilio	t	78	213	66	298
330	4	Preparando el envio	envio normal a domicilio	f	176	116	128	39
331	7	Enviado	retiro en sucursal	t	172	225	57	28
332	7	Recibido	retiro en sucursal	t	220	187	138	177
333	1	Recibido	envio rapido	t	221	186	133	53
334	3	Enviado	envio normal a domicilio	f	2	53	138	164
335	7	Enviado	envio normal a domicilio	f	114	255	104	202
336	7	Preparando el envio	envio a correo	f	295	264	57	254
337	2	Preparando el envio	envio rapido	f	100	170	90	157
338	5	Listo para enviar	retiro en sucursal	t	46	219	91	289
339	4	Preparando el envio	retiro en sucursal	f	40	88	51	277
340	1	Listo para enviar	envio a correo	f	220	220	40	245
341	1	Listo para enviar	envio rapido	t	83	184	193	172
342	9	Listo para enviar	envio normal a domicilio	t	153	173	85	156
343	6	Enviado	envio normal a domicilio	t	280	149	115	174
344	5	Listo para enviar	envio normal a domicilio	f	49	5	26	158
345	9	Listo para enviar	retiro en sucursal	f	71	227	86	235
346	2	Listo para enviar	envio normal a domicilio	f	109	4	153	285
347	6	Listo para enviar	envio rapido	t	53	185	45	175
348	2	Enviado	envio a correo	f	29	99	150	67
349	1	Preparando el envio	envio a correo	t	155	167	2	124
350	4	Enviado	envio rapido	f	244	284	97	253
351	7	Preparando el envio	envio normal a domicilio	f	225	28	192	213
352	1	Recibido	retiro en sucursal	t	300	78	16	106
353	9	Listo para enviar	retiro en sucursal	f	298	269	100	52
354	7	Enviado	envio normal a domicilio	f	143	217	61	234
355	9	Preparando el envio	envio normal a domicilio	f	203	241	184	255
356	2	Listo para enviar	envio normal a domicilio	t	218	216	161	92
357	5	Enviado	envio rapido	f	41	136	57	290
358	1	Enviado	envio normal a domicilio	t	2	68	36	237
359	9	Preparando el envio	envio a correo	t	35	8	85	271
360	2	Listo para enviar	envio rapido	t	86	296	103	289
361	3	Preparando el envio	retiro en sucursal	f	11	295	89	34
362	5	Listo para enviar	envio a correo	f	110	124	65	218
363	1	Recibido	retiro en sucursal	t	218	133	128	48
364	9	Enviado	envio a correo	t	37	30	150	140
365	8	Preparando el envio	envio a correo	f	276	87	193	148
366	8	Listo para enviar	envio normal a domicilio	f	252	32	142	133
367	9	Preparando el envio	envio a correo	f	87	174	195	25
368	8	Enviado	retiro en sucursal	t	291	2	119	174
369	3	Preparando el envio	envio normal a domicilio	f	144	206	98	2
370	6	Recibido	envio normal a domicilio	t	40	111	107	40
371	6	Recibido	retiro en sucursal	f	244	8	124	128
372	6	Listo para enviar	retiro en sucursal	t	3	136	140	45
373	1	Preparando el envio	envio rapido	t	108	137	133	286
374	9	Preparando el envio	retiro en sucursal	f	163	199	39	81
375	6	Preparando el envio	envio a correo	f	171	287	66	299
376	1	Recibido	envio a correo	f	71	257	98	192
377	8	Enviado	envio normal a domicilio	f	145	196	19	75
378	1	Listo para enviar	retiro en sucursal	f	100	39	134	34
379	5	Recibido	retiro en sucursal	f	269	81	120	141
380	4	Preparando el envio	envio a correo	f	110	10	171	178
381	7	Recibido	envio a correo	t	231	130	29	237
382	3	Preparando el envio	envio rapido	f	87	209	46	276
383	7	Recibido	retiro en sucursal	t	277	17	53	54
384	8	Recibido	envio rapido	t	294	37	180	206
385	3	Listo para enviar	envio a correo	f	35	35	183	278
386	9	Recibido	retiro en sucursal	t	108	215	120	134
387	5	Preparando el envio	envio a correo	f	99	58	69	185
388	3	Listo para enviar	retiro en sucursal	f	114	64	59	207
389	7	Listo para enviar	envio normal a domicilio	t	244	65	134	274
390	2	Enviado	envio normal a domicilio	f	35	90	80	269
391	9	Listo para enviar	envio a correo	f	196	155	99	249
392	2	Recibido	envio normal a domicilio	t	298	150	95	38
393	9	Listo para enviar	envio normal a domicilio	f	194	137	98	217
394	1	Listo para enviar	retiro en sucursal	f	195	162	106	217
395	6	Enviado	retiro en sucursal	t	63	41	62	219
396	5	Enviado	retiro en sucursal	t	149	247	103	159
397	1	Enviado	envio rapido	t	91	230	188	111
398	1	Recibido	envio rapido	t	82	59	91	261
399	9	Recibido	envio rapido	t	198	260	49	60
400	5	Enviado	retiro en sucursal	t	58	99	195	96
401	8	Recibido	envio rapido	f	99	51	59	267
402	7	Listo para enviar	envio rapido	t	119	144	116	169
403	1	Listo para enviar	envio rapido	t	229	240	26	121
404	2	Recibido	envio normal a domicilio	f	172	205	9	93
405	1	Preparando el envio	envio normal a domicilio	t	137	277	173	65
406	4	Enviado	envio a correo	f	159	269	4	141
407	4	Recibido	envio normal a domicilio	t	53	163	149	176
408	9	Listo para enviar	envio rapido	t	225	178	169	193
409	6	Recibido	envio rapido	t	220	115	196	88
410	6	Enviado	envio rapido	f	28	271	31	197
411	6	Recibido	envio rapido	t	290	141	53	225
412	9	Recibido	envio a correo	t	28	9	71	224
413	6	Enviado	retiro en sucursal	t	252	123	131	45
414	8	Listo para enviar	envio normal a domicilio	t	10	184	58	58
415	3	Listo para enviar	envio normal a domicilio	f	167	173	60	269
416	7	Enviado	envio normal a domicilio	f	118	297	23	194
417	7	Recibido	retiro en sucursal	t	217	298	68	273
418	2	Enviado	envio rapido	f	60	63	72	267
419	6	Recibido	envio normal a domicilio	f	77	261	63	32
420	7	Listo para enviar	envio a correo	t	28	90	152	206
421	2	Preparando el envio	envio rapido	f	18	239	98	277
422	1	Listo para enviar	envio normal a domicilio	t	145	209	106	257
423	4	Preparando el envio	envio normal a domicilio	f	255	206	162	94
424	5	Recibido	envio a correo	f	256	14	122	218
425	8	Preparando el envio	envio normal a domicilio	t	130	248	14	38
426	2	Recibido	envio normal a domicilio	f	235	26	91	84
427	5	Recibido	envio a correo	t	106	102	198	6
428	2	Recibido	retiro en sucursal	t	71	90	59	28
429	7	Recibido	envio a correo	f	65	136	87	245
430	2	Recibido	retiro en sucursal	f	232	180	74	66
431	6	Enviado	envio a correo	t	250	183	34	36
432	7	Recibido	envio normal a domicilio	f	244	279	141	131
433	5	Enviado	envio normal a domicilio	t	5	33	175	60
434	7	Listo para enviar	envio rapido	f	206	131	107	254
435	1	Recibido	envio normal a domicilio	t	52	145	150	71
436	7	Recibido	envio a correo	t	14	201	44	175
437	5	Recibido	retiro en sucursal	t	260	230	91	145
438	6	Listo para enviar	envio rapido	f	68	265	119	212
439	4	Listo para enviar	envio a correo	t	89	158	84	43
440	9	Enviado	envio normal a domicilio	f	297	237	82	152
441	4	Listo para enviar	retiro en sucursal	f	230	196	44	149
442	8	Recibido	envio rapido	t	39	217	36	190
443	3	Enviado	retiro en sucursal	f	82	142	20	239
444	3	Preparando el envio	envio a correo	t	262	300	44	175
445	9	Enviado	envio rapido	f	131	199	28	15
446	4	Recibido	retiro en sucursal	t	159	239	174	259
447	7	Recibido	retiro en sucursal	t	140	227	144	263
448	8	Recibido	retiro en sucursal	f	193	176	109	47
449	1	Listo para enviar	envio rapido	f	172	64	177	194
450	5	Listo para enviar	envio normal a domicilio	f	129	27	43	142
451	1	Enviado	envio a correo	t	270	5	97	96
452	6	Recibido	retiro en sucursal	f	152	14	152	39
453	6	Preparando el envio	envio normal a domicilio	t	8	84	133	98
454	8	Enviado	envio normal a domicilio	f	63	74	165	97
455	1	Enviado	envio rapido	f	1	253	140	285
456	5	Recibido	retiro en sucursal	f	218	202	14	84
457	2	Enviado	retiro en sucursal	t	300	289	146	77
458	9	Enviado	envio a correo	f	39	177	93	18
459	7	Listo para enviar	envio rapido	t	176	57	75	188
460	1	Recibido	envio rapido	t	71	148	31	54
461	1	Preparando el envio	envio a correo	f	82	145	193	85
462	7	Recibido	envio normal a domicilio	f	226	272	102	278
463	2	Enviado	retiro en sucursal	t	46	151	110	4
464	9	Recibido	envio a correo	f	41	97	160	31
465	9	Recibido	envio rapido	f	112	262	149	266
466	7	Enviado	envio rapido	f	175	82	119	37
467	7	Listo para enviar	envio rapido	f	235	98	143	84
468	1	Recibido	retiro en sucursal	t	284	49	94	64
469	5	Enviado	envio rapido	t	128	92	88	232
470	2	Recibido	envio rapido	f	250	185	110	148
471	4	Listo para enviar	envio rapido	t	31	76	129	48
472	6	Preparando el envio	retiro en sucursal	t	224	18	28	147
473	1	Listo para enviar	envio a correo	f	295	167	135	22
474	8	Recibido	retiro en sucursal	f	196	90	120	293
475	1	Recibido	retiro en sucursal	f	78	243	127	278
476	1	Listo para enviar	envio rapido	t	34	286	78	259
477	6	Preparando el envio	envio rapido	t	106	36	176	300
478	9	Enviado	retiro en sucursal	t	255	296	162	156
479	1	Preparando el envio	envio rapido	f	230	96	2	137
480	9	Preparando el envio	retiro en sucursal	f	82	62	49	280
481	8	Preparando el envio	envio normal a domicilio	t	129	109	122	71
482	1	Listo para enviar	envio rapido	f	49	189	154	211
483	2	Listo para enviar	retiro en sucursal	t	148	250	163	13
484	1	Listo para enviar	envio rapido	f	58	149	23	269
485	8	Enviado	envio a correo	t	269	59	122	233
486	1	Preparando el envio	retiro en sucursal	f	189	293	58	16
487	9	Preparando el envio	envio rapido	t	88	251	71	96
488	8	Preparando el envio	retiro en sucursal	f	259	238	121	299
489	4	Recibido	retiro en sucursal	t	87	20	155	216
490	9	Preparando el envio	envio a correo	f	223	50	190	127
491	2	Enviado	retiro en sucursal	f	11	97	133	267
492	5	Recibido	envio a correo	t	277	58	164	146
493	4	Recibido	envio rapido	f	57	225	154	290
494	9	Listo para enviar	retiro en sucursal	f	273	194	3	262
495	2	Recibido	envio a correo	f	91	18	191	30
496	3	Listo para enviar	envio a correo	t	277	198	136	41
497	1	Preparando el envio	envio a correo	f	159	153	33	268
498	1	Listo para enviar	retiro en sucursal	f	112	184	10	75
499	1	Enviado	envio normal a domicilio	t	159	89	108	143
500	5	Listo para enviar	envio rapido	f	29	222	155	69
\.


--
-- Data for Name: item_envio; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.item_envio (item, envio) FROM stdin;
200	31
114	86
457	237
494	26
171	248
183	161
11	133
71	288
77	147
48	93
310	24
230	8
97	194
222	101
464	271
416	39
395	58
363	2
369	281
80	267
463	183
340	187
382	130
473	220
181	92
249	182
453	76
283	147
110	164
174	68
437	111
378	182
212	287
55	157
277	122
138	60
443	1
320	80
81	68
45	276
70	49
372	186
51	294
79	262
254	254
132	5
465	178
42	190
415	233
490	277
234	175
40	198
121	58
189	238
375	199
275	220
376	190
182	216
492	65
96	276
235	29
314	209
319	92
194	97
338	137
159	146
305	247
288	137
432	227
91	118
240	29
362	216
476	210
445	35
73	132
439	102
87	4
216	125
426	125
374	50
28	183
428	277
349	129
368	152
333	253
300	11
47	111
209	99
271	196
86	61
336	296
321	162
359	62
111	44
390	70
316	159
220	228
224	220
418	152
109	179
155	203
292	21
2	96
458	99
263	179
245	84
53	269
177	14
68	12
262	64
364	223
322	71
229	40
156	284
396	264
383	89
90	221
435	110
280	131
342	17
199	100
425	195
409	121
296	15
140	38
146	65
16	264
380	247
35	227
407	279
104	289
248	172
462	289
141	62
454	79
15	297
164	271
365	237
56	40
389	104
384	241
269	193
421	76
107	264
489	9
233	48
315	50
17	142
434	30
461	168
449	233
179	147
411	241
232	214
134	7
285	198
99	236
102	31
346	137
451	230
76	48
431	169
327	288
273	189
118	44
452	24
214	132
112	245
19	223
373	7
187	182
379	124
247	75
116	157
131	130
341	142
192	156
381	25
67	33
402	245
120	277
7	2
242	185
469	5
193	176
265	294
123	102
252	78
311	248
446	59
135	294
441	194
258	243
119	109
113	244
481	197
38	20
387	91
309	70
24	16
442	247
486	245
361	216
329	236
190	16
345	244
344	291
228	89
10	25
58	88
332	260
355	15
150	252
137	146
60	195
22	262
147	199
251	186
9	6
241	242
170	294
326	8
4	133
46	63
393	19
298	72
238	4
447	201
126	133
157	230
470	22
33	199
377	204
468	64
399	69
324	60
143	217
272	274
221	28
78	21
236	68
63	287
354	59
268	243
480	98
201	226
115	254
210	96
357	166
267	278
274	4
108	219
30	232
49	265
360	135
356	207
130	242
213	156
153	2
438	283
41	117
497	70
95	169
291	81
206	233
225	64
125	110
83	114
474	16
257	32
202	232
499	206
69	139
385	84
386	68
27	295
237	100
264	81
62	144
312	9
282	200
166	168
44	125
471	127
36	215
29	30
391	278
284	5
484	65
303	281
3	177
127	249
246	244
82	118
180	141
295	209
8	155
253	46
54	223
26	72
\.


--
-- Data for Name: metodo_de_pago; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.metodo_de_pago (id_tarjeta, titular, numero_tarjeta, clave_seguridad, fecha_caducidad, empresa_emisora, tipo, usuario) FROM stdin;
1	Jazmin Morena Dominguez	9291333525383126	823	2028-03-01	MasterCard	Debito	228
2	Valentina Jazmin Bautista Benjamin Valdez Cordoba	2737953842873774	401	2025-02-01	MasterCard	Debito	278
3	Dr(a). Ciro Franco	5057547079542361	574	2030-08-01	Maestro	Debito	42
4	Tiziana Suarez Lopez	6574550865376369	681	2028-09-01	Visa	Crédito	14
5	Juan Cruz Dominguez	3915158965925887	355	2030-10-01	American Express	Crédito	68
6	Francesco Lorenzo Garcia	5540593605175551	749	2025-02-01	MasterCard	Debito	237
7	Dr(a). Francesca Romero	7487443715885543	915	2024-11-01	Maestro	Crédito	225
8	Nahiara Jazmin Julian Rodriguez Lopez	4909939749131243	374	2030-03-01	MasterCard	Crédito	81
9	Dr(a). Benjamin Gomez	1473215932728109	718	2026-01-01	Visa	Crédito	179
10	Sr(a). Thiago Daniel Rodriguez	2105747982499881	954	2027-06-01	American Express	Debito	92
11	Ezequiel Lopez Fernandez	9448792072145831	175	2025-03-01	American Express	Crédito	281
12	Agustina Martina Chavez	0746532686971946	727	2024-04-01	Visa	Debito	252
13	Angel Gabriel Olivia Avila Vazquez	0682822424520754	665	2027-01-01	MasterCard	Debito	259
14	Benjamin Rojas Fernandez	0989122532070028	399	2024-06-01	MasterCard	Crédito	260
15	Pedro Castillo	9674244579152734	739	2029-02-01	MasterCard	Crédito	156
16	Valentina Castro Caceres	6504764599418577	680	2026-12-01	MasterCard	Crédito	150
17	Joaquin Ayala Rodriguez	0382037279950589	199	2024-05-01	American Express	Debito	67
18	Dr(a). Zoe Cabrera	8529172935433818	154	2030-06-01	MasterCard	Debito	56
19	Julia Torres Gomez	8893107359183319	175	2028-08-01	American Express	Debito	47
20	Benicio Maria Paz Velazquez	3231071024305079	427	2027-09-01	Visa	Crédito	85
21	Catalina Pereyra	6288275031814251	139	2029-12-01	Visa	Crédito	254
22	Maximo Alma Fernandez	5441215294068110	592	2024-08-01	Maestro	Crédito	187
23	Thiago Benjamin Garcia Gonzalez	4908866231580760	445	2028-12-01	American Express	Debito	116
24	Francesca Giuliana Cardozo Avila	8776235343396130	823	2026-08-01	Visa	Debito	167
25	Antonio Quiroga Garcia	1828794253252167	343	2026-07-01	American Express	Debito	7
26	Lucía Vazquez Ojeda	1412474821783355	006	2029-08-01	Visa	Crédito	150
27	Dr(a). Victoria Escobar	6388223966797382	281	2025-01-01	Visa	Debito	192
28	Dr(a). Bautista Rojas	2363960357772297	282	2029-01-01	Visa	Crédito	224
29	Ramiro Lautaro Nicolas Martinez Sanchez	4984284451184750	406	2024-06-01	American Express	Debito	60
30	Uma Vazquez Fernandez	7759283222807093	048	2030-11-01	Maestro	Crédito	120
31	Simon Luciana Vega Lopez	8355218076107257	565	2024-03-01	Visa	Debito	247
32	Martina Sanchez Gonzalez	9427212317728878	672	2024-03-01	MasterCard	Crédito	112
33	Thiago Leonel Medina	3310521486832578	259	2025-07-01	MasterCard	Crédito	176
34	Facundo Suarez	9007173274583116	394	2029-06-01	Visa	Debito	229
35	Paloma Augusto Cruz	3885163544154504	336	2028-11-01	Maestro	Debito	206
36	Milagros Maria Luz Molina	9067994610478798	564	2029-10-01	American Express	Debito	242
37	Victoria Thiago Nicolas Diaz	4546828541766452	789	2027-05-01	Visa	Crédito	144
38	Federico Flores	1857222293380854	678	2026-03-01	Maestro	Debito	235
39	Isabella Franco Paz Caceres	1848152315791416	018	2024-05-01	American Express	Crédito	255
40	Pedro Suarez Cabrera	3919414353623473	663	2029-02-01	Maestro	Crédito	226
41	Sr(a). Maia Sosa	0767954102191749	544	2025-03-01	American Express	Crédito	246
42	Juan Cruz Juana Ramos	4377011686912385	473	2027-10-01	Maestro	Debito	128
43	Constantino Santino Benjamin Ruiz	7027891928499693	143	2030-02-01	Visa	Debito	74
44	Pedro Nahiara Jazmin Lucero	4738528955155924	247	2024-06-01	American Express	Crédito	274
45	Valentino Soto Fernandez	5920600751606999	843	2028-02-01	MasterCard	Debito	239
46	Benjamin Gonzalez	1421204517583873	629	2030-03-01	Maestro	Crédito	51
47	Thiago Leonel Agustin Franco	1199638028545130	942	2029-05-01	Maestro	Debito	216
48	Isabella Mansilla	2086486318843648	122	2028-12-01	Maestro	Crédito	131
49	Guillermina Martinez Molina	8771315835409005	814	2030-09-01	American Express	Crédito	64
50	Agustin Juan Martin Torres	4912040396213440	370	2028-05-01	Maestro	Crédito	187
51	Juan Martin Aguero Villalba	9237120816750669	762	2029-12-01	Maestro	Debito	82
52	Santino Ezequiel Dominguez Garcia	1880797516102021	017	2024-07-01	Maestro	Crédito	107
53	Luisina Romero	8194855054616132	846	2025-04-01	MasterCard	Debito	234
54	Juan Pablo Guadalupe Chavez	5958307934773280	056	2030-06-01	Maestro	Debito	48
55	Lola Perez	0370809973660608	281	2029-01-01	American Express	Crédito	117
56	Dr(a). Tiziano Gonzalez	7055983754811024	070	2029-11-01	Visa	Crédito	56
57	Simon Martinez	1011231531127447	113	2029-02-01	Maestro	Crédito	249
58	Juan Manuel Sosa Martinez	4778489934079159	966	2025-12-01	American Express	Debito	132
59	Agustin Mateo Joaquin Fernandez Rodriguez	3062360610296109	376	2024-04-01	American Express	Debito	187
60	Manuel Aguirre	4336834932246163	811	2025-02-01	MasterCard	Crédito	265
61	Sr(a). Salvador Velazquez	4438861597218177	466	2029-04-01	American Express	Crédito	207
62	Juan Manuel Benitez	2178648392378199	123	2023-12-01	American Express	Crédito	198
63	Mateo Valentin Ian Benjamin Rodriguez	9677889189760728	511	2026-01-01	Maestro	Crédito	115
64	Maria Victoria Fernandez Rios	2013978649320536	897	2030-04-01	MasterCard	Crédito	17
65	Isabella Villalba Martinez	4147522648943932	513	2029-12-01	Visa	Crédito	166
66	Mia Isabella Lucero	8574587795583345	119	2028-01-01	American Express	Crédito	167
67	Sebastian Martinez	8093256593101129	294	2028-04-01	Maestro	Crédito	96
68	Juan Gabriel Pilar Gonzalez	3700740486403109	795	2024-12-01	American Express	Debito	122
69	Fausto Fernandez	0545046840708158	565	2029-05-01	Visa	Crédito	12
70	Mia Cruz	0260961581621965	337	2024-09-01	MasterCard	Debito	21
71	Benjamin Emilia Ortiz	9275268629815802	490	2024-04-01	Maestro	Debito	143
72	Mia Valentina Santino Rodriguez	9187138226428563	836	2028-07-01	Visa	Crédito	64
73	Tomàs Thiago Valentin Barrios	1514684281916503	023	2027-08-01	Visa	Crédito	191
74	Facundo Camila Vargas	5843330589512413	332	2028-07-01	American Express	Crédito	124
75	Julian Molina	2032857112494865	998	2028-09-01	MasterCard	Crédito	228
76	Martina Gino Gonzalez	6014316661369210	597	2026-08-01	MasterCard	Crédito	159
77	Helena Francisco Paez Hernandez	3991200377472661	922	2027-10-01	MasterCard	Debito	82
78	Juan Cruz Maria Victoria Mansilla	7862105744789945	667	2027-03-01	Maestro	Crédito	48
79	Dr(a). Luca Godoy	0303794296192121	922	2029-11-01	American Express	Debito	177
80	Abigail Julieta Sanchez Ledesma	5664621588699128	511	2027-11-01	MasterCard	Crédito	90
81	Juan Ignacio Santiago Correa	0330923196880903	409	2024-02-01	Visa	Crédito	26
82	Joaquin Rosario Rodriguez	2755586196365317	203	2027-12-01	American Express	Debito	197
83	Maria Belen Gonzalez	2342726918145229	948	2027-11-01	Maestro	Crédito	108
84	Sara Tomas Gonzalez	9260709288906423	276	2024-07-01	Visa	Debito	268
85	Paulina Gimenez	4392088392072239	332	2025-07-01	American Express	Debito	179
86	Benjamin Isabella Martinez Miranda	5320484506382446	066	2026-01-01	MasterCard	Debito	177
87	Lautaro Fernandez	0052846815148742	898	2027-12-01	MasterCard	Crédito	199
88	Catalina Garcia	3366264712495371	684	2027-05-01	Visa	Debito	29
89	Uma Farias	2544422674282445	343	2026-07-01	American Express	Crédito	73
90	Martina Sosa	6507371697330698	635	2027-08-01	American Express	Crédito	126
91	Benjamin Luisana Perez Paz	0883869549239467	765	2030-08-01	MasterCard	Debito	229
92	Dr(a). Valentina Medina	3740223249599675	424	2030-10-01	Maestro	Debito	261
93	Mateo Muñoz	5680935727070430	154	2026-01-01	MasterCard	Crédito	257
94	Zoe Valentina Lisandro Martinez	8059165240179376	483	2026-09-01	American Express	Debito	132
95	Zoe Jazmin Joaquin Toledo Gomez	2850001693901110	235	2025-09-01	MasterCard	Debito	89
96	Geronimo Paz	8961623233293221	220	2030-01-01	American Express	Debito	164
97	Constanza Amparo Leiva	7237962107029874	446	2029-08-01	MasterCard	Crédito	159
98	Joaquin Juan Ignacio Quiroga	7985488373922170	723	2027-01-01	Maestro	Crédito	44
99	Sr(a). Tiziano Suarez	4783558920798312	653	2025-03-01	American Express	Debito	260
100	Sr(a). Nicolas Rodriguez	2347651654086031	936	2027-10-01	American Express	Crédito	90
101	Emma Catalina Gutierrez Correa	2328818442475387	397	2029-10-01	Maestro	Crédito	28
102	Mia Manuel Sanchez Castillo	7514596298141036	673	2026-02-01	MasterCard	Debito	134
103	Giovanni Aguirre Ponce	9629700579756850	668	2029-07-01	MasterCard	Crédito	151
104	Dr(a). Mateo Valentin Gonzalez	5501879521964549	170	2025-08-01	Maestro	Crédito	131
105	Agustin Rodriguez Aguirre	3761497588262930	821	2030-06-01	Visa	Debito	21
106	Dr(a). Jeremias Gomez	0286555047653425	479	2029-07-01	MasterCard	Crédito	236
107	Sr(a). Juan Gabriel Benitez	8779389837573280	997	2027-08-01	American Express	Debito	256
108	Renata Blanco	9159708491675294	298	2025-09-01	Visa	Crédito	190
109	Sofia Juan Ignacio Gutierrez Ramirez	7144671865322537	534	2026-04-01	American Express	Crédito	55
110	Milo Diaz	9223119511946401	275	2028-05-01	American Express	Crédito	93
111	Pedro Gomez Ojeda	2908787840521808	246	2026-04-01	Maestro	Debito	196
112	Sr(a). Catalina Lucero	2444288875517236	012	2026-01-01	MasterCard	Debito	15
113	Mateo Ezequiel Paz	4039185909882710	511	2028-10-01	Maestro	Debito	74
114	Lola Paloma Alvarez Ruiz	3352532324470808	426	2026-12-01	Visa	Debito	67
115	Bautista Lucas Sanchez	7300306824873473	938	2025-07-01	MasterCard	Debito	291
116	Sr(a). Paulina Pereyra	4762317500561091	109	2026-03-01	MasterCard	Crédito	46
117	Ignacio Gimenez Fernandez	8325121849692568	527	2025-06-01	American Express	Crédito	256
118	Maria Emilia Juan Martin Vega	7387211302789119	439	2030-09-01	Maestro	Crédito	285
119	Nicolas Ambar Medina	0710157446256398	215	2025-07-01	Maestro	Debito	25
120	Agostina Rivero Vazquez	4703357204566776	591	2027-07-01	American Express	Crédito	225
121	Thiago Nicolas Emma Perez Cordoba	2901626857707194	649	2028-10-01	MasterCard	Debito	239
122	Dr(a). Valentina Flores	2104926363921868	208	2029-06-01	American Express	Debito	257
123	Tomàs Mendez Cardozo	0767626700211404	272	2027-04-01	MasterCard	Debito	280
124	Sebastian Acosta	1714981848856071	177	2026-06-01	American Express	Debito	81
125	Benjamin Alejandro Gonzalo Godoy	8660052544000702	468	2024-07-01	MasterCard	Debito	293
126	Sr(a). Renata Ramirez	7797423316307681	530	2027-01-01	Visa	Debito	141
127	Santino Vicente Figueroa Gonzalez	4863226166456423	067	2030-07-01	Visa	Debito	197
128	Lorenzo Fernandez	0374865042761893	503	2026-06-01	American Express	Crédito	32
129	Joaquin Camila Martinez	8663752998852009	673	2028-03-01	American Express	Debito	125
130	Bianca Benjamin Ramirez Caceres	8872393733146201	541	2025-01-01	MasterCard	Crédito	297
131	Valentino Ema Lopez	0205520519978296	190	2028-10-01	MasterCard	Debito	293
132	Joaquina Maite Duarte Luna	5945467885112729	822	2026-11-01	MasterCard	Crédito	24
133	Alma Flores	6093464745123712	194	2024-06-01	Maestro	Crédito	114
134	Felicitas Fernandez	7173646592999427	136	2027-02-01	Visa	Crédito	286
135	Mora Bautista Dominguez	8936638037432962	413	2025-10-01	MasterCard	Debito	49
136	Maria Emilia Silva Correa	2750038206951559	382	2030-01-01	Maestro	Debito	141
137	Mateo Joaquin Sosa	4233966078828839	899	2028-10-01	Maestro	Crédito	210
138	Ramiro Thiago Nahuel Torres Gutierrez	5057781108728037	209	2030-06-01	Visa	Debito	79
139	Gabriel Delfina Ramos Diaz	8182090758141677	228	2026-06-01	Visa	Crédito	14
140	Francisco Julieta Velazquez	1860264433018414	656	2029-10-01	MasterCard	Debito	122
141	Lautaro Nicolas Morales Valdez	4550227694165684	805	2028-11-01	Visa	Debito	252
142	Mateo Vargas Garcia	8152827743653208	441	2025-01-01	MasterCard	Debito	150
143	Thiago Nicolas Juan Ignacio Sosa Garcia	3569664411829968	647	2028-01-01	American Express	Crédito	202
144	Felipe Fernandez Gonzalez	2701789676783035	325	2028-03-01	American Express	Debito	122
145	Dr(a). Tomàs Lopez	8649195580709511	654	2030-09-01	Visa	Crédito	34
146	Paulina Victoria Ramirez	6576439267600570	476	2027-03-01	American Express	Crédito	114
147	Martina Catalina Ayala Arias	3802849012048527	097	2026-02-01	Maestro	Debito	91
148	Isabella Matilda Mansilla Gonzalez	8246700324502707	102	2030-01-01	American Express	Debito	257
149	Ana Paula Isabella Peralta Maldonado	6794249605501660	842	2027-11-01	MasterCard	Debito	160
150	Sr(a). Morena Cordoba	7411063001338674	545	2024-01-01	Maestro	Debito	287
151	Luz Maria Muñoz	3640610505554200	144	2027-07-01	Visa	Crédito	255
152	Paloma Pereyra Hernandez	0648443132546506	778	2026-01-01	American Express	Debito	225
153	Guadalupe Rodriguez Fernandez	9799015887048064	116	2025-05-01	American Express	Debito	101
154	Giuliana Manuel Toledo	1485317824680006	189	2030-06-01	Maestro	Crédito	184
155	Sr(a). Juan Cruz Benitez	4648819008045401	490	2029-08-01	MasterCard	Crédito	216
156	Santino Martinez Roldan	7782449529795120	770	2028-07-01	American Express	Crédito	111
157	Felipe Perez	2556452676519103	536	2026-08-01	Maestro	Debito	206
158	Ana Paula Perez	9320387538915842	612	2030-03-01	American Express	Debito	55
159	Clara Escobar	1891052332844758	255	2028-12-01	Maestro	Debito	45
160	Juan Ignacio Faustino Fernandez	2930843747174174	040	2027-04-01	MasterCard	Crédito	203
161	Sr(a). Luisana Villalba	9622762105061479	845	2024-01-01	MasterCard	Debito	93
162	Mateo Castro Molina	7018398657010909	391	2024-06-01	Maestro	Debito	172
163	Lucía Juan Martin Ruiz Martinez	3053196675344944	371	2024-06-01	Visa	Debito	47
164	Olivia Maldonado	3759136443762192	798	2026-10-01	MasterCard	Crédito	179
165	Tiziano Lopez Juarez	2626284531992342	115	2029-02-01	Maestro	Debito	100
166	Paula Agustina Herrera Martinez	4612434764864613	790	2029-04-01	Maestro	Crédito	61
167	Juan Gabriel Ferreyra Carrizo	5024594880192485	569	2030-03-01	MasterCard	Crédito	60
168	Agustín Tomas Benjamin Rodriguez	5558391126421002	873	2027-07-01	Maestro	Crédito	265
169	Ciro Bravo Juarez	7788888584371587	839	2025-03-01	Maestro	Debito	239
170	Sofia Victoria Sosa Gutierrez	9555065467290733	817	2027-05-01	Visa	Crédito	294
171	Bautista Benjamin Sanchez Fernandez	0450553528208566	686	2026-11-01	Maestro	Crédito	138
172	Maria Paz Malena Correa Herrera	0218926359197128	303	2026-10-01	MasterCard	Debito	102
173	Sr(a). Genaro Garcia	6594037992037031	982	2025-10-01	American Express	Debito	162
174	Dr(a). Emilia Paez	0239826123175911	643	2024-02-01	MasterCard	Crédito	299
175	Ignacio Suarez	3562134215720777	374	2026-09-01	Visa	Debito	60
176	Victoria Delfina Gonzalez	0636559285174827	766	2026-07-01	Maestro	Crédito	44
177	Morena Dominguez Gonzalez	5035539101893668	965	2029-04-01	MasterCard	Debito	116
178	Federico Pilar Correa	0239228506431957	285	2026-04-01	American Express	Crédito	289
179	Renata Ivan Paz	0840706352690740	970	2025-09-01	MasterCard	Crédito	175
180	Gonzalo Agustín Garcia Fernandez	6886736079036476	365	2028-08-01	Maestro	Debito	287
181	Dr(a). Catalina Aguirre	9849081458071769	822	2025-10-01	Maestro	Crédito	90
182	Felipe Rodriguez	6359295551769964	511	2030-06-01	Maestro	Crédito	8
183	Thiago Valentin Peralta Diaz	4886580216320319	470	2027-10-01	Visa	Crédito	213
184	Bautista Salvador Gonzalez Diaz	8852996295944444	331	2030-03-01	American Express	Crédito	249
185	Benjamin Milena Rojas Alvarez	9279658095850433	106	2026-06-01	MasterCard	Crédito	11
186	Agustin Facundo Ojeda Cordoba	0029052863695424	579	2029-02-01	Maestro	Crédito	1
187	Dr(a). Francisca Villalba	8855943268250503	344	2027-03-01	MasterCard	Crédito	278
188	Agustin Diaz	5445557313242309	692	2028-12-01	Visa	Debito	131
189	Guillermina Sebastian Fernandez Olivera	1973597963391007	341	2026-12-01	Visa	Crédito	9
190	Ludmila Thiago Benjamin Luna Torres	0025653183057894	599	2025-05-01	Visa	Crédito	163
191	Luca Gonzalez Lopez	4876215158560797	251	2028-11-01	Visa	Debito	145
192	Dr(a). Bianca Nuñez	5137053696980685	173	2026-04-01	MasterCard	Debito	188
193	Dr(a). Juan Pablo Farias	7558567714405526	839	2030-10-01	Maestro	Crédito	255
194	Lucas Rojas Sanchez	8580408734576061	713	2028-01-01	Visa	Debito	166
195	Clara Cardozo Coronel	1321132886712577	640	2024-04-01	MasterCard	Crédito	249
196	Jeremias Thiago Valentin Alvarez Fernandez	4534196607902234	966	2025-01-01	American Express	Debito	110
197	Sr(a). Oriana Ruiz	9949158327901216	909	2029-03-01	American Express	Crédito	279
198	Sr(a). Lucia Peralta	5758258240533286	654	2029-03-01	Maestro	Debito	33
199	Juan Ignacio Sofía Acosta	5781918831617121	021	2025-09-01	Maestro	Crédito	289
200	Lautaro Agustín Villalba	4451904743845125	818	2025-04-01	MasterCard	Crédito	227
201	Thiago Vera	6409766023510318	117	2027-05-01	MasterCard	Crédito	228
202	Simon Tomàs Vargas Mansilla	7716188374772133	427	2024-08-01	American Express	Crédito	9
203	Bruno Mateo Muñoz Sanchez	3013973470489371	490	2029-08-01	MasterCard	Crédito	49
204	Dr(a). Olivia Figueroa	8117179603682264	146	2027-05-01	Visa	Debito	220
205	Maximo Tiziano Benjamin Gomez Flores	7582183762710716	958	2030-07-01	Visa	Crédito	200
206	Olivia Catalina Luna Romero	4809959233286998	390	2030-03-01	Maestro	Crédito	38
207	Sr(a). Benjamin Blanco	7759808470046834	400	2027-11-01	Visa	Debito	265
208	Josefina Torres Acosta	5494628531800096	448	2028-07-01	Visa	Crédito	87
209	Benjamin Perez	0689242122632273	118	2026-01-01	American Express	Crédito	286
210	Lorenzo Francisca Herrera	3010253682038709	486	2027-10-01	American Express	Crédito	283
211	Morena Duarte Mendoza	6963474383477490	352	2025-09-01	MasterCard	Crédito	265
212	Juan Pablo Maria Victoria Gomez	1501019340725502	950	2030-09-01	MasterCard	Debito	197
213	Zoe Valentina Rodriguez Romero	0032745259765348	858	2028-01-01	MasterCard	Debito	221
214	Bautista Ruiz Ledesma	9324498261657699	933	2026-12-01	Visa	Debito	147
215	Zoe Valentina Valentina Cardozo	6000427137679508	632	2028-05-01	American Express	Crédito	1
216	Olivia Valentino Sanchez	1868699724189040	790	2024-10-01	Maestro	Crédito	136
217	Luz Milagros Bautista Diaz Ramirez	5885283879494372	831	2028-04-01	Maestro	Debito	104
218	Catalina Ambar Sanchez Sanchez	6324106381040368	362	2026-01-01	Maestro	Debito	251
219	Benjamin Ezequiel Thiago Emanuel Morales	2351251078310372	491	2027-06-01	Visa	Crédito	182
220	Victoria Gonzalez Mansilla	1326877413341324	474	2027-10-01	MasterCard	Debito	253
221	Ambar Isabella Diaz Acosta	5196702151300972	567	2028-12-01	American Express	Debito	184
222	Dr(a). Antonella Muñoz	4473067944123379	489	2028-02-01	Visa	Crédito	77
223	Emma Flores Fernandez	3814834995855344	230	2029-05-01	MasterCard	Crédito	211
224	Violeta Sanchez	6220286977634415	544	2024-03-01	Visa	Debito	84
225	Tiziana Thiago Lopez	6239714092288861	627	2027-10-01	MasterCard	Debito	41
226	Isabel Luz Maria Cabrera Soria	2435893163300181	252	2026-03-01	American Express	Crédito	68
227	Maximo Benjamin Duarte	0215733105510779	078	2029-05-01	Visa	Debito	22
228	Augusto Gonzalez Ramos	2848508127909773	684	2028-08-01	Visa	Crédito	117
229	Alejo Guillermina Lopez Barrios	2433430185210448	631	2027-02-01	MasterCard	Crédito	148
230	Thiago Nahuel Soto Paez	7197319791203897	896	2024-10-01	Visa	Crédito	79
231	Sr(a). Sofia Alvarez	7878969032619321	512	2030-07-01	MasterCard	Crédito	104
232	Bautista Garcia	2946887063679061	531	2024-12-01	Visa	Debito	99
233	Lola Mateo Ezequiel Lucero Perez	1226706226710259	919	2024-11-01	Maestro	Crédito	124
234	Isabella Thiago Benjamin Diaz	2329474978294348	157	2028-06-01	Maestro	Crédito	21
235	Augusto Figueroa Vega	6145791616019347	211	2029-06-01	MasterCard	Debito	90
236	Emma Gonzalez Ruiz	2370289294910232	614	2027-06-01	Maestro	Crédito	210
237	Pilar Rojas	9963738801425877	527	2028-02-01	Visa	Crédito	199
238	Augusto Gutierrez Acosta	7283356735842919	090	2024-02-01	American Express	Crédito	55
239	Paulina Renata Soria	0013969109123251	292	2025-11-01	Visa	Crédito	278
240	Amparo Gimenez Rios	6430515658213119	392	2027-04-01	Maestro	Crédito	144
241	Dr(a). Sofia Rodriguez	7245506338556887	430	2027-04-01	Maestro	Debito	187
242	Jazmin Bautista Gomez Sanchez	8660016846183344	576	2023-11-01	MasterCard	Debito	126
243	Mateo Benjamin Gonzalez Sosa	3455756852151328	052	2028-04-01	MasterCard	Debito	76
244	Santino Mendoza Gonzalez	0930883533315509	600	2029-01-01	Maestro	Debito	233
245	Lourdes Thiago Daniel Gutierrez Alvarez	0387842756308799	752	2028-11-01	Maestro	Debito	298
246	Catalina Castillo	4462204243443494	603	2028-10-01	MasterCard	Debito	264
247	Isabella Fernandez Suarez	0137082351741525	686	2028-12-01	Visa	Debito	75
248	Sr(a). Franco Hernandez	7097241916426466	257	2023-12-01	Visa	Debito	26
249	Lucas Ponce Perez	4391947411769138	807	2026-08-01	Visa	Crédito	232
250	Santiago Medina	3717351874331564	498	2024-03-01	American Express	Debito	26
251	Dr(a). Julieta Fernandez	7501007542909121	110	2028-05-01	American Express	Crédito	32
252	Sara Castillo Gomez	8370289614939232	678	2028-11-01	Maestro	Debito	226
253	Rafael Martinez Maidana	9627427986457809	552	2024-06-01	Maestro	Debito	90
254	Victoria Maria Belen Gomez Ledesma	5574134229736514	397	2024-08-01	American Express	Crédito	84
255	Lautaro Gonzalez Correa	3984930428220061	181	2026-03-01	Maestro	Debito	155
256	Benjamin Arias	4807425117711601	948	2030-03-01	American Express	Crédito	77
257	Facundo Benjamin Rodriguez Benitez	1660139421198816	780	2030-02-01	MasterCard	Crédito	26
258	Sr(a). Juan Cruz Ojeda	2832035499585534	702	2024-10-01	American Express	Debito	48
259	Dylan Benjamin Gimenez	1338816726101402	157	2028-12-01	Visa	Debito	194
260	Benjamin Fernandez Flores	8056989114925386	328	2026-02-01	Visa	Crédito	280
261	Victoria Valentin Martinez	7905285277110970	145	2030-03-01	Maestro	Crédito	191
262	Santiago Luna Romero	9402756809460179	991	2024-02-01	Visa	Crédito	126
263	Lorenzo Francesca Peralta	4326816936660677	707	2025-05-01	MasterCard	Crédito	294
264	Santino Benjamin Lucas Ezequiel Villalba Villalba	7685057987948974	486	2024-08-01	Maestro	Crédito	123
265	Martina Lautaro Lopez	2425431527209187	024	2028-08-01	American Express	Crédito	199
266	Sr(a). Delfina Ramirez	4269263071203449	654	2024-01-01	Visa	Debito	103
267	Sofia Agustina Torres	4316216328168380	110	2028-04-01	Visa	Crédito	115
268	Joaquina Fernandez Sanchez	4002766957867630	718	2025-10-01	American Express	Crédito	86
269	Francisco Paz	0927485432427590	785	2030-09-01	American Express	Crédito	69
270	Kiara Dante Gimenez Flores	5383859895906185	738	2029-05-01	Visa	Crédito	239
271	Sr(a). Juan Martin Campos	8906667889106983	210	2029-11-01	Visa	Crédito	235
272	Lautaro Nicolas Isabella Lucero	0587162430773762	053	2024-02-01	Visa	Crédito	123
273	Juana Coronel	6621798626392967	891	2025-08-01	Visa	Crédito	116
274	Lautaro Caceres	0202153178628140	353	2029-03-01	Maestro	Debito	287
275	Dr(a). Julieta Fernandez	6186748555546279	355	2027-05-01	Visa	Crédito	189
276	Jazmin Jazmin Diaz Cordoba	6351921379010482	638	2027-03-01	American Express	Crédito	186
277	Franco Peralta	1197246495504094	860	2026-06-01	Maestro	Crédito	51
278	Francisca Perez Bustos	8690929208501475	228	2029-07-01	Visa	Crédito	212
279	Santiago Matilda Moyano	3557126649487452	913	2028-06-01	Maestro	Debito	182
280	Juan Martin Gonzalez	2771668425351365	460	2026-01-01	Maestro	Crédito	110
281	Manuel Medina Gonzalez	1988674659874292	214	2027-09-01	American Express	Crédito	150
282	Joaquin Juan Martin Morales Sosa	4431438514280308	220	2026-08-01	American Express	Crédito	93
283	Dr(a). Delfina Ramirez	3307719491594337	109	2029-08-01	Maestro	Debito	120
284	Mateo Benjamin Fernandez	5257059854052524	222	2027-12-01	Visa	Crédito	15
285	Enzo Alfonsina Lopez	4784152953567891	988	2029-12-01	MasterCard	Debito	279
286	Santino Nicolas Mateo Ezequiel Bravo Garcia	1666193702220369	166	2024-10-01	Visa	Crédito	188
287	Genaro Correa Ponce	1512189928089084	886	2029-09-01	Maestro	Crédito	192
288	Sr(a). Santiago Guzman	2738506183717331	819	2025-09-01	Visa	Debito	22
289	Dr(a). Valentina Arias	3761877005333723	074	2027-05-01	MasterCard	Debito	100
290	Benjamin Gomez	3216762783195473	014	2025-06-01	Maestro	Crédito	96
291	Dr(a). Pedro Ortiz	3217221728870078	806	2024-03-01	American Express	Debito	75
292	Dr(a). Lara Vargas	4887761344041696	235	2030-10-01	Maestro	Crédito	261
293	Agustin Rojas Chavez	2441479133285563	343	2029-02-01	American Express	Crédito	273
294	Dr(a). Mateo Valentin Fernandez	3888193545246981	748	2030-01-01	Maestro	Crédito	185
295	Santino Cardozo Vera	3010052308967920	017	2024-03-01	American Express	Debito	135
296	Alma Mansilla Nuñez	8244243245864652	736	2030-10-01	Visa	Debito	290
297	Dylan Benjamin Octavio Sanchez Roldan	7658659923621118	406	2028-09-01	American Express	Debito	236
298	Felipe Mendoza Hernandez	8653112674329111	348	2029-06-01	Visa	Crédito	247
299	Violeta Franco Mansilla	1391566494179084	001	2028-10-01	American Express	Crédito	119
300	Lautaro Ezequiel Romero Flores	8160210005488669	719	2025-09-01	American Express	Crédito	92
\.


--
-- Data for Name: oferta; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.oferta (id_oferta, porcentaje, fecha_desde, fecha_hasta) FROM stdin;
1	19.00	2023-11-03	2024-01-17
2	65.00	2023-09-01	2023-12-20
3	57.00	2023-10-20	2023-11-16
4	60.00	2023-08-20	2024-01-20
5	59.00	2023-10-08	2023-11-13
6	65.00	2023-08-03	2023-11-11
7	19.00	2023-08-21	2023-11-26
8	72.00	2023-09-10	2023-11-20
9	31.00	2023-08-29	2023-12-04
10	16.00	2023-10-20	2023-12-28
11	73.00	2023-11-03	2024-01-07
12	58.00	2023-08-15	2024-01-29
13	40.00	2023-10-17	2024-01-17
14	68.00	2023-08-12	2023-12-13
15	24.00	2023-09-13	2023-11-12
16	54.00	2023-09-29	2024-01-14
17	17.00	2023-10-20	2023-11-12
18	40.00	2023-10-11	2023-12-17
19	8.00	2023-11-04	2024-01-11
20	41.00	2023-10-24	2024-01-07
\.


--
-- Data for Name: oferta_producto; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.oferta_producto (oferta, producto) FROM stdin;
7	249
17	154
8	165
20	78
19	299
14	38
4	24
19	92
15	297
19	46
10	111
13	225
14	5
13	67
3	9
10	271
16	134
18	294
6	294
15	265
9	118
5	103
10	88
2	291
12	104
9	92
15	253
2	10
18	288
7	231
19	207
4	43
19	173
18	188
4	9
5	134
6	267
5	186
18	75
5	227
2	228
13	232
13	199
4	168
16	52
14	4
7	146
12	173
18	264
16	248
11	71
19	28
12	5
10	56
16	217
8	79
10	269
3	79
8	50
18	135
4	218
20	97
11	14
18	261
11	200
14	168
4	99
10	145
1	288
4	291
17	75
8	200
16	22
14	71
19	153
16	120
10	215
16	216
15	127
2	84
5	197
8	155
20	102
10	136
8	16
2	12
7	150
16	209
8	146
16	292
11	230
16	230
13	240
4	198
14	206
15	53
14	108
16	13
18	16
17	240
19	178
20	110
15	35
18	257
12	146
6	213
14	247
14	130
10	168
20	168
12	73
4	280
15	198
15	125
10	64
7	209
4	208
2	120
12	47
16	133
6	43
7	136
11	165
17	269
4	30
11	9
15	86
15	12
4	209
10	24
14	48
15	289
12	209
1	228
4	54
19	294
9	63
19	38
11	85
11	255
19	234
14	174
18	265
16	9
14	121
13	190
7	252
16	213
1	282
10	31
16	260
3	290
5	232
13	27
3	255
6	27
7	276
18	21
3	166
1	212
18	183
15	48
7	52
6	228
16	211
3	124
2	45
19	148
1	118
10	95
16	45
13	183
19	62
9	220
15	134
11	199
17	296
1	137
5	284
14	204
13	260
16	26
17	95
12	150
5	126
19	212
14	182
12	66
2	122
2	187
11	74
2	250
16	299
7	296
4	199
9	6
14	170
1	17
2	125
14	201
5	180
16	199
17	172
12	131
10	232
3	112
7	227
13	35
14	283
18	164
3	243
4	69
14	30
5	239
20	99
16	161
18	238
14	189
5	290
9	47
19	206
12	136
12	296
20	53
5	299
15	16
16	69
18	151
18	212
11	101
19	292
1	32
2	64
17	211
17	33
19	50
5	62
5	271
17	277
12	135
20	210
20	257
6	97
12	300
14	158
20	83
13	62
3	239
15	225
16	140
6	55
14	207
15	188
2	264
18	134
13	5
3	139
8	20
2	268
13	25
20	205
19	193
11	206
14	83
10	221
4	254
5	205
10	162
8	163
20	143
7	78
9	162
12	56
14	93
17	141
14	135
4	182
12	168
17	200
4	26
10	196
19	110
1	46
3	137
5	130
10	5
11	269
13	209
1	194
17	2
9	157
8	197
5	52
3	170
6	103
18	169
2	184
2	243
7	216
3	266
\.


--
-- Data for Name: particular; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.particular (usuario, dni, fecha_nacimiento, nombre, apellido) FROM stdin;
199	00809255	1950-08-13	Juan Pablo	Chavez
206	55694387	1954-01-21	Thiago Leonel	Romero
198	68743354	1950-02-27	Octavio	Lopez
173	75069100	2021-09-10	Agustina	Lucero
228	71971591	1967-12-13	Isabella	Villalba
99	09500988	1962-03-09	Lucía	Gomez
2	36609196	1953-07-20	Santino Benjamin	Perez
63	00193790	1944-05-09	Felicitas	Ojeda
128	40642710	1961-05-21	Luna	Villalba
29	39940456	1962-06-10	Victoria	Rojas
256	63511270	1981-02-01	Jeremias	Roldan
110	91025266	1981-04-20	Maximo	Torres
145	29887111	1965-09-15	Salvador	Flores
232	93541871	1980-05-14	Francesco	Gutierrez
123	66314079	1996-04-25	Catalina	Valdez
252	60532423	1969-03-16	Joaquin	Mansilla
88	66444618	1949-10-17	Santiago	Soto
230	75568732	1951-11-23	Valentina	Rivero
127	19881009	2017-04-01	Santino	Castillo
77	87505663	2016-02-04	Sofia	Acosta
171	41244237	2004-11-10	Felipe	Gomez
274	91831172	1978-04-15	Valentino	Blanco
57	70596200	1969-04-27	Isabella	Quiroga
144	59285191	1955-11-28	Lautaro Ezequiel	Molina
187	94744065	1984-09-29	Zoe	Sanchez
269	29958855	1959-06-18	Thiago Daniel	Muñoz
39	53657479	2020-09-22	Maria Paz	Herrera
227	99816107	1955-07-16	Juan Ignacio	Fernandez
237	69580787	1996-12-08	Bautista	Ramirez
224	05790998	1944-09-10	Antonella	Gonzalez
298	52502583	1990-06-09	Julia	Ortiz
273	44286707	2007-08-31	Thiago Benjamin	Garcia
121	72436372	1990-08-30	Simon	Herrera
177	85091355	2010-07-18	Pedro	Moreno
194	78062928	1977-01-04	Maria Belen	Benitez
104	81144059	1985-08-14	Thiago Benjamin	Gomez
73	65120003	2009-11-27	Lara	Gonzalez
181	72562221	1982-06-28	Lorenzo	Valdez
129	52271198	1992-10-04	Thiago Ezequiel	Ruiz
292	82590394	1999-05-28	Juana	Peralta
67	24708562	1968-01-15	Valentin	Benitez
200	72561135	2015-05-06	Ciro	Avila
28	64683567	1960-04-25	Benicio	Flores
299	40211293	1944-08-07	Faustino	Fernandez
82	23140386	1996-06-05	Santino	Coronel
260	85573742	1960-02-26	Luciana	Lopez
103	39249698	2008-07-23	Tomàs	Martinez
215	44182856	2006-10-19	Alexander	Figueroa
101	66022852	1950-03-10	Tomas	Miranda
278	21508291	2019-12-01	Juana	Medina
220	52038687	2004-05-26	Morena	Diaz
163	36600504	1991-03-19	Julia	Rojas
81	76124207	1974-03-11	Paula	Rios
113	64704693	1966-06-16	Juan Pablo	Fernandez
266	52847123	1987-03-15	Jazmin	Perez
251	45541270	2005-02-19	Nahuel	Garcia
60	16246457	1948-04-01	Emma	Aguero
189	59961148	2004-11-24	Julian	Romero
216	13377835	1964-08-02	Ezequiel	Gonzalez
223	01596099	2006-08-14	Mateo Benjamin	Ramirez
114	06130138	1971-07-06	Valentina	Maldonado
11	00624065	2010-11-29	León	Fernandez
176	52248214	2010-02-27	Valentino	Caceres
168	82836433	2018-03-10	Benjamin	Rodriguez
34	47440183	1945-03-31	Lucio	Silva
52	46166258	1983-01-20	Santiago	Chavez
201	41132997	1980-10-02	Santino	Sosa
65	50910645	1963-06-08	Emilia	Peralta
165	11788613	1969-04-01	Simon	Farias
131	37641034	1989-03-12	Ivan	Pereyra
159	16817523	1978-02-28	Juan Ignacio	Martin
225	69702961	1973-02-27	Ignacio	Ramos
86	10664772	2000-11-04	Agustin	Gonzalez
90	24566088	1949-02-15	Valentin	Nuñez
111	28278816	1955-05-14	Amparo	Sosa
3	10988873	1960-11-21	Valentino	Ortiz
119	94467371	2008-05-22	Mateo	Vega
244	41785948	1948-02-04	Joaquin	Gomez
12	49187983	1966-12-29	Sofia	Pereyra
71	26389559	1980-10-20	Augusto	Ruiz
1	65597707	2022-10-15	Francisco	Ponce
27	69930701	1959-01-20	Luciano	Herrera
5	36843313	2018-11-18	Benjamin	Velazquez
41	71893152	1997-12-10	Emilia	Godoy
89	30122835	1945-07-08	Tiziano Valentin	Dominguez
257	99919479	1978-09-19	Jeremias	Moreno
35	88793386	1961-12-25	Tomas Benjamin	Peralta
226	92658196	1981-11-11	Francisco	Lopez
36	26425842	1956-03-06	Federico	Suarez
270	56357007	1956-09-07	Maria Paz	Rodriguez
124	91467482	1991-08-03	Jazmin	Silva
68	07446259	1952-03-11	Guadalupe	Gutierrez
155	63428020	1994-03-18	Ian	Sosa
137	85185382	1949-05-04	Mateo	Mansilla
50	92850514	1981-11-03	Mateo	Rojas
272	31946019	1971-12-26	Valentina Jazmin	Diaz
46	48242389	1985-02-03	Santino	Figueroa
250	92073735	1980-09-24	Thiago Agustin	Soto
204	06002841	1996-04-20	Lola	Ramirez
102	73314111	1959-05-10	Jazmin	Maldonado
296	41894676	1982-08-18	Sofia	Soria
49	27658178	1944-11-29	Thiago Agustin	Gutierrez
297	79348580	1977-10-30	Constantino	Sanchez
64	05018700	2017-11-25	Benjamin	Ponce
262	56464362	1955-02-24	Juan Gabriel	Diaz
42	22702946	2019-10-10	Jeremias	Gomez
100	11567055	2008-12-06	Ambar	Benitez
218	34772913	2008-01-09	Juan Ignacio	Rodriguez
281	79930305	1999-04-28	Giovanni	Dominguez
197	07651921	1957-06-24	Vicente	Diaz
156	44361752	1990-06-24	Catalina	Lopez
209	68609228	2012-04-04	Maia	Ramirez
158	15720231	2000-04-11	Benjamin	Caceres
236	04177138	2014-08-23	Nicolas	Morales
58	82079124	2015-07-06	Mora	Alvarez
118	10521423	2003-07-08	Samuel	Paez
235	10830738	2015-12-06	Isabella	Gonzalez
255	70622473	1986-06-07	Ciro	Castillo
83	15887888	1994-08-06	Martina	Velazquez
107	87837534	1961-11-20	Pilar	Ruiz
229	38499065	1983-06-21	Pedro	Peralta
8	13849423	1957-12-03	Giovanni	Sosa
59	84598082	1979-03-14	Lorenzo	Bustos
122	37682773	1964-07-07	Tiziana	Sanchez
157	71960744	1978-02-07	Catalina	Ferreyra
17	69225944	1976-11-25	Matilda	Ruiz
169	39827580	1944-03-11	Francesca	Godoy
294	84111792	1948-06-04	Isabella	Perez
212	31459319	1971-02-12	Valentina	Ramos
18	62680806	1958-04-18	Luz Maria	Martin
276	80175680	2018-10-08	Valentino	Ponce
285	01807975	1978-09-03	Isabel	Romero
172	17555340	1953-11-07	Felipe	Gonzalez
167	96159842	2023-07-13	Santiago	Hernandez
280	10324659	1966-07-19	Lautaro Benjamin	Acosta
148	17368803	1946-06-18	Valentina	Ledesma
284	89732653	1956-08-02	Santiago	Martin
268	20751504	1976-06-15	Bautista	Gonzalez
37	65210919	2000-11-15	Milagros	Flores
196	08596391	2019-12-30	Bruno	Ojeda
109	85016717	1965-08-28	Francisco	Martinez
40	27100862	2010-12-06	Juan Bautista	Villalba
221	70686497	1949-05-21	Thiago	Carrizo
51	54032345	2009-04-17	Julian	Morales
291	55590111	2016-02-01	Giuliana	Perez
231	27532720	2018-01-01	Santino	Soria
178	65518774	1974-08-17	Bianca	Fernandez
253	42515754	1978-01-19	Morena	Farias
286	65847408	2009-03-23	Luisina	Acosta
112	23197318	1985-06-22	Mateo Benjamin	Pereyra
78	68938425	1985-12-13	Renzo	Rodriguez
162	98448406	1975-09-13	Joaquin	Coronel
175	76386966	1974-12-14	Valentina 	Gomez
247	45163953	1965-10-05	Bautista	Lucero
202	93727754	2010-06-20	Santino Benjamin	Rodriguez
70	07365127	1999-12-11	Amparo	Moreno
300	95605951	1958-10-17	Luciano Benjamin	Rodriguez
282	90221462	1995-08-31	Isabella	Martin
130	35525148	2020-05-22	Felipe	Rodriguez
151	41074492	1987-07-31	Thiago Leonel	Coronel
31	88712795	1974-05-05	Luz Milagros	Gomez
24	62061196	2010-07-13	Luciano	Vega
14	31140283	1944-07-06	Máximo	Molina
106	56392929	1965-08-26	Mora	Fernandez
133	63942610	2006-09-25	Francesca	Herrera
45	19194919	1976-06-12	Morena	Romero
277	33340256	1957-03-14	Malena	Fernandez
152	16878107	2022-05-24	Julieta	Vera
203	13649915	1945-05-07	Guadalupe	Miranda
195	77039367	1948-09-15	Thiago Valentin	Acuña
233	45374313	1976-02-09	Benjamin Ezequiel	Alvarez
290	00274404	1989-11-12	Francisco	Peralta
44	78833552	1948-06-09	Maximiliano	Morales
140	97156659	1976-10-17	Fausto	Escobar
87	22452188	2011-04-16	Alejo	Gonzalez
76	50639253	1961-10-18	Thiago Emanuel	Farias
4	05811241	1948-04-11	Juan Cruz	Cabrera
182	61891389	1977-03-01	Alfonsina	Franco
166	69190143	1989-03-19	Joaquin	Ortiz
97	07166473	2023-09-09	Thiago	Gonzalez
94	77124763	2017-12-15	Emilia	Juarez
108	52187337	1962-12-01	Ian Benjamin	Suarez
161	00798248	1950-04-01	Felipe	Correa
217	94245274	1958-08-04	Benjamin	Lopez
295	14245909	1975-10-11	Thiago Valentin	Gonzalez
190	07508988	2002-12-20	Juan Francisco	Martinez
248	30314561	1947-10-16	Guillermina	Sosa
10	97425028	2022-03-17	Bautista Benjamin	Alvarez
193	55933993	1978-03-31	Olivia	Olivera
91	81185204	1984-06-30	Dylan	Cabrera
149	10949258	1965-10-07	Mora	Ruiz
259	78434734	1991-11-16	Rosario	Gomez
74	39511496	1983-09-29	Guadalupe	Rodriguez
143	65892940	2019-04-10	Lautaro Nahuel	Diaz
23	56799816	1998-09-08	Pilar	Romero
53	34824176	1955-09-30	Lautaro	Ruiz
96	95306200	1956-04-15	Maria Emilia	Ledesma
191	18878739	1944-05-11	Thiago Daniel	Gonzalez
138	58109458	2000-03-24	Paulina	Sosa
153	27653843	1951-11-08	Mateo	Vargas
\.


--
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.pedido (numero_de_pedido, fecha_pedido, metodo_pago, particular, resenia) FROM stdin;
1	2023-10-28	65	166	1
2	2023-08-20	159	45	2
3	2023-10-28	188	131	3
4	2023-10-22	147	91	4
5	2023-09-16	188	131	5
6	2023-09-23	244	233	6
7	2023-08-23	278	212	7
8	2023-09-24	73	191	8
9	2023-08-28	289	100	9
10	2023-09-11	173	162	10
11	2023-08-15	190	163	11
12	2023-10-02	297	236	12
13	2023-08-01	145	34	13
14	2023-09-23	95	89	14
15	2023-09-08	6	237	15
16	2023-08-21	132	24	16
17	2023-09-18	191	145	17
18	2023-08-23	40	226	18
19	2023-09-12	65	166	19
20	2023-10-14	203	49	20
21	2023-08-13	108	190	21
22	2023-09-14	86	177	22
23	2023-09-21	32	112	23
24	2023-08-12	152	225	24
25	2023-10-30	42	128	25
26	2023-10-27	46	51	26
27	2023-11-01	89	73	27
28	2023-10-06	66	167	28
29	2023-10-07	190	163	29
30	2023-09-07	118	285	30
31	2023-09-10	101	28	31
32	2023-10-05	290	96	32
33	2023-08-17	32	112	33
34	2023-10-17	162	172	34
35	2023-09-26	107	256	35
36	2023-10-08	209	286	36
37	2023-11-04	29	60	37
38	2023-10-06	217	104	38
39	2023-10-27	191	145	39
40	2023-08-23	157	206	40
41	2023-09-24	293	273	41
42	2023-09-15	89	73	42
43	2023-10-29	132	24	43
44	2023-08-17	86	177	44
45	2023-09-11	84	268	45
46	2023-08-22	38	235	46
47	2023-10-04	259	194	47
48	2023-10-08	108	190	48
49	2023-10-10	51	82	49
50	2023-09-10	37	144	50
51	2023-11-04	143	202	51
52	2023-09-26	268	86	52
53	2023-09-26	275	189	53
54	2023-08-11	240	144	54
55	2023-09-09	5	68	55
56	2023-08-01	255	155	56
57	2023-09-05	132	24	57
58	2023-10-06	28	224	58
59	2023-09-06	245	298	59
60	2023-10-04	182	8	60
61	2023-10-05	208	87	61
62	2023-08-22	120	225	62
63	2023-09-27	79	177	63
64	2023-10-18	17	67	64
65	2023-08-14	299	119	65
66	2023-08-26	225	41	66
67	2023-08-31	222	77	67
68	2023-08-06	240	144	68
69	2023-08-02	245	298	69
70	2023-09-01	266	103	70
71	2023-08-26	244	233	71
72	2023-10-09	208	87	72
73	2023-10-02	37	144	73
74	2023-10-13	95	89	74
75	2023-10-18	44	274	75
76	2023-09-21	141	252	76
77	2023-08-11	1	228	77
78	2023-10-28	173	162	78
79	2023-08-20	172	102	79
80	2023-10-09	209	286	80
81	2023-11-02	118	285	81
82	2023-09-21	99	260	82
83	2023-10-07	62	198	83
84	2023-10-24	143	202	84
85	2023-10-07	174	299	85
86	2023-11-08	159	45	86
87	2023-08-22	43	74	87
88	2023-08-09	73	191	88
89	2023-10-30	103	151	89
90	2023-08-10	123	280	90
91	2023-08-25	232	99	91
92	2023-10-21	115	291	92
93	2023-11-02	185	11	93
94	2023-08-03	190	163	94
95	2023-10-14	14	260	95
96	2023-11-01	67	96	96
97	2023-10-16	277	51	97
98	2023-10-18	160	203	98
99	2023-09-09	64	17	99
100	2023-09-13	106	236	100
101	2023-10-09	240	144	101
102	2023-10-24	171	138	102
103	2023-09-06	259	194	103
104	2023-08-31	275	189	104
105	2023-10-09	244	233	105
106	2023-09-09	103	151	106
107	2023-09-26	179	175	107
108	2023-09-07	232	99	108
109	2023-10-13	32	112	109
110	2023-09-02	278	212	110
111	2023-09-10	272	123	111
112	2023-10-24	123	280	112
113	2023-09-11	205	200	113
114	2023-10-21	145	34	114
115	2023-08-13	3	42	115
116	2023-09-05	226	68	116
117	2023-09-25	201	228	117
118	2023-09-09	141	252	118
119	2023-09-15	73	191	119
120	2023-09-24	95	89	120
121	2023-08-07	32	112	121
122	2023-10-06	196	110	122
123	2023-08-18	275	189	123
124	2023-08-03	240	144	124
125	2023-09-23	108	190	125
126	2023-11-07	235	90	126
127	2023-09-14	13	259	127
128	2023-10-25	77	82	128
129	2023-09-15	272	123	129
130	2023-10-19	14	260	130
131	2023-09-10	160	203	131
132	2023-10-26	167	60	132
133	2023-08-24	4	14	133
134	2023-09-21	265	199	134
135	2023-10-17	243	76	135
136	2023-10-31	34	229	136
137	2023-08-27	209	286	137
138	2023-10-26	139	14	138
139	2023-09-17	40	226	139
140	2023-10-22	237	199	140
141	2023-08-09	47	216	141
142	2023-10-15	79	177	142
143	2023-09-02	52	107	143
144	2023-08-05	44	274	144
145	2023-10-02	200	227	145
146	2023-10-13	275	189	146
147	2023-09-10	11	281	147
148	2023-09-22	114	67	148
149	2023-10-14	65	166	149
150	2023-10-24	22	187	150
151	2023-10-16	24	167	151
152	2023-09-02	229	148	152
153	2023-09-29	145	34	153
154	2023-09-05	249	232	154
155	2023-09-22	13	259	155
156	2023-10-31	173	162	156
157	2023-10-03	299	119	157
158	2023-10-07	213	221	158
159	2023-08-07	204	220	159
160	2023-10-27	74	124	160
161	2023-09-21	98	44	161
162	2023-09-07	6	237	162
163	2023-11-01	297	236	163
164	2023-08-16	229	148	164
165	2023-10-17	277	51	165
166	2023-11-07	28	224	166
167	2023-09-30	279	182	167
168	2023-09-17	293	273	168
169	2023-10-13	176	44	169
170	2023-10-31	114	67	170
171	2023-09-01	182	8	171
172	2023-08-21	106	236	172
173	2023-09-25	225	41	173
174	2023-08-24	42	128	174
175	2023-08-01	106	236	175
176	2023-10-21	225	41	176
177	2023-09-27	182	8	177
178	2023-09-22	13	259	178
179	2023-08-14	118	285	179
180	2023-09-25	133	114	180
181	2023-08-31	3	42	181
182	2023-09-30	191	145	182
183	2023-11-03	159	45	183
184	2023-09-18	245	298	184
185	2023-09-16	89	73	185
186	2023-09-17	79	177	186
187	2023-09-16	34	229	187
188	2023-10-02	293	273	188
189	2023-08-15	111	196	189
190	2023-08-15	42	128	190
191	2023-10-07	147	91	191
192	2023-08-30	266	103	192
193	2023-11-06	88	29	193
194	2023-10-29	72	64	194
195	2023-09-23	232	99	195
196	2023-08-05	104	131	196
197	2023-10-12	167	60	197
198	2023-08-25	132	24	198
199	2023-10-22	275	189	199
200	2023-09-30	103	151	200
201	2023-11-03	37	144	201
202	2023-09-06	271	235	202
203	2023-10-10	174	299	203
204	2023-09-21	220	253	204
205	2023-10-02	253	90	205
206	2023-09-29	4	14	206
207	2023-09-24	62	198	207
208	2023-08-28	145	34	208
209	2023-08-21	271	235	209
210	2023-08-07	64	17	210
211	2023-09-29	67	96	211
212	2023-10-18	256	77	212
213	2023-11-05	165	100	213
214	2023-09-16	122	257	214
215	2023-10-27	69	12	215
216	2023-09-15	77	82	216
217	2023-10-12	213	221	217
218	2023-08-20	172	102	218
219	2023-08-27	289	100	219
220	2023-08-25	204	220	220
221	2023-09-02	46	51	221
222	2023-10-04	108	190	222
223	2023-08-29	42	128	223
224	2023-08-02	145	34	224
225	2023-10-10	297	236	225
226	2023-08-19	171	138	226
227	2023-08-27	260	280	227
228	2023-10-05	76	159	228
229	2023-08-29	232	99	229
230	2023-08-12	167	60	230
231	2023-09-11	51	82	231
232	2023-09-16	143	202	232
233	2023-10-04	153	101	233
234	2023-08-15	47	216	234
235	2023-10-15	32	112	235
236	2023-08-31	278	212	236
237	2023-09-24	141	252	237
238	2023-08-12	190	163	238
239	2023-09-21	244	233	239
240	2023-11-03	77	82	240
241	2023-08-19	263	294	241
242	2023-09-18	15	156	242
243	2023-09-04	124	81	243
244	2023-11-04	62	198	244
245	2023-08-05	91	229	245
246	2023-10-30	72	64	246
247	2023-10-02	165	100	247
248	2023-10-15	205	200	248
249	2023-08-02	204	220	249
250	2023-08-22	225	41	250
251	2023-09-22	62	198	251
252	2023-08-10	42	128	252
253	2023-10-25	215	1	253
254	2023-09-10	14	260	254
255	2023-09-22	266	103	255
256	2023-11-03	115	291	256
257	2023-09-03	213	221	257
258	2023-08-07	220	253	258
259	2023-09-29	13	259	259
260	2023-09-07	100	90	260
261	2023-10-23	115	291	261
262	2023-10-17	279	182	262
263	2023-09-25	79	177	263
264	2023-10-12	173	162	264
265	2023-11-02	6	237	265
266	2023-09-15	244	233	266
267	2023-11-01	176	44	267
268	2023-08-15	143	202	268
269	2023-11-09	237	199	269
270	2023-10-06	91	229	270
271	2023-09-09	28	224	271
272	2023-10-16	156	111	272
273	2023-11-08	156	111	273
274	2023-11-07	141	252	274
275	2023-08-04	130	297	275
276	2023-10-10	83	108	276
277	2023-09-25	266	103	277
278	2023-09-13	215	1	278
279	2023-10-27	95	89	279
280	2023-08-15	278	212	280
281	2023-09-15	217	104	281
282	2023-09-05	259	194	282
283	2023-11-05	190	163	283
284	2023-09-14	172	102	284
285	2023-09-17	186	1	285
286	2023-10-17	144	122	286
287	2023-08-18	205	200	287
288	2023-08-04	42	128	288
289	2023-10-05	172	102	289
290	2023-08-20	160	203	290
291	2023-09-12	6	237	291
292	2023-08-01	208	87	292
293	2023-08-15	153	101	293
294	2023-09-28	3	42	294
295	2023-09-04	253	90	295
296	2023-09-10	8	81	296
297	2023-08-05	103	151	297
298	2023-09-07	115	291	298
299	2023-10-23	266	103	299
300	2023-10-09	76	159	300
\.


--
-- Data for Name: pregunta; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.pregunta (id_pregunta, preguntas_del_producto, fecha_de_la_pregunta) FROM stdin;
0		1900-01-01
1	¿La lámpara de escritorio incluye la bombilla?	2020-09-01
2	Hola, no. Cualquier otra consulta estoy a su disposición	2020-09-01
3	Bombita De cuantos w soporta el artefacto ? El portalámparas es universal ?	2020-09-01
4	¡Hola! Es el portalámparas convencional a rosca comúnmente denominado E27 Máximo 60w...cuando normalmente se utilizan lámparas entre 9w y 12w de led que te representan entre 60 a 75w de las antiguas lámparas incandescentes Saludos	2020-09-02
5	Okey, muchas gracias!	2020-09-02
6	¿La lámpara de escritorio tiene ajuste de intensidad de luz?	2020-09-17
7	¡Hola! No, no tiene ajuste de la intensidad de luz. Saludos	2020-09-18
8	¿Viene con garantía el Samsung Galaxy S23 Fe?	2023-05-02
9	¡Hola!Si viene con garantía. ¡Gracias por su consulta! Saludos.	2023-05-02
10	Buenisimo! Gracias!.	2023-05-02
11	Por nada!  Estamos a tu disposición cualquier otra consulta que desee hacernos.	2023-05-03
12	Hola, ¿ tiene carga inalámbrica el Samsung Galaxy S23 Fe?	2023-05-12
13	Hola, esperamos se encuentre bien. Le informamos que el Samsung Galaxy S23 Fe 128gb 8gb Ram Violeta posee: 3.900 mAh-Carga rápida de 25 W-Carga inalámbrica de 10 W. Quedamos a disposición. ¡Gracias por su consulta! Saludos.	2023-05-13
14	¿El Samsung Galaxy S23 Fe tiene ranura para tarjeta de memoria externa?	2023-07-18
15	Hola, esperamos se encuentre bien. Le informamos que el Samsung Galaxy S23 Fe 128gb 8gb Ram Violeta si tiene ranura para tarjeta de memoria externa. Quedamos a disposición. ¡Gracias por su consulta! Saludos.	2023-05-13
16	Genial! Muchas gracias!	2023-05-13
17	Por nada!  Estamos a tu disposición cualquier otra consulta que desee hacernos.	2023-05-14
18	¿Cuál es el diámetro de la mesa auxiliar?	2021-11-03
19	¡Hola! El diámetro es de 41cm x 53cm de altura. Saludos	2021-11-03
20	¿La mesa auxiliar requiere montaje?	2021-11-12
21	¡Hola! La mesa no requiere montaje	2021-11-12
22	¿Cuánto pesará el pedido entonces? Ya que viene montada	2021-11-12
23	¿Tiene la notebook Ryzen 7 Asus Vivobook teclado retroiluminado?	2022-12-24
24	Hola, muchas gracias por su consulta. Sí, cuenta con teclado retroiluminado. Cualquier otra duda quedamos a su disposición.	2022-12-25
25	Hola, ¿Sirve para  diseño 3D? La notebook Ryzen 7 Asus Vivobook	2023-08-11
26	Hola, muchas gracias por su consulta. Sí te sirve. Cualquier otra duda quedamos a su disposición.	2023-08-11
27	¡Gracias!	2023-08-11
28	De nada!. Cualquier otra consulta quedamos a su disposición. Saludos!	2023-08-11
29	¿La notebook Ryzen 7 Asus Vivobook tiene teclado numérico?	2023-05-25
30	Hola, muchas gracias por su consulta. Sí tiene. Cualquier otra duda quedamos a su disposición.	2023-05-26
31	¿Es tactil el reloj unisex Gadnic?	2022-10-05
32	Hola ¿Cómo estás? Es con pantalla táctil. Estamos online las 24 horas para brindarte la mejor atención y responder todas tus consultas Saludos.	2022-10-05
33	¿Es fuerte la malla?	2022-10-05
34	Hola ¿Cómo estás? Si claro, la malla es super resistente.Estamos online las 24 horas para brindarte la mejor atención y responder todas tus consultas Saludos.	2022-10-06
35	Buenisimo! Entonces compraré.	2022-10-06
36	¿Viene con soporte de montaje en pared el Smart TV LG Smart TV 43ur8750?	2023-04-06
37	¡Hola! no está incluido. Saludos.	2023-04-06
38	ah bueno, está bien, gracias.	2023-04-06
39	¿El televisor LG Smart TV 43ur8750 trae control remoto?	2022-11-27
40	¡Hola! SI Saludos.	2022-11-27
41	¿Se venden las sillas de comedor por separado?	2019-01-07
42	Hola, no se vende por separado. Saludos	2019-01-07
43	¿La silla de comedor es ajustable en altura?	2019-02-08
44	Hola, no es ajustable. Saludos	2019-02-09
45	¿Viene ensamblada la mesa de centro o requiere montaje?	2023-04-08
46	Hola, viene ensamblada. Saludos	2023-04-09
47	Hola, ¿Es stereo? ¿Y cuanto dura la batería aprox del parlante Philco Djp10p?	2021-11-09
48	Hola. Te confirmamos que si es estéreo y la duración de la batería depende del uso que se le dé al producto. Aguardamos tu compra. Saludos	2021-11-09
49	Pero me podrias dar un estimado de la duración?	2021-11-09
50	¿Viene con estuche de carga los auriculares inalámbricos AirPods Pro 2da Generación?	2022-06-10
51	Hola y gracias por comunicarnos!Si trae estuche de carga. Quedamos a disposición, saludo 	2022-06-11
52	¿Los auriculares inalámbricos AirPods Pro 2da Generación son compatibles con Android?	2023-03-15
53	Hola, ¿cómo estás? Muchas gracias por contactarnos. No es compatible, desde ya muchas gracias y saludos.	2023-03-16
54	¿Los auriculares inalámbricos tienen cancelación activa de ruido?	2023-03-20
55	Hola, ¿cómo estás? Muchas gracias por contactarnos. Si tienen cancelación de ruido, desde ya muchas gracias y saludos.	2023-03-21
\.


--
-- Data for Name: pregunta_producto_usuario; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.pregunta_producto_usuario (pregunta, producto, usuario) FROM stdin;
0	301	18
1	301	1
2	301	18
3	301	2
4	301	18
5	301	12
6	301	12
7	301	18
0	302	5
8	302	14
9	302	5
10	302	14
11	302	5
12	302	199
13	302	5
14	302	206
15	302	5
16	302	206
17	302	5
0	303	7
18	303	173
19	303	7
20	303	228
21	303	7
22	303	228
0	304	10
23	304	63
24	304	10
25	304	128
26	304	10
27	304	128
28	304	10
29	304	145
30	304	10
0	305	4
31	305	77
32	305	4
33	305	230
34	305	4
35	305	230
0	306	8
36	306	171
37	306	8
38	306	171
39	306	224
40	306	8
0	307	13
41	307	298
42	307	13
43	307	273
44	307	13
0	308	15
45	308	67
46	308	15
0	309	11
47	309	82
48	309	11
49	309	82
0	310	16
50	310	101
51	310	16
52	310	113
53	310	16
54	310	201
55	310	16
0	1	276
0	2	86
0	3	14
0	4	298
0	5	33
0	6	73
0	7	187
0	8	151
0	9	88
0	10	73
0	11	5
0	12	45
0	13	156
0	14	265
0	15	85
0	16	289
0	17	291
0	18	62
0	19	60
0	20	99
0	21	255
0	22	122
0	23	60
0	24	27
0	25	296
0	26	72
0	27	207
0	28	197
0	29	157
0	30	163
0	31	110
0	32	157
0	33	143
0	34	204
0	35	184
0	36	98
0	37	279
0	38	207
0	39	297
0	40	86
0	41	85
0	42	172
0	43	212
0	44	10
0	45	165
0	46	254
0	47	268
0	48	62
0	49	183
0	50	89
0	51	184
0	52	21
0	53	282
0	54	224
0	55	52
0	56	143
0	57	71
0	58	79
0	59	282
0	60	282
0	61	15
0	62	112
0	63	106
0	64	277
0	65	295
0	66	191
0	67	248
0	68	166
0	69	45
0	70	36
0	71	124
0	72	163
0	73	97
0	74	42
0	75	202
0	76	11
0	77	18
0	78	201
0	79	17
0	80	68
0	81	257
0	82	270
0	83	258
0	84	114
0	85	185
0	86	281
0	87	145
0	88	141
0	89	273
0	90	28
0	91	234
0	92	137
0	93	193
0	94	63
0	95	62
0	96	198
0	97	188
0	98	276
0	99	230
0	100	242
0	101	275
0	102	300
0	103	21
0	104	287
0	105	138
0	106	60
0	107	150
0	108	227
0	109	153
0	110	110
0	111	1
0	112	54
0	113	138
0	114	29
0	115	114
0	116	244
0	117	167
0	118	94
0	119	21
0	120	272
0	121	259
0	122	5
0	123	85
0	124	250
0	125	12
0	126	212
0	127	45
0	128	165
0	129	97
0	130	128
0	131	259
0	132	45
0	133	265
0	134	121
0	135	253
0	136	251
0	137	85
0	138	98
0	139	233
0	140	125
0	141	179
0	142	127
0	143	176
0	144	280
0	145	166
0	146	195
0	147	186
0	148	200
0	149	25
0	150	248
0	151	233
0	152	147
0	153	231
0	154	112
0	155	259
0	156	295
0	157	181
0	158	62
0	159	24
0	160	18
0	161	145
0	162	130
0	163	274
0	164	31
0	165	88
0	166	180
0	167	161
0	168	14
0	169	83
0	170	119
0	171	158
0	172	74
0	173	51
0	174	1
0	175	91
0	176	60
0	177	164
0	178	61
0	179	134
0	180	1
0	181	5
0	182	139
0	183	144
0	184	34
0	185	281
0	186	262
0	187	7
0	188	165
0	189	127
0	190	231
0	191	51
0	192	172
0	193	76
0	194	13
0	195	156
0	196	288
0	197	110
0	198	150
0	199	220
0	200	47
0	201	165
0	202	89
0	203	271
0	204	187
0	205	35
0	206	117
0	207	178
0	208	209
0	209	267
0	210	43
0	211	137
0	212	179
0	213	118
0	214	214
0	215	188
0	216	194
0	217	62
0	218	102
0	219	276
0	220	31
0	221	113
0	222	1
0	223	119
0	224	165
0	225	268
0	226	68
0	227	16
0	228	199
0	229	230
0	230	294
0	231	207
0	232	141
0	233	131
0	234	130
0	235	26
0	236	84
0	237	237
0	238	155
0	239	169
0	240	277
0	241	284
0	242	114
0	243	207
0	244	211
0	245	217
0	246	83
0	247	221
0	248	42
0	249	291
0	250	281
0	251	237
0	252	289
0	253	75
0	254	71
0	255	127
0	256	187
0	257	287
0	258	124
0	259	97
0	260	265
0	261	96
0	262	33
0	263	7
0	264	270
0	265	67
0	266	149
0	267	44
0	268	124
0	269	144
0	270	154
0	271	70
0	272	94
0	273	53
0	274	198
0	275	79
0	276	207
0	277	90
0	278	122
0	279	57
0	280	80
0	281	16
0	282	222
0	283	79
0	284	207
0	285	284
0	286	253
0	287	111
0	288	29
0	289	190
0	290	296
0	291	128
0	292	249
0	293	82
0	294	3
0	295	234
0	296	227
0	297	159
0	298	289
0	299	150
0	300	1
\.


--
-- Data for Name: pregunta_respuesta; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.pregunta_respuesta (pregunta, respuesta) FROM stdin;
1	2
3	4
4	5
6	7
8	9
9	10
10	11
12	13
14	15
15	16
16	17
18	19
20	21
21	22
23	24
25	26
26	27
27	28
29	30
31	32
33	34
34	35
36	37
37	38
39	40
41	42
42	43
43	44
45	46
47	48
48	49
50	51
52	53
54	55
\.


--
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.producto (numero_articulo, es_nuevo, precio_unitario, detalle, descripcion_producto, nombre_producto, stock, calificacion) FROM stdin;
1	t	379.46	Low number course likely.	Computer production add oil admit throw end receive. Painting teacher evening picture guess professor standard. Base point everything remember save. Stock hand look trip will. Sound exactly entire process often recognize message. Energy professor effect bed side theory other.	Google Pixel 4a	60	4
2	f	1601.62	Marriage quite easy cold focus them put. Man organization democratic next address those.	Fight including major stock commercial condition of. Writer turn six usually prepare. Forward individual sure both certainly community. She bring least share protect walk allow. Behavior beyond as open. Upon strong hair guy season.	Birkenstock Yao	1	1
3	t	3825.87	Run several together interview rest cultural test. My able coach pretty sit east indicate.	Raise win guess although. Option though she way such. Including network study ground me. National lead central stage. Law really because who speak all. West word have woman do two sure.	Google Pixel 3 XL	81	3
4	f	1926.00	Particular language describe feeling.	Yard safe anyone room into myself. Her explain anyone similar recognize forget ground back. Surface ahead order.	Planta	1	1
5	t	8983.82	Language husband expect kitchen action off. Reach central thought college well though.	Chance raise significant enough assume quality. Learn leader matter develop. Base that interview. Study including evidence want.	OnePlus 3	73	2
6	t	1770.50	Air bit time big difficult woman this. Event stuff official Republican can both worker.	Set force light character international week offer common. Really now store I paper kid baby. Add successful find human science. Western concern shoulder detail. Old million audience last crime. Leave this moment figure.	Sony Xperia 10	18	1
7	t	1939.50	Begin anyone mean send both teach society community.	Management top finally at. Half since sometimes worker degree. Group leg mean. Memory style may difference. Already knowledge place film. Question dog small type site card.	Google Pixel 2	5	4
8	t	8128.60	Like identify boy well throughout mean. Star measure discover ok claim gun.	Though list order inside might practice. Eye entire soldier. Daughter remember drop charge value. Toward movement agent government listen.	Cuadro	72	4
9	f	1280.55	Service score son air certain million include pressure. Performance type relate friend garden short.	Paper western away view watch someone store. Plan shoulder change start. Rest activity or top drop.	Espejo	1	3
10	f	750.89	Game election receive team treatment.	Bank follow player article team. High toward property. Seek low old open clearly bill receive.	Huawei P30 Pro	1	3
11	f	69.59	Contain team long travel from while. Cause toward project compare.	Business senior five. Sound that two. Mrs career society occur put debate. Site Democrat heart forward owner score focus.	OnePlus 6	1	5
12	t	4011.73	Including field produce successful front.	Too certain manage teacher. Investment financial paper analysis technology personal plan. Assume arrive amount about event edge husband outside. From factor century there provide study. Try both better newspaper matter.	Huawei P40 Lite	55	1
13	t	4002.65	Staff prepare adult success. Magazine foreign close performance future step surface.	Food tough yet window ten discuss six every. Next reach sing blood participant. Career issue building local respond them.	Amana ABB1924BRM	77	4
14	t	4744.94	Likely glass anyone mouth car. Look strong international stock.	Create Republican common the important add until. Too assume Democrat. Charge discussion successful interview scene building care.	Espejo	11	2
15	t	744.62	Piece science but simply small about church benefit. Training green hundred agency simple behavior involve involve.	Start but talk president occur. Building across mention onto call policy leg. Every society task whom reflect crime court. Reach responsibility real remain nor.	Teléfono	20	5
16	t	6997.17	Present worker billion simple bad choice. Civil politics account list somebody article.	Throughout home character past study provide. Everything activity stay again soon production certainly. Catch election opportunity tax act rate.	Ecco Biom Fjuel	43	5
17	t	4439.56	Tend administration next avoid real improve. Which husband agreement loss.	Win also doctor will will store total score. Bit the organization international keep. Give central generation yes. Officer sit already hold until. Trouble city measure like baby report make how.	Huawei P20 Pro	68	2
18	t	8436.39	Traditional improve second note catch.	Dinner consumer foreign economy. This above stay owner many. East name five term. Feel play myself. Some store car black man agency act agree. Live discuss role law blood also itself.	Vionic Tide	34	3
19	f	2698.07	Together with town feel stop. Try everyone produce for run that apply.	Carry rule society bank animal indeed born. Onto short picture list trial season. Either message court culture tax artist ten. Recognize probably from whether exactly huge summer. Seem nearly behavior cut president plan.	Vans Old Skool	1	3
20	t	8732.65	Might week take them marriage prevent town.	Guy collection structure professional forget red company walk. Health despite such social suddenly. Executive although beautiful. Claim point wind concern poor indeed. Little white list reflect. Leader friend on up source together. Around send a bring choice lawyer indeed training.	Birkenstock Mayari	77	3
21	f	7776.32	Congress imagine style positive increase vote.	Cover per kitchen item degree thousand near. Whose always activity goal. Down approach serve view size director your. Series lead on third drug sing stand any.	UGG Fluff Yeah	1	2
22	f	3075.42	Mother build wife decide.	Play policy able without debate. Four fact street mother once agent. Maintain federal open usually left feel. Discussion standard decide.	Silla	1	2
23	t	3266.74	Degree around reach. Identify those drive five.	Defense cut as image. Concern common degree among. Center six leg deep operation alone statement. Much bar customer game strategy interesting enough. Someone boy pull responsibility hard thank too.	Dr. Martens 2976 Chelsea Boot	75	3
24	t	129.50	Professional international economy down. Year meet within prepare doctor.	A recognize member project exist up option. Federal however bill size possible management. Low network wife point describe air argue. Same explain boy true.	Huawei P30 Pro	64	3
25	t	3151.23	Father admit value. Easy fill chair.	Actually game evidence foreign century her husband. Claim condition growth admit article. Check mouth time tend crime score. Seek trade chance anything thought how.	Samsung Galaxy A51	24	1
26	t	7430.27	Prepare week machine heavy increase me suffer.	Face quality thank production. Challenge half born organization. What product trip family. Couple like heart fine. Former democratic include method. Direction notice respond employee read score language.	OnePlus 7T	15	2
27	t	1285.87	Line soon deal son. Effect visit morning happen.	Major summer garden heart party sense truth Congress. Manage affect you fly receive. Fear best admit generation style.	Samsung QLED Q90T	15	2
28	t	1181.55	Every no their purpose.	West remain clearly. Surface produce teacher party happy. Enough surface leg manage. Like also growth purpose artist investment. Low sense director. Type benefit eat situation.	Columbia Redmond V2	51	5
29	t	5428.39	South contain protect.	Close size western thing line. Available suddenly rock already strong language doctor. City father no.	Samsung Galaxy S10e	85	3
30	t	5472.14	Lead interview court learn available clear protect.	Our agency eat kid ever college. Inside energy rather. Lead someone role economic pattern. Pattern feel people sometimes fund.	Timberland Earthkeepers	67	4
31	f	3528.26	Store such sell pick still.	Red experience responsibility oil seem feeling production. Last law on investment major factor establish. Option size cause great above pretty. Perhaps rule person play production indeed.	Samsung Galaxy Note 10	1	2
32	t	6156.40	Thank parent live network less game rather miss. Weight range student success include office property situation.	Test through know network represent wait raise. Candidate determine dream prepare same away age. Impact kid evidence begin best central. Boy fear region month protect forget. Growth wall than range open writer. Budget inside those sometimes nothing decision form.	KitchenAid KRFC300ESS	78	3
33	f	5683.86	Lay certain significant.	Computer financial call open. Mr such may use. Talk head both class marriage join kid mention.	Birkenstock Milano	1	5
34	f	6355.20	Save provide scene rest page outside why. Whom door adult popular together media.	Piece western card. Face suffer shake safe hope throughout. War pattern family go. Player charge put interest source interesting seven.	Silla	1	2
35	f	3957.70	Hotel save read grow.	Serve expect sound agent ok tax. Benefit contain its college. Feeling get approach under best. Economic person couple somebody as commercial far.	Converse Chuck 70	1	3
36	f	9129.77	Tax discussion center century trip. Play really executive statement long lose life.	Drug blue number idea at both. Matter as bank section. Property president prepare see imagine on with thank.	Vans Authentic	1	3
37	f	1890.41	Character bit media score. Set cause Congress class every.	Field price possible large over movie suggest. Design lay someone office else wrong cut wear. News word concern result media ground other opportunity. Vote policy lot technology role arm pressure.	Cole Haan Original Grand	1	4
38	f	7265.07	Particular item food point. Feel section can call nor.	Decide poor lot hear pay machine. Common voice popular stay herself worry. Wind sell visit there. Claim ask nearly current citizen. Treatment skill rock measure. Someone Mrs now remain degree office finish day.	Xiaomi Mi 9T Pro	1	1
39	t	5107.25	Color police my.	Real position far friend. Expect west senior become view economy foot. Say avoid indeed.	Google Pixel 3a XL	86	2
40	t	8497.63	Safe challenge born available speech particularly mission source. Foot compare go answer world least note.	Suffer build onto cup increase only. Radio organization onto ask. Write method artist week week. Around follow themselves Mr. Major pressure meet general. Manage memory firm election.	Dr. Martens 1460	97	3
41	t	5631.85	Explain hot measure know bill together activity. Alone season where worry.	Ten share stuff huge floor. Check spend those high degree development. Phone movement follow.	UGG Dakota	17	4
42	t	2173.97	Happy modern us author notice relationship affect. Tv light economic.	Call expert pay leader place. Reality allow support. Tv happy miss century alone coach old. Treat without a every. Station push hotel.	Sony Xperia XZ	58	1
43	t	6894.24	Mr but design nation yes.	Seek study process special amount sit to. Cultural southern fact real early. Over picture low long Democrat less. Difficult necessary bit peace. Capital color include population party.	Samsung Galaxy A51	97	4
44	t	7805.78	Television interview especially strong list movement night.	Few check doctor enough position change. Performance rule foreign see our purpose. Send business analysis reveal. Between just three single determine whether customer. Piece allow son fill. Popular today on ground suddenly heart as visit.	iPhone 6 Plus	89	1
45	t	6776.29	These thus development.	These long American just chance avoid commercial investment. Media save beat maintain paper arm. Energy physical we whose rich. Doctor side occur page. Couple bed network sound will. Church similar tree.	Taza	53	2
46	t	3989.77	Also notice gas meeting. Onto woman speak national.	There special around strong where born hand build. Once space father other race ever. Individual figure him little effect a. Small prevent sing painting.	Teva Tirra	19	2
47	f	8929.94	Professor report personal special main.	Quickly job health amount executive during then. Final apply involve day ready would. Young adult rate democratic station traditional board.	Paraguas	1	5
48	f	2752.16	Site long machine out participant factor every. White half view discover.	Nice hope culture blue sell according. Room teach price win yard. Pattern forward according bit finally fine. Help look he lay choice officer relate.	Sony Xperia 5 II	1	4
49	t	2605.11	Others party dinner not. Partner decade month stock official two movie.	Front fire day new only themselves too around. Realize in go culture actually. Would long record ago class.	Birkenstock Yao	99	1
50	f	6411.36	Write once government senior within attention. Test plan system wait order fine.	Together compare entire former teach campaign. Some democratic role. Compare here pattern partner hit. Message police half issue trip never.	Fila Disruptor II	1	4
51	t	581.17	Pattern may water management but budget for. Born already billion message chance whatever.	Put under grow everything business our series if. Strong kitchen position series sure. Rest value relate stay general become specific. Theory whole raise board field speech edge. Trial successful Mrs stand may wait painting.	Under Armour Charged Assert 8	99	4
52	t	4652.34	Policy today garden sell particular past growth.	Tough last now tax crime without blood political. Role wall modern expect sit. Family evidence character future line left.	Sony Xperia 5 II	20	3
53	t	4176.47	Drop sense despite.	Mission include medical point discover step second. Really value stand various campaign record during. Military morning task listen. Perform staff apply whom market. Whose thought personal seem charge. One best rock total position class.	Keen Targhee II	38	5
54	f	4886.11	Firm high operation newspaper season concern. Seem charge consumer right house.	Station situation chair loss program. Lose Mr make line tough. A out member effect hair least make. Cost meeting region way ability inside rather. Discover certainly enjoy challenge per result.	Guitarra	1	4
55	f	4954.13	Affect worker down. Third fill loss will whose.	Whole community above page. Vote Mr instead address have score kitchen. Task whatever between bag term open color.	Dr. Martens 1460	1	2
56	f	5300.66	Thousand raise face later. Worker already discussion environment man.	Eight true argue. Fact impact wear rule else during. Girl meet high much such must movement want. Test red wide work. Low pretty care. Cover style ball then.	Vela	1	3
57	f	6476.82	True different modern month be television despite effort.	Along call bring actually. Not worry almost sure first read whose together. Sense approach note cold gas. Well difference human summer market hope adult.	Salomon XA Pro 3D V8	1	3
58	f	8551.73	Traditional right campaign call.	Continue field we drug. Quality century attention. Cultural owner I place. Positive oil each whatever air wife parent. Again speak street current reflect couple Republican major. Bar turn hand ten owner new.	Samsung QLED Q90T	1	5
59	t	3318.61	Hold Republican such site politics everything. Tell close cold interview cold easy push whatever.	Loss career animal continue. Million capital mind hour enough. Defense stuff win they that teacher. Increase piece factor good hospital prove age someone. Fly and Congress mind push fight.	LG OLED C1	51	5
60	f	8390.78	Identify task politics on onto thing.	Around spend project movement. Special natural positive walk place single the. Next within record vote girl write test.	Libro	1	4
61	t	1285.82	Vote such fight sign nor success fear shoulder.	Over blood capital move commercial line pay. Live compare last drive power start body. Federal management husband cup conference. North painting activity their keep word positive. Source suffer college beat because than. Call ago politics west.	Converse Chuck 70	31	2
62	f	5130.76	Participant cold customer push instead prove style itself.	Common budget hundred data price common. Use career court school provide south task. Yet attack financial suffer. Drop hundred social.	Teva Tirra	1	2
63	f	5542.57	Sound glass success. Expect month meet site skin.	Who nearly ask. I little shake adult. Difficult bank human technology matter. Once strategy before news two own fish. Return know far street summer bed tell.	KitchenAid KRMF706ESS	1	2
64	t	3346.73	Win anyone find recent concern which fall single. After interesting official base music.	Relate however amount rate effort describe build. Hold no family Democrat. Season law threat bag skin her difference. Car as concern evidence when commercial spring. Cell less dog always.	Mesa	64	1
65	f	4742.17	Score begin popular serve another.	Energy remember heart could. International somebody choose decade pass. Or about generation boy television report. Wall local employee fill Mrs deal.	Reloj	1	2
66	f	8158.31	Box base film how one. Position everybody community get off wish sound feel.	Serve whatever against color near decision huge today. Ready scene relationship see. Although read send personal charge year. I state ago show money respond participant. Price speak professor form.	OnePlus 7T Pro	1	5
67	f	2028.18	President executive many soon general lawyer.	Current through fine. Hard past range network. Smile mother we finally which affect theory.	Toalla	1	4
68	t	7908.70	Draw half notice contain.	Thing memory pattern. Time politics get statement image popular probably. Election site than quality small among into. Energy hit field see alone next continue. Your investment house guy report her. Late purpose result shake.	Sony Xperia 10	13	4
69	f	5047.69	Education watch policy government future whose.	Do success company bank. Bring instead one experience. Data finally develop military green card direction. Board there administration between interest ok exactly two. Art her anything tree.	ASICS Gel-Nimbus 23	1	3
70	t	8917.75	Law rule specific computer PM policy decide high. Treat mind population everybody thought table business.	Card college measure occur. Tv industry radio return compare above. Season prepare sell hundred best through he. Big science now actually market.	Sony Xperia 10 Plus	14	5
71	t	6741.91	Best save consumer leader.	Despite suggest environmental thing. Evening into measure everybody glass form fact. Him value could agent music. Level world page hope imagine within require.	Reebok Classic Leather	10	4
72	t	2008.93	Campaign she move relationship. Factor understand situation sister.	All air degree player. Call attention city off arrive discover reach. Game miss room would. Son produce rate surface environmental. Head senior black table for. Television result night drop.	LG NanoCell 90	52	5
73	f	2083.41	Executive owner black tough hope while.	Stay significant stage mission another establish. Perhaps young moment because low. Together country leave clearly along.	Google Pixel 2 XL	1	2
74	f	1194.57	Cup civil with admit. School lawyer year method report.	Visit decision skin off stock expert must clearly. Coach need site necessary economy meet might. Worry type billion goal lose former. List travel wall former everyone PM traditional.	OnePlus 5T	1	2
75	t	748.10	Us term stand season who responsibility. Side end certain economic heavy area security.	Choice born book work television. Family where range answer. Investment age probably doctor camera. Service Mr list.	Xiaomi Mi A3	42	2
76	f	4386.95	Heavy next politics move third.	Pattern forget modern summer there character decision. Board probably along impact side from. Environmental officer bag middle paper. Floor party prevent value. Safe girl theory kid dog.	Hoka One One Clifton 7	1	1
77	f	4063.71	Feeling see science region teacher lot.	Say name while policy simple audience. Together front side concern side recognize. Despite mouth role movie stock fall attack material. Likely dream certain mother recently season.	Sony Xperia XZ1	1	4
78	f	5717.56	Move realize suddenly job for. Marriage else no treatment consumer feel during know.	Test you land society. Sell feel everything bar worker yourself everybody. May different local customer off. At almost heart only list cover including. Foot choose teach she score. Ever almost section force appear lay others Mrs.	Samsung QLED Q90T	1	2
79	f	3453.02	Various him debate him man situation plan bit. Change drive range Congress business low.	Growth matter represent thought school show anyone allow. Cover smile sing perhaps available power garden. Half trade civil door herself allow. Themselves second structure. Fine once move member. Property draw letter bag.	Crocs Classic	1	4
80	t	8064.09	Window area activity.	Buy know concern past enjoy baby end. Price industry page find. Check star he same course increase sense process.	Converse Chuck Taylor All Star High Top	67	5
81	t	2246.68	Everyone old since check probably bit. Value wind maybe standard deep serve.	Charge school week. Expert many civil likely. Friend act rock bring happen economy.	Chaco Z/Cloud	47	5
82	f	8780.62	Price reveal recognize expect cell song through.	Father inside upon boy thank alone key necessary. Represent action feel weight. Stay very series impact story suffer itself. Rule live difference support institution receive. Over share ahead create.	TCL 6-Series R635	1	5
83	f	696.90	Interesting add break. Worker fact vote back good.	Evidence total side contain. Professional rate so church state hour arm tree. Western physical happen style. Floor artist relate song majority others hair back. Six themselves range plan nature its trouble.	Xiaomi Mi A2	1	3
84	t	2099.37	Might half low may role upon. Present big film defense list.	Themselves himself hair part our party performance. Black change whole citizen current. So sell fight investment create why. Politics concern project through kitchen dream.	Lápiz	70	2
85	t	5823.21	Real decide become more debate PM. Suffer official discussion election stop.	Catch bill us. Rich impact best thank wife artist. Seek major tonight only my. Question rest such unit inside process technology.	Chaco Z/2 Classic	88	2
86	f	4520.37	Week sea prepare move base minute task. Simply finally sing challenge more.	Person edge reduce around there center which. Market remember cultural whether several represent. Beyond sometimes then young writer young situation. Then some movement I. Action far notice such now small.	Chaco Z/2 Classic	1	5
87	f	6840.12	Media cold event hard up.	Himself soldier production order process building will old. Program play seven machine could. Reveal full cause until scene past. Hour health agent Mr fear. Lawyer information threat everyone happy forward rich.	OnePlus 6T	1	2
88	t	3447.11	Little bag reach way note. Walk manage citizen role open benefit.	Room sit somebody Mrs. Difference trouble positive law free happen value. Ok bar course vote although former. To technology listen have finish audience.	OnePlus 8 Pro	46	5
89	f	7597.88	Defense tell pay apply idea. Once data soon simple ten director.	Mouth century professor practice business million throughout beat. Recent strong interest right. Institution inside more admit wear. But relate surface effect audience most.	Steve Madden Gills	1	5
90	t	1327.61	Clear cold effect series possible require economy. Meeting since power central so professor its ready.	Term day foot meet win. Mean live Congress. Indeed newspaper particular Congress base difficult without. Upon myself available figure.	ASICS Gel-Kayano 27	25	2
91	f	3073.08	Then young four.	Movie end national PM as road. Laugh Mr whether top career culture cup. Fund call open information national finally. Suggest couple large play. Four garden rock and how they. Wide east tree friend behavior whether significant claim.	Xiaomi Mi 11	1	3
92	f	2414.94	Foreign Mr kitchen four. Right talk affect Democrat trouble.	Six summer listen bring artist. Somebody bit number skill. Bed without speech control major. Strong region tell out price couple week.	Xiaomi Mi A2	1	5
93	t	8688.14	Push turn on cause knowledge budget. Occur let once feel television name.	School candidate computer determine. Too control suffer campaign military lot. Open question official no. Establish forward arm less yard. Without manager need natural.	Xiaomi Redmi Note 8 Pro	76	5
94	f	2778.06	Approach paper around among.	Republican prove media court. Choice certain soldier new for. City hear event car arrive ago.	Google Pixel XL	1	2
95	t	5915.03	Bank between appear commercial door themselves. Red month staff according at total.	Recently bag enjoy develop throw type do. Executive brother trip mind evening much. Born left chance throughout author who radio wall. Specific music visit person huge. Create cold road such very.	Google Pixel 3 XL	18	1
96	f	190.27	Ready according usually difficult increase.	Radio least turn arrive price huge. Total ball four administration. Above hit industry.	LG LFXS28968S	1	5
97	f	9356.73	Attack gas they participant actually who vote.	Pressure have whatever maybe choice. Least sure player spring. Field than action minute raise old college. Although reveal because down drive sense. Explain upon sort station image.	Keen Newport H2	1	2
98	t	5358.95	Course education war century like husband strong.	Guy visit early yard who sell. Common tend leave member simple together citizen. Task eight across you minute last place. Speak material represent nothing between miss choice.	Google Pixel	25	5
99	f	5500.53	Discussion measure bag campaign. History partner dark market ability seem song.	Our writer nature indeed statement way much box. Discussion behavior learn international. Keep ok of nice range.	Paraguas	1	4
100	f	1520.17	Say daughter reveal morning. Truth mean spring talk sense they project.	Perhaps others few pay. Money education small capital never save. Religious ready someone law local magazine early. Box let just program check million.	Xiaomi Redmi Note 7	1	4
101	t	2181.84	Whom yard certainly air impact pretty.	Suddenly little build in and. White listen well while. Man trip meet. Alone threat close cost into theory. Ball side size long blue. Career citizen plant could material nearly.	Sony Xperia L3	45	2
102	f	7469.15	Level blue evening wish or president eight. Pick field son probably item building model agent.	Alone really left maybe. Future be speech upon. Against message trouble skill threat left. Road reality public large middle. Civil city central whether if.	New Balance 990	1	1
103	f	4699.74	Oil wish expect bill camera party ok. Ready class end meeting together protect first.	Bar myself loss factor. Team place tell financial of just fear traditional. Feel though investment say suddenly.	Converse Chuck Taylor All Star	1	4
104	f	8316.00	Again measure long financial bill. Suddenly big particularly manager stand wall.	Store also computer adult. Open free continue believe research trouble. Policy theory do require I. Once today although claim plant leave collection. In heart grow assume. Account authority manage.	Xiaomi Redmi Note 9S	1	3
105	f	7342.14	Degree evidence level peace information art local. Owner others summer coach represent instead then.	Public politics protect seem head deep. Pretty suffer play join peace make. About candidate soon positive magazine international company message. Son child skill. Very project country health my. My certain occur different knowledge.	Samsung Galaxy S10e	1	3
106	f	465.16	Trade trip member who central half.	Experience cover study last just age. My item human wear air worry page. Fast upon performance think bring last window.	Sony Xperia XZ3	1	4
107	t	2914.44	Color art under performance. Tend late three necessary area avoid report.	Message clearly black so audience near. Behavior unit instead politics. Something author rock military catch weight. How picture which fire themselves respond budget. Possible role evening situation follow time.	iPhone 5s	95	2
108	f	9758.70	Professional young bar. Piece build officer example.	Remain behind green second nice. Data give discuss they especially painting. Explain find top southern behavior would indeed. Show center rate professional. They agency student yes. Beautiful various event.	Sony Xperia XZ1	1	2
109	f	8887.06	According quite once sister investment station.	Free owner hand trial. Take collection social one Mr. Enjoy window artist there across not service. Often food learn person institution much treat watch.	Sony Xperia XZ2	1	1
110	f	9441.07	Cut station without check identify maybe action.	Scene around necessary authority career. Democrat easy choose example. Treat stand final know yeah. Study popular each church week explain factor. Time treatment no through part difficult wide. Part page buy particular. Success contain where popular.	Xiaomi Mi A3	1	1
111	t	4265.54	Guess apply join whole medical evidence firm.	Build article end federal throw particularly camera. Rise way apply idea me room. Baby break model head. Require true none send no to. Against door high determine explain be it step.	Merrell Jungle Moc	60	2
112	t	2028.73	Fine ready because address avoid.	Meeting cost situation bank American fear language. Now policy board five use. Case grow top run experience my stay ever.	Sony Xperia 5 II	71	3
113	t	6117.45	Standard society laugh they special any action. Similar ago after heavy.	Condition bring player car nor middle stay. Computer every anyone dark land heart laugh. Mention language miss note blood interview. Instead fear late around. Some simply much enjoy. Bad nearly once good edge project me.	Huawei Mate 20 Lite	83	2
114	f	9774.23	Line customer ability general single.	Hospital just team necessary drive mother. Forward rate thank save tell down. American owner sound scene dark. Today generation marriage participant receive rule charge continue.	Huawei P20 Pro	1	2
115	f	6274.35	Record may staff remember so feel.	Gas room can their. Population sit must car cultural. Store center maintain later.	Teva Hurricane XLT2	1	3
116	f	828.88	When the or increase partner huge.	The trouble paper high. Board and generation also kid free. Resource so indicate at yard maintain class.	Laptop	1	5
117	f	6618.84	Hard give eight make if side have face.	Thought that rise soldier over. Attorney population knowledge believe though parent tax explain. Rock treat then hard though high. Fast account north subject. Painting before side physical.	Vizio OLED H1	1	5
118	f	6061.35	Century what team with.	Late college animal likely. Onto serve action national message. Approach baby gun whatever participant grow name animal.	LG LFXS28968S	1	1
119	t	7596.34	Present chair Mr agent.	Material north almost or buy finish. Above try finish wall on president sing. Ahead itself guy soon space. Benefit guy trade heavy street per recently mind.	Chaco Z/2 Classic	75	4
120	t	5748.98	Sure long member between but. Structure agency must vote design seat five employee.	Sort another base. Billion plant six security. Plant police health admit trial. Hold bring already final.	Ecco Biom Fjuel	68	5
121	t	3187.22	Amount resource suddenly environment. Put purpose power capital.	Him involve institution morning. Trial take turn say southern. Health suffer public raise rich international. Trial guy we culture produce myself skill long. Mission strategy project quality brother respond.	Mizuno Wave Rider 24	30	2
122	f	4640.19	Phone interest million term quite include apply. Hospital herself fast work.	Occur establish later season great pressure cup. Accept structure night change major magazine cause. Dark western material thus number sort. Example serious walk too. Perhaps certain along people want. Discuss too training his will station weight center.	Birkenstock Zurich	1	5
123	t	2144.64	Leg agree glass difficult room exactly.	Again get whose stuff rule attorney hear old. Structure class floor certain step nice conference. Color rather data. Create while share. Four cell less gun number quality available focus. Movie financial economic join action general clearly.	iPhone 11	3	2
124	f	8119.00	Contain cold sometimes brother me national.	Risk play same could mission answer. Risk beautiful choose. Own my perhaps question lawyer born. Maintain approach note ready worker turn. Space impact expert cold now marriage talk.	Birkenstock Milano	1	2
125	f	8681.58	Send discuss charge red action their.	Issue certainly notice book run. Government evidence west paper read. Son home ok woman. Population attack specific already add plant. Hold court kind seek read whether moment wish. Truth ten ready that challenge consumer call force.	Vela	1	2
126	t	1206.92	Professor language class audience third product factor season.	Alone training time either. Position scene book son four. Wait purpose whole recently himself who. Board machine figure ok hand. Federal single market third face. Western south just prevent help apply painting store.	Reebok Club C 85	77	4
127	t	6422.82	Big relate media organization practice.	Amount lay power work thank. List public become pick study. But he hard always husband it star.	ASICS Gel-Nimbus 23	66	3
128	t	4339.25	Benefit main power make people plan.	Matter eat notice type appear room short. Rate building term election one show government. Spring analysis next center theory statement. Employee create miss national central may option. Professor nothing miss where east impact before. General indeed interesting education computer my technology list.	Crocs Classic Clog	37	3
129	f	7999.15	Hour decade politics of question. Century although why.	See term product stage behind future whole. Color institution whether dark type nearly. Us shake lose seven defense commercial land. Without Mrs trouble here trip. Television admit become bed fund. Join environmental computer magazine see short television.	Chaco Z/Cloud	1	5
130	t	1136.65	Fine situation race Republican.	Stock model take school election. Social yourself treat these training put positive. Attack work despite.	Xiaomi Mi 9T Pro	29	2
131	t	2948.11	Watch computer leave out sure reduce.	Sound not suggest. Democratic later air first head. Outside I black teach summer cause.	Sketchers Go Walk 5	0	4
132	f	4951.09	Congress foreign bad natural which network care. Bring culture question if.	Station feeling establish say. Idea bank wrong somebody answer trouble affect. Director movie military each data camera economy.	Toms Avalon	1	4
133	t	9766.01	Light culture carry pull cold clearly.	Level when rise together admit. Sport cause share stay coach. Today general sing kid game middle rise. Institution into relationship police. Decade moment meeting Democrat sell dark.	Xiaomi Poco F2 Pro	80	1
134	f	5708.31	Spring outside worry organization option ever note. Moment magazine factor standard.	Move material behavior medical drug ahead. Husband glass when should. Travel night player success trip energy win. Outside investment weight guy card ball.	OnePlus 9	1	1
135	t	2231.39	It bag actually any stuff list serious. Summer information threat.	Fight throughout he hundred. Never media short store television. Set with modern since firm. Civil truth who campaign. Challenge rich employee worker. Party choice poor long arm father note.	Reebok Nano X1	54	1
136	f	9048.49	Foreign plan ahead forget science page our. City present level could.	Technology according even audience sea hundred. Treatment PM mention during military race. Front threat themselves human government suffer skin memory. Ground seven commercial spend responsibility company strong. Almost house determine eat morning none. Reveal report affect bed plant me.	LG OLED C1	1	5
137	f	7092.57	Back picture herself new pick rate assume.	Serious development career look watch. Response green student evidence trade. Most firm that expert. Term animal around politics evening.	Cole Haan Grand Crosscourt	1	1
138	t	9775.90	Manager wish base open.	Four foreign option price but national image. Near pretty window two right. Thought inside argue painting. Be action maybe laugh low school bad. Because physical must popular hospital. Discussion on article grow.	Xiaomi Mi Note 10	7	4
139	t	6784.06	Including sort fast least away at pretty.	Deal let guess program fill. Artist wonder traditional near resource after race. Majority yard health once prepare. After win small. Everybody finish education attention heavy mind.	iPhone 13 Pro	58	2
140	f	8340.44	Response pretty physical guess long theory.	Girl compare back former Mr. Project his unit ability decision. Require either trip within. Machine keep least various check positive them. Woman behind phone six street character investment arrive. Investment next above include crime sort there.	Chaco Z/Volv	1	5
141	f	6428.25	Go include dark speak carry.	Wide agency such article cost pattern decide. Eight material talk weight. Physical action include pick tend very job. Rock brother politics gun amount. Expect bill between animal century.	OnePlus 7T	1	2
142	f	5603.97	Behavior we rather stage consider fact.	Executive know thus attention believe computer. Play coach black interest physical. Everyone public under nothing. Many situation along report.	OnePlus 8 Pro	1	1
143	t	6984.77	Answer stock change fine quickly. Figure debate his good.	Heavy sell send kid huge. Most special fight total eight. Such firm life including technology professor produce.	Maytag MVWB865GC	61	3
144	f	5170.83	Amount play story never success.	Physical edge participant seven four through list. Trouble exist particularly successful. Per about career indicate. City someone professional several American board gun. Their TV police degree on. Who move travel detail run interview space.	Espejo	1	5
145	t	7667.60	Well east north whatever game when listen keep. Religious almost bar traditional local door.	Blue light detail recent certainly yourself. Able affect tonight light. Major police peace seat total daughter. Social threat ever require however.	Sony Xperia 10 Plus	60	2
146	t	245.85	Sense history upon money relationship us policy. We do live together west make will.	Story break able year memory community join. Read clearly get once hold alone. Size Mr bill. Purpose almost media. Easy list day so least building office strong. Old former none dream leave authority so.	iPhone 6s	20	5
147	t	8855.77	Into occur themselves chance another.	Picture discover Mrs watch debate within benefit call. Fast lawyer end social friend indeed mission protect. Rich follow popular.	Sony Xperia XA2	93	5
148	f	9909.91	Final give authority here operation sign.	Environmental seek citizen stay treat per forget. Or usually general blood well no. Determine with live than leader wait for. Tend certain car say. Side key reveal. East store too part policy tell.	Google Pixel 2	1	3
149	f	3876.86	Example support financial employee possible.	Suggest Democrat product moment understand learn. Southern less herself protect suggest. Either against analysis. Its report number brother which age society.	Vionic Tide	1	2
150	t	8816.35	Red indicate audience world environmental road. Watch industry fast enter situation fall.	This throughout dream industry perhaps. Else much our suffer particular table. Visit act role million win finally enjoy provide.	TCL 6-Series R635	29	5
151	t	4304.46	Including quickly become those these.	Vote type customer each front others. Myself because back sign. Firm significant sea.	Huawei P40 Lite	86	1
152	f	8234.07	Republican left spring always.	Support concern another. Behind form then. Bank rather middle every her.	OnePlus 9	1	3
153	f	9119.53	Decision continue forget star fast economy it. Animal discover stand region board color question.	Attention government democratic dinner. No room traditional law trouble maintain fast. Turn often whose admit high.	Xiaomi Redmi Note 7	1	3
154	t	3267.66	Identify effect stock executive collection all.	Particular maybe stuff shoulder. Property partner reveal buy candidate send either. Space control every husband.	Xiaomi Redmi Note 9S	35	1
155	f	5454.03	Prove according store item tough. Available skin floor seem money pull recent third.	Assume development own outside. Short more late character. Agent consumer health big image scientist produce. Fight nice window very.	Xiaomi Redmi Note 7	1	3
156	t	4638.35	Season realize act any according number author.	Hope responsibility above agent whatever. Day beat able day career. Trip school above nearly she. Age lose long media. Require image into enter tonight. Political prepare production kid.	KitchenAid KRMF706ESS	31	4
157	t	4418.49	Physical financial attorney strong together prevent back individual. Thousand career performance hospital evening program mention.	Nor wish increase. Music fire think walk of minute amount. Cultural blue cost garden hit prove. Left exactly value throw dinner strategy lay store. His during not.	Brooks Ghost 13	55	3
158	t	1381.92	Building take spring short key argue light. Company anything out.	This education fire find race best need else. Guy dog account high somebody between product reason. Listen decade magazine population budget education. Boy discover animal sea I. Exactly worker blood design. Authority throughout station before herself official type.	Electrolux EFLS627UIW	49	4
159	f	9118.73	Send prevent mother which reach mind medical improve. New several little suffer everybody every management.	Clear analysis owner production million then. Wife sister small age common serious term color. Foreign year task whom rather speak. About eight glass family purpose can produce whether. Quality service rather wall character vote. Something senior seem region size.	Toms Alpargata	1	5
160	f	6042.84	Full run kid probably. Baby place too ground room ever management compare.	Worker evening soon health school same actually. Everything quite development thousand thank exactly window. There actually form heart public fight. Since deal affect. Democrat nothing door central whose.	LG WT7300CW	1	3
161	f	1157.97	Individual day ago yes station. Community attention consumer a operation around.	Subject catch age significant soldier purpose create. Page probably myself chance clearly. Available student party water.	Birkenstock Gizeh	1	1
162	f	980.14	Great about site. Four never eye approach.	His few wear according. Message religious simply. Alone onto condition off though catch entire. Recently home special year girl. Single blood task surface people success do. Year develop local why.	ASICS Gel-Nimbus 23	1	4
163	f	9955.07	Theory however region.	Maybe president whose whatever feel. For line prove suffer know job. Skin third civil action. Almost finish morning that. Son within usually water wish.	OnePlus 8 Pro	1	2
164	f	1086.99	Find difficult professional along everything. Win base film situation reveal.	Reduce consider account she. Story about situation the over eight spend song. Tough firm bag certainly. Vote yeah foreign but. Every certainly police can. Site service treat event structure.	Frigidaire FGHD2368TF	1	2
165	f	9460.41	Give probably after site a suddenly. Fast recently account operation discover.	Risk situation dream attack car kid. Hard together nor almost himself arm. Coach to moment price fight.	Maytag MRT118FFFH	1	3
166	f	8261.48	Exactly relate election history ago soon.	Of account wall hot. Despite treatment opportunity four key. College soon fight whole. Sign rich near.	Merrell Moab 2	1	3
167	f	6456.20	Defense language risk my.	Image wide point very line. Current just course write. Although feeling away commercial.	Huawei Mate 10 Pro	1	2
168	t	4953.14	Resource control imagine past. Short both small reach training technology.	Person right picture. Pick data reality today piece. Film news outside item carry. Sport eat million child purpose. Tv hot machine position. Book serve on course about.	GE GTW720BPNDG	19	4
169	t	4327.07	Window somebody over without big smile whether. Name before support rich recently deal.	Too conference both each. Already American nation reality collection again. Baby hot little society example. Want character five sing item director professional. Strong care field month off safe. Bill wind same information have into group.	UGG Ansley	38	5
170	f	1546.98	Budget direction across foreign scientist rate.	Place happen environmental officer pay them lawyer become. Their cut impact with. Five south audience bed pretty daughter relationship. Suddenly buy majority cover interesting. Level determine pull the might.	Samsung Galaxy Note 20 Ultra	1	3
171	f	3456.03	Past stock recognize position.	Out talk listen beat whole body. Board say purpose crime. Go nothing every least some support. Majority order or finally. Beat few above vote choose follow.	Columbia Redmond V2	1	4
172	f	2517.02	Hit quite economy represent. Cut instead management enough party face respond place.	Check bring media little television too discuss. Tough follow drug. Notice day still themselves rise. Take add civil production reveal live several. Himself billion follow worry. Fear result fish decide four from.	Fila Ray Tracer	1	5
173	t	1663.34	Measure safe agent have concern tend. Society first these mouth teacher statement.	Night necessary either artist. Save site traditional. Later mind leg second. Those well owner address example your upon.	Bolso	36	2
174	t	9841.45	Course film get herself somebody.	Big peace scientist offer ability. Assume success something table believe pattern include message. Participant expect serious alone raise father training cup.	Puma Cali	34	1
175	f	3676.77	Indicate wish positive lose discover always out appear.	Which tree resource since chair. Crime whose develop leg. City population including accept result act.	OnePlus One	1	2
176	t	1588.06	American shake hotel.	Economy skill play base challenge involve. Fire increase theory public none wonder. Price environment man official bed. Later cultural impact theory. Focus could forget.	Paraguas	74	5
177	t	2737.00	Ability across century ability season military.	High security camera radio up law. Policy best several station. Bed rise success. Tell send likely page speech single the.	iPhone 6s	38	5
178	t	6266.12	Over mother clear anything. Learn over eight bad in.	Professional he light challenge decide bag order. Bit on subject business outside rock area. Company enough hospital degree firm hope brother weight. Believe black result and. Wife ability least often fill exist. His travel onto piece store development.	Lápiz	34	4
179	t	2936.83	Open assume spend activity face learn company. Crime partner fill measure arrive.	Republican may bill describe college power police him. A commercial right detail concern check. Woman dream require property. Contain whom return involve imagine hotel avoid. Talk carry course hotel and page federal.	Xiaomi Mi 10	58	4
180	f	6235.42	Firm dog let like. Stay north player soldier trouble ahead test sell.	Bad begin cut. Name manager value decision politics. Black else than former return southern.	Amana NTW4516FW	1	3
181	f	2796.36	Power rate player recently policy. Big city treat must base.	Letter clear history address station get. Pm officer book system. He test magazine. Prove traditional already world compare according decision early. Produce true wear Mrs account main. Growth once stage easy statement spring.	Google Pixel 3 XL	1	3
182	t	3369.60	There local poor cup.	Strategy company past kitchen throughout eye. Movement water put where production. Media hot year statement director able.	Cepillo	91	4
183	t	1533.71	Ever upon control cell approach.	Whole there no white what. Whatever allow current soldier draw. Example artist sense serious. Maintain boy nothing either career. Cup current painting glass yard.	OnePlus 6T	9	1
184	f	4504.68	System attack poor garden water memory.	Level decision one experience take police. Bed clearly friend organization. Long fight rather. That opportunity film student. Card loss score might early.	Xiaomi Mi 9T Pro	1	3
185	t	499.94	Interesting my minute voice through once record.	Bag gas sort parent far. Go gun economic physical. Though soldier seek tax democratic pretty type. Community actually rule scientist often once box.	Vans Sk8-Hi	62	3
186	t	5515.05	Democratic between marriage main green statement weight. Field where thousand interview decide the.	Clearly low total star billion agreement. Raise open southern. Road food child today. Nor few bad might leader control.	Philips OLED 805	24	3
187	f	6059.78	Young early sometimes country across citizen shoulder.	Way other nothing situation. Arrive low best action TV entire budget. Letter bad they these base. Easy method perhaps agree I.	Amana NTW4516FW	1	4
188	f	1679.79	Spend future adult should. Degree character break step bar heavy glass project.	A garden whatever law executive. Old unit bill radio yeah. Make sort develop thought community. Prevent reach seat. Science top through family tell suffer.	Samsung RS27T5200SR	1	2
189	t	3759.11	Radio data fight government fast interesting. Arrive record add past lawyer discover war find.	Head I at body message save camera. See as certainly. Hear rather available after. Discuss want close present I big beat. Push performance never compare. Majority radio teach while call spend ok.	Birkenstock Zurich	9	1
190	f	1747.47	Plant toward everyone relationship. Live add deep fear concern medical type.	Human anyone assume music. Find fact body report girl rule. Send since including sea TV reason management. Forward meet travel ok region wrong. Full doctor class one what.	Samsung Galaxy A52	1	3
191	f	3783.17	Strategy time provide.	Single scene business institution. Prevent most yeah season also mention cut. By doctor cell fly.	Hoka One One Clifton 7	1	3
192	t	7082.53	Relate thing special reality serious attention.	Power skill anything world your others. Finally news office nor worry every. White spring contain or meet provide smile. New market hand man with. Third resource machine almost. Later church yes magazine.	Skechers Go Run	98	2
193	f	8843.23	Either yard situation sport lawyer.	Office wide worry. Dog by such sense push. Very leader rich fill. Arrive industry citizen west happen somebody hospital. Alone if law reduce. Green energy land station majority standard push.	Teva Tirra	1	2
194	f	6801.89	Our mission industry pick risk. Modern discover enter determine story.	Like radio particularly kid lawyer growth him mouth. Create skin sell probably thought me would. Whole authority public break. Set information several sport above say.	OnePlus 9 Pro	1	1
195	t	6273.46	Heart during poor government career.	Crime check doctor start. Policy free television fast question. Interesting must question step laugh reason relationship. To six walk. Agree know teach beautiful human. Guess past reveal road form less sense.	Pelota	58	2
196	t	9724.00	Democratic last single benefit firm feeling debate.	Require article listen edge. Energy they difference seven year. Whether vote soon shoulder particularly learn. Visit Mr rate. Eight everything continue run message go assume.	Columbia Newton Ridge Plus Waterproof Amped	82	3
197	f	2472.55	Senior enjoy rock poor public.	Whether but claim boy. Central toward feel step citizen coach happy water. Friend particularly quickly. The modern study occur. Cost best learn stand something rich center. Record customer very company.	Samsung Galaxy Note 8	1	2
198	f	598.31	Buy sort personal increase.	Red prevent road lay let account lot. Very change form exactly side local newspaper. Where move speech claim value increase. Standard enjoy play as next medical develop really. Nothing usually any concern.	Birkenstock Milano	1	5
199	f	5601.21	Sense action join. Baby environment live say once middle he.	Loss yourself loss music. Father hundred use his camera including direction. Sister order now will. Any another activity thing. Reality site sport others mission down fill tell. Pm tree century side computer.	Samsung DV42H5000EW	1	1
200	t	6482.21	Particularly mean amount stage anything. Her government walk traditional attention concern blood.	Here want project last catch. Technology along beautiful leg institution. Technology purpose still social expect. His car new.	Sanuk Yoga Mat	28	3
201	f	2352.00	Agent nothing early major second military.	Position also religious send glass traditional unit. Both throw than animal structure this community. The onto full medical local use.	LG NanoCell 90	1	5
202	f	8790.48	Spend with growth wall.	Somebody strong plan information but. The method every little run. Him chance enjoy anyone tonight argue.	iPhone 6	1	2
203	f	2942.66	Arrive just also or beyond sometimes single. Child huge recognize seem authority adult.	On trouble with source price mean. Eye election amount from. Blue use unit what four money read. Pattern notice international whatever. Third issue lead impact seat authority nature.	Google Pixel 6	1	5
204	f	1096.10	Something piece material be send science. Go else soldier why most great side.	Bed end explain several attorney single. Need or name option mean. Enter face east wife current down. Since reason option him six travel. Skill nice blue stock fund.	Birkenstock Zurich	1	5
205	t	1511.81	Could central past people both.	Work chair statement so pull. Agent our reach mission party clear great. Out fall difference. Agree TV to create each several market. Thank start there everybody individual surface.	UGG Ansley	1	2
206	f	9089.17	Gun owner image know eat stay.	Amount for medical military eat customer teacher. According natural find. Away employee one. Generation professor age. Admit yard worry factor million common feel. About whom at her safe election image.	Skechers Ultra Flex	1	4
207	f	9317.70	Similar government join mind garden boy. Level media beyond sign serious suffer.	City building term make. Call from hear partner reveal. All cup human serious pick difficult.	OnePlus 3	1	1
208	t	8359.03	Involve if list grow rock. Important note three paper interest manager score.	Degree response on fire forward. Speak involve spring throughout professor. Make one car house speak.	Huawei Mate 20 Pro	76	1
209	f	1040.66	Ball media loss. Me attorney thing song if technology.	Available term account bank PM month write. Add energy somebody member audience by age theory. Protect factor east. Different serious music degree expert music.	Dr. Martens 1460	1	3
210	f	5669.35	Continue easy very for alone hot trade concern. Bar form face hear.	Science later place arm. Seem wish social. Similar up adult capital. Once world hear join human staff rule smile. Thing may crime left American save. Some natural me campaign.	Reebok Classic Leather	1	1
211	f	987.57	Put bill organization positive would phone company.	Include reality shake close conference really whether. Player everyone half although federal seat among. Behind cold deep gun reality pressure. Mrs adult wind however up. Scientist gas sure boy dark food much.	Columbia Redmond V2	1	4
212	t	4380.18	Realize soldier own single office prepare.	Argue despite wife act. Pm reveal collection sell guy recognize. Treat feeling bit particular institution cold. Could skill beautiful ago effect.	UGG Dakota	43	4
213	t	2888.12	Record idea need fire what other give rise.	Daughter pick call our step brother. So above far their camera effect subject own. Benefit music main foreign just.	Converse Chuck Taylor All Star	85	2
214	t	2355.20	Bed most staff often along commercial. Worry position power herself.	Bring along machine south no wish war. He ready will feel third store. Mission raise college best task pressure. Prepare put partner new direction hour. Total another reveal you simple design.	Cámara	18	4
215	t	9888.64	Decade financial key evening act history.	Tax culture everyone school. Garden take prepare check themselves either use four. Later simply summer should without. Paper into whatever American.	Puma RS-X	83	2
216	f	4242.57	Beyond follow son year man lead.	Full public eat bring firm least. Mother must total deep. People blue administration over picture traditional. Today him democratic age wear. Seem field history. Let fund arrive bag.	Huawei Nova 5T	1	1
217	t	6239.94	Short daughter wall lot many available someone.	Own to police pull main. Campaign report much. Herself also four story they.	Mizuno Wave Horizon 5	13	2
218	f	7748.35	Itself will deep job up. Plant a generation into.	Describe half who wonder spend list. Kid administration Mrs director free. Money body teacher class name sometimes usually agency. Factor word see article teach them. Sort building world.	Xiaomi Redmi Note 8 Pro	1	3
219	t	4641.17	Hope decade board board truth lead.	Low religious consumer paper word. Result minute certainly detail make. Wait night race. Actually newspaper half step drop. Soon drive describe catch without risk.	UGG Dakota	64	5
220	f	5372.35	Image practice represent consumer.	If material within. Firm size push account environment challenge go both. Address wait explain. Head ever do agency pretty.	Maytag MVWB865GC	1	4
221	t	6097.72	Brother fine store surface community. Sign home himself thus.	Around decide boy top debate whose through themselves. Reflect age others population until first. Song book take room song manager. General add final travel. Form something never car field him food idea. Ask for check maybe environment nor information.	Libro	77	1
222	f	813.31	Word area police important hard hit.	Player century book southern approach herself development. During blood camera show information sing. Apply author draw institution. Wait of series experience whether per. Smile yes under drug parent girl green suggest. North establish but four.	Dr. Martens 2976 Chelsea Boot	1	1
223	f	9552.88	Couple owner its information western. Data may reality.	Deep price yeah practice. Act end live several. Pattern mention when.	Teva Tirra	1	1
224	t	4382.64	Still change training many.	Feeling who professional box address owner light. Compare pass lay fact administration. As feeling person easy mouth piece step. Eight benefit nothing bring pull movie again.	Cámara	24	5
225	f	2450.11	Against run attorney debate resource thought.	Control matter buy kitchen maybe life. Foot the stand cover. Night news view claim yourself.	Skechers Ultra Flex	1	2
226	f	5718.62	Whole economy marriage until tax enough wear. Important board act mind team expect.	Type anyone evening safe avoid. Speech gas hope bag free only section Mr. Bed response could future spend.	Toms Avalon	1	5
227	t	4008.73	Manager improve woman way. Book process partner pass.	Ok really treat choice rise military economy. Company task brother half. Forward message personal letter person. Act need drive decide whatever authority. Door early wear. Religious style song financial.	Xiaomi Mi 11	28	3
228	f	8751.27	Cultural important analysis answer. Conference item assume kid music old.	Me store continue carry yard operation. Assume between their. Science wear wind matter. Decade family sound choice source. While guy talk fear coach.	Sony Bravia XR A90J	1	2
229	f	9243.72	Seem consumer age business watch community deep. Time condition increase evidence.	Vote sell ok time. Want together pay truth dream society program. Hour environment that everything art. Between east make summer million.	Cepillo	1	5
230	t	3224.67	Your article tell.	Peace fill reach employee. Participant teach lose send bag. Base successful thing attorney particularly stay without.	Xiaomi Poco X3	39	1
231	f	8495.55	Provide along source.	Beyond decade our environmental. Rest art trial draw believe national world town. Author here here red every. Black both herself American majority husband girl. Little could dream style leave learn size. Production land both knowledge tend.	Samsung Galaxy S9+	1	1
232	t	2382.08	Full chance back far issue. Maybe others painting tax.	During move no edge. Particularly conference break source. Type your community bring you customer.	Bufanda	94	3
233	f	9184.34	Painting fall increase will physical school loss. The fund offer without may.	Leave series activity piece interest. Financial article report. Sit mind cold rest on. Way keep much pretty ahead science. Point rise likely main company must.	Samsung Galaxy A52	1	5
234	f	2263.84	Quality senior nothing media control everything song will. Sell bit almost.	Thus interest fly page dinner above four. Available spring choose commercial nation. Join ten add evening charge necessary. Authority score growth rich less. Media save five impact. Establish student alone may reality.	Samsung Galaxy S21	1	5
235	t	1682.84	On industry follow hot. Agreement clearly artist finish note what edge.	Nor sister plant. These guess hot mouth. And recognize tonight force deal board attention. Yourself lose nature rich three lawyer outside. Possible expert shoulder east avoid. Effect truth build nothing.	Reebok Classic Leather	3	2
236	f	2005.20	Prove instead majority edge. Chair community case simple.	Organization professor occur on population. Career child list. Claim whom campaign baby speak staff realize.	Vans Sk8-Hi	1	3
237	f	3153.76	Oil police leg. Camera religious which stuff.	Beyond simple draw boy. New more dog these. Perhaps alone must maybe. Provide quickly entire fund. Later fact goal sure.	Cole Haan Zerogrand	1	2
238	f	69.84	Bit simple side sort improve war.	You buy majority watch. Forward house go decide lose beat time. Young us conference. Throw heavy any color heavy local. Special through hospital north. Set radio go sit very what.	Cámara	1	3
239	t	4578.30	Next land ready. Approach will great trip upon best stay.	Employee seek happy decide challenge that. Window simple home next if market business. Name list guess truth up your put agency. Out defense end serious really meet. Finish technology seek agree. Lawyer home where difficult clear baby why.	OnePlus 7T Pro	76	4
240	f	8851.03	Hit ahead student hear today fire especially.	Big series executive attack. Prepare reveal wind red box pay speech. All at often fast.	Bosch SHPM65W55N	1	2
241	f	764.88	Difference hair threat teacher artist stay.	Development arm participant raise technology. Rate new town certainly we cover culture. Water drug here great nature respond structure defense.	LG WT7300CW	1	1
242	f	8054.50	Him public same very.	Study positive can own arrive major happen. Pm century news staff sister professional letter friend. Plan tell special skill sign late involve. Watch report week line fish coach.	Huawei Mate 20 Pro	1	2
243	f	3237.18	Onto she before reality do language get.	Find party serve certainly peace despite laugh. Raise lawyer head himself. Animal run international writer feeling with.	ASICS Gel-Nimbus 23	1	2
244	t	7717.58	Month side office democratic term boy pattern effect. Sport painting type try record anyone.	Could however third production set fish boy. Sit choice heart also crime expert. Rich attack not pull.	Sanuk Yoga Mat	57	1
245	f	4357.24	Season positive people partner possible professor.	Old many every through job authority. Voice yourself generation main while. Talk meeting wrong really wrong exist.	Nike Air Max 90	1	5
246	t	7402.15	Player PM consider four tonight. Fine approach low those.	Especially star upon garden assume including bill these. Design religious others top commercial employee use. Factor entire imagine only society thank later. Eat school speak. Budget customer avoid range American quality how soon. Point table small student his decade personal company.	Samsung Galaxy S10e	65	2
247	f	9028.26	Young stay behavior why single while.	Stand not various discuss figure. Citizen scene to against expect according. Nation need everybody able pay necessary character mouth.	Huawei P40 Pro	1	4
248	f	8036.92	Among everything soon space.	Would trip worry involve office environment. Light price low stock common. Single agreement anyone where mission unit amount. Knowledge about know nice describe beat drive. Memory scientist management son.	Fila Disruptor	1	5
249	t	3485.79	Dream consumer camera southern really give special.	Exactly if western for miss quality. Matter purpose likely interest oil book learn. Animal miss sit save. These operation remember rule society have international.	Bosch SHPM78W55N	60	2
250	t	6713.53	Wear chair dream politics writer.	Growth do practice economic time at option. Success material professional card. Either great project. Experience chance early political. Year itself choose.	Libro	94	1
251	t	9366.56	Minute machine crime approach employee. Million instead off skin.	Star however figure address. Defense serve more central performance stage million. Note room well rate difference. Off finally magazine clear subject score local. Little television surface drive church. Nearly town group serve.	Cepillo de dientes	65	1
252	f	4619.87	Hold window gun affect protect everybody scene. Song identify treatment father drive consumer note.	Ground both form president business vote. Be five away American story. Collection look mean head we. Sea imagine third top again speak. Safe news family beat beat while majority indeed.	Ecco Soft 7	1	2
253	t	4355.56	Air social window pattern. Shake some million south.	Kid thousand store technology too. Across claim turn two doctor job clear. Official so goal. Remember next husband too want. Agreement necessary both second increase. Interview article that town compare company.	Puma RS-X	34	3
254	f	5329.82	Order experience stand teacher allow. Off break name break reveal indicate site.	House modern common know. Whose grow computer maintain cell on. Contain increase really pattern. Spring east cause hard in hope management. Treatment these toward interesting.	Adidas Superstar	1	1
255	t	6370.05	Idea appear capital.	Difficult identify Republican traditional there worker reveal. Laugh phone option term sense race year. Same almost same parent environmental. Back ability outside do.	Columbia Redmond V2	36	2
256	t	7316.67	Magazine thank key put. Account spring begin agency standard above protect.	Station indeed significant player difference. Send yeah actually. Senior the film. Our each if smile than billion her. Attorney here clear rate direction seat goal.	iPhone 6s	7	5
257	t	8939.66	Human report recent ever scientist million particularly.	Their again state. Until magazine soon. Process air someone design year door structure total. Arrive join record down. Media claim road positive assume others.	Fila Disruptor	46	2
258	f	7833.08	Wind at front million mind information. Million so offer world oil want coach.	Relate parent policy article computer improve. Family deep black population go significant end. That head best want compare ok. Fall could old from.	Cepillo de dientes	1	1
259	f	1671.51	Usually show suffer moment field.	About stay language show whether property check. Dark perform all thank group. Only reality responsibility exactly happy military. Face modern late after know weight focus.	Dr. Martens 2976 Chelsea Boot	1	2
260	f	727.46	Generation authority perhaps inside suddenly. Scene major give painting member ever spend.	Involve appear note number. Run while American reflect sign serve. Cost serious school floor candidate her foreign letter. Beautiful similar civil. Will prepare hope task. Magazine century region talk.	Bufanda	1	2
261	f	4970.02	Top join close. Statement study tell.	Professional reflect role research expect soon. Officer always few indicate policy truth. Specific real form get yeah form. Structure safe believe dinner mouth why. Budget ground tell risk hair plan. Strategy some soon prepare.	Vans Authentic	1	3
262	f	9370.91	Work air join bit she future visit.	Avoid seek despite evening and. Ahead beat major reach process really seven. Quite painting both camera.	Samsung Galaxy S10	1	2
263	f	8707.23	Anyone marriage half light.	Action prove offer hundred community involve travel. Agreement down assume money. Actually something company save. Company project bank interesting begin challenge say.	Electrolux EFME627UTT	1	4
264	t	1041.17	West since hospital soldier various maybe.	Issue rich quality letter. Agree voice father. Cup table radio natural dog can.	Bosch SHPM65W55N	7	5
265	t	9264.90	President personal quickly manager issue happy. Wind keep coach such such.	Player test three material. Because usually audience western police. Wide hundred seven. Deal defense opportunity. Do way positive explain against give call.	Dr. Martens 1461	17	4
266	t	6387.46	Whatever machine reason. Question soldier road box spring might take response.	Wear about building consumer record everybody along. Official executive four who expect. Activity medical consider oil third thing different business. Assume bit reveal quality.	Converse Chuck Taylor All Star High Top	66	4
267	t	8131.21	Paper consider owner lot room least choose action. Office many black note method us.	Air talk someone town stand everyone way style. Property boy subject somebody either end high. Site camera capital sign. Matter strategy show. Current dark keep strong instead. Quite with continue.	Xiaomi Redmi Note 9S	60	2
268	f	2864.56	Loss west discover whatever too.	Better fly market analysis. Area room serve Democrat do several. You lot piece same prevent guess wait. Participant as real will. Method party bad few pass. Thousand deal college over.	OnePlus 6T	1	4
269	f	252.25	Short reason store foot.	Provide similar billion start. Fund wish book wall he themselves. Across time suddenly move practice population couple. Point peace he enjoy yet have. Learn resource couple identify bill person. Word candidate cup head gun economic election.	Converse Chuck Taylor All Star High Top	1	3
270	f	4176.68	Trip ability believe many nearly tend. Claim board anything sing source.	Product building anything see. With western speak somebody father would ever event. Sit southern so especially. Instead explain yeah member speak simple seek. Write sometimes people matter amount social soldier play. Wrong social level allow once bed commercial physical.	Samsung Galaxy A51	1	5
271	t	6923.24	Reality drug community evidence operation.	Building red tend able left factor kid. Boy use seat old bed employee shoulder. War record brother individual modern toward charge. He consumer nothing organization maintain.	iPhone XR	94	1
272	f	1547.22	Law whose man.	Wrong such guess their country true him. Risk although short month occur ground. Then include allow before visit similar. Thought artist fall energy. Value exactly hour. Exist animal their wait production.	iPhone SE (2020)	1	2
273	t	9036.96	Position themselves decision professor fund school great. Protect effect rather write south brother.	Home finally trip despite place. Laugh close beyond team house college present. Still down economic other rather value. Answer concern wide thus group. Behind economy than couple cost evidence large.	Sony Xperia XZ1	88	2
274	t	68.56	Lawyer early direction available evidence do.	Large song out second goal why rock. What contain small effort ability never operation. Doctor TV low exist. Deep into next. Challenge up group opportunity personal.	Converse Chuck Taylor All Star High Top	72	3
275	f	9128.73	Father base network seven relationship. Goal material doctor.	Business focus play baby Mrs particular news peace. Into father his significant color least forward. Author person resource effect Mrs main south. Hit detail story buy dinner material.	Crocs Bistro	1	5
276	t	4099.32	Every memory bed table model.	Card gas experience fire. Interest you meeting threat seat. During hot get hand media indicate mention. Next third space exist green.	Samsung Galaxy Note 9	40	5
277	t	5932.42	Fine scientist Republican animal.	Discussion over toward. Foreign drive write reveal fast we. International though coach onto. Situation job until job building. Economic line traditional hit push sense age. Society energy single.	Taza	56	1
278	f	1110.11	Environmental technology radio.	Style gas member again. Continue girl stay trade opportunity. Impact drug consider right. Sign value pass walk piece nation. Much much school. Return player reach create tonight dinner find production.	Huawei Nova 5T	1	4
279	f	3744.65	Form hundred ready one eat building clearly. Natural fire very store four.	Draw list late until style dinner. Performance everything very role. Now manage be spend goal degree knowledge.	Vans Authentic	1	2
280	f	3849.01	Item pattern represent a forward.	Cultural subject leader. South others all bank. Including walk camera all. Pick heart keep leader draw level necessary.	Silla	1	3
281	f	6252.84	Church here future anything threat people. Former election matter program answer.	Or less society rock who court. Walk me middle site street. When investment society remain look.	Converse Chuck Taylor All Star High Top	1	4
282	f	8618.25	Key international defense can anyone describe responsibility. Mention pass television performance think issue position.	Case poor political relate force care listen. Perform human agency. Probably career the we. Do media including sea usually win book. Improve edge attack easy federal door. New suddenly law thus movement ago.	Sony Xperia XZ	1	3
283	t	5420.11	Seek store let from approach.	Law bed behavior step. Per group film. Fast thank medical occur. Game story everybody. Audience against vote particularly visit others third.	Panasonic HZ2000	6	2
284	t	9503.10	Property building design size capital beat record consider.	Push threat letter participant. Your leader exist down. Former claim fish understand. City expect technology look. Because room indeed get. The why if employee wall culture pay.	Reebok Nano X1	10	4
285	f	7712.61	Test try step religious recently question little sometimes. Speak ago subject know approach performance.	Take tree everyone home. Hope describe guy people including none himself just. Project response laugh. Want do popular street defense.	Samsung Galaxy Note 8	1	4
286	t	4327.43	I capital describe partner. Itself brother site quite.	Yet moment oil difficult before gun chair. Fly light federal international and different. Nation actually within available stock. Our third effort fill serve. Hospital analysis area bed need safe. Hotel let give radio.	OnePlus 9 Pro	16	3
287	t	1258.50	Property answer factor score live happy government. Bad though however American tax.	Anyone weight address. Government table second indicate toward job child. Involve case car strong. Approach report mother agent despite. Message lay item body.	Xiaomi Mi 9	4	2
288	t	8018.35	Prevent radio skin after computer into audience home.	Write foot explain your resource seat. Suggest customer oil above include discussion. Network player may there detail great police. Keep hope they north former institution.	OnePlus 8	35	4
289	f	6215.05	Because market when because age theory drug. Writer field everybody recognize for me.	Detail page study station bar seven. Evidence information each decide loss able fact. Radio relationship factor break memory probably wide.	Under Armour HOVR Phantom	1	4
290	f	6919.47	Structure full level today. Help list what market.	School out tree ability exactly bad often. Very course system buy culture than. Either effort guess either step buy adult.	Whirlpool WRF555SDHV	1	3
291	t	4136.46	All sure music effort almost. Against clearly candidate town future sister leave discuss.	Or local American check within right mother. Democrat very prevent social dream glass. Cold first act site house. Quality TV analysis commercial cover personal.	Sony Xperia XZ3	33	5
292	t	1348.86	Morning sometimes others.	Century adult nice year. Camera wait least on just eye billion. Establish bad voice we. Like occur black likely chance matter. Throughout six several morning war attack modern.	Samsung Galaxy S9	8	2
293	f	6149.97	Not generation despite measure participant director from. Tell series heavy son seat environment.	It public recently quite. Skin common site stock. Laugh exactly seven program just state evening.	Salomon XA Pro 3D V8	1	1
294	f	752.76	Now American personal. Someone thing trade.	Choice pay quite more player short. Doctor voice father travel. Position station specific age should face morning though. Exist skill often fire.	Birkenstock Mayari	1	2
295	f	3173.80	By figure pick feeling least economy close. Check her newspaper should room letter true.	Stuff stock season room use rock explain. Lay call parent half. Mouth perform explain spring.	Birkenstock Gizeh	1	4
296	f	2691.02	Require set magazine fill.	Whether land instead three future. Resource them star choose government. Whatever business member language scene friend become guess. Carry song prepare. There western knowledge industry.	Dr. Martens 1460	1	4
297	f	3682.62	Democrat entire pattern security traditional. Likely concern fact most.	Determine spring government minute democratic. Degree former fire camera film heavy. Tonight trip stop ago. Medical focus person often wide car. Same sure good economy foot student couple station.	Xiaomi Mi 9	1	3
298	f	1525.23	Budget focus production situation image choice. Between alone standard difference indeed.	Campaign here write whole opportunity sometimes either. Quite throw music short story responsibility. What before full eye level wish senior.	Panasonic HZ2000	1	3
299	t	5060.00	Book town blue. Call attack quality key yes decide.	Free information left. Collection option his drop source surface edge. Produce trouble soldier least.	OnePlus 7T	44	1
300	f	8062.77	Three yes west total. Article product accept white.	Travel in despite role voice tough public. Next good something certainly. Magazine president his help smile choose source. Specific begin answer may star pressure.	Huawei Mate 10 Pro	1	1
301	f	19530.00	Lámpara de escritorio	Lámpara de escritorio moderna con base de madera	Lámpara de escritorio	20	4
302	t	519999.99	Samsung Galaxy S23 Fe 256gb 8gb Ram Negro	Procesador y memoria RAM de 8 GB, alcanzará un alto rendimiento con gran velocidad y memoria interna de 256 GB.	Samsung Galaxy S23 Fe	50	5
303	f	30990.00	Mesa auxiliar	Mesa auxiliar redonda de metal con acabado dorado	Mesa auxiliar dorada	2	3
304	t	569999.99	Notebook Ryzen 7 Asus Vivobook Amd 512gb Ssd 16gb Ram	ASUS VivoBook 15 39,6 cm (15.6") Full HD AMD Ryzen 7 5800H 16 GB DDR4-SDRAM 512 GB SSD Wi-Fi 6E (802.11ax) Windows 11 Home Quiet Blue	Notebook Ryzen 7 Asus Vivobook	10	4
305	t	259999.00	Smart TV LG Smart TV 43ur8750 	Televisor LED WebOS  de 44 pulgadas con resolución 4K UHD 220V	Smart TV LG Smart TV 43ur8750	5	5
306	f	45000.00	Silla de comedor	Silla de comedor moderna y ergonómica	Silla de comedor ergonómica	4	3
307	f	60500.00	Mesa de centro	Mesa de centro de madera maciza con cajones de almacenamiento	Mesa de centro moderna	1	4
308	t	28999.00	Parlante Philco Djp10p Portátil Con Bluetooth 220v	Altavoz Bluetooth portátil con batería de larga duración	Parlante Philco Djp10p	40	4
309	f	30000.00	Auriculares inalámbricos	Auriculares inalámbricos con cancelación de ruido	AirPods Pro 2da Generación	1	5
310	t	13999.99	Reloj Unisex Gadnic Alarma Cronometro Elegante Digital Color de la malla Negro	Reloj de pulsera resistente al agua con malla negra	Reloj Unisex Gadnic	30	5
\.


--
-- Data for Name: producto_categoria; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.producto_categoria (producto, categoria) FROM stdin;
301	5
301	22
301	9
302	1
302	16
303	5
303	11
303	22
304	1
304	16
305	20
305	16
305	2
306	1
306	10
306	16
307	11
307	5
308	11
308	5
308	22
308	9
309	16
309	1
310	16
310	1
11	1
12	3
13	1
14	5
15	1
16	1
17	1
18	15
19	5
20	1
21	1
22	1
23	21
24	5
25	1
26	3
27	1
28	3
29	3
30	3
31	2
32	11
33	3
34	1
35	1
36	1
37	51
38	1
39	3
40	1
41	10
42	11
43	11
44	3
45	3
46	3
47	1
48	1
49	3
50	2
51	1
52	1
53	1
54	5
55	31
56	7
57	16
58	3
59	3
60	27
61	16
62	38
63	14
64	3
65	10
66	22
67	27
68	10
69	10
70	9
71	3
72	31
73	21
74	11
75	20
76	1
77	57
78	16
79	27
80	16
81	3
82	10
83	1
84	1
85	1
86	7
87	16
88	10
89	3
90	3
91	7
92	10
93	1
94	9
95	7
96	7
97	1
98	1
99	3
100	27
101	1
102	1
103	1
104	1
105	1
106	21
107	33
108	1
109	7
110	1
111	16
112	3
113	2
114	1
115	1
116	16
117	1
118	16
119	16
120	1
121	3
122	16
123	16
124	16
125	7
126	16
127	10
128	21
129	7
130	27
131	27
132	3
133	1
134	3
135	22
136	3
137	7
138	3
139	7
140	1
141	3
142	3
143	1
144	1
145	1
146	10
147	3
148	1
149	1
150	3
151	1
152	1
153	10
154	5
155	1
156	1
157	1
158	1
159	3
160	10
161	1
162	16
163	1
164	1
165	16
166	21
167	7
168	10
169	3
170	10
171	3
172	7
173	1
174	21
175	21
176	51
177	1
178	10
179	2
180	1
181	3
182	3
183	2
184	3
185	1
186	7
187	1
188	9
189	1
190	21
191	1
192	5
193	1
194	1
195	3
196	16
197	21
198	10
199	3
200	1
201	3
202	7
203	7
204	1
205	8
206	7
207	1
208	3
209	10
210	3
211	10
212	1
213	1
214	3
215	2
216	7
217	1
218	1
219	3
220	3
221	33
222	2
223	2
224	26
225	3
226	1
227	3
228	1
229	2
230	10
231	9
232	2
233	7
234	26
235	3
236	3
237	1
238	16
239	5
240	16
241	1
242	8
243	1
244	1
245	3
246	3
247	3
248	26
249	1
250	21
251	16
252	1
253	3
254	2
255	3
256	1
257	1
258	3
259	21
260	9
\.


--
-- Data for Name: resenia; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.resenia (id_resenia, resenia_producto, calificacion, producto) FROM stdin;
1	Store yes travel company. Price movement paper near leave story ok. Cost gas owner. Choose plan level today respond feel. Your send give trip black.	2	39
2	Factor as task democratic land music great. Drop able forward director benefit government. Couple environment pressure miss manager. Significant camera road indeed seem statement child. Science allow middle under fine southern your. Rock never matter join family stage.	5	165
3	Walk during section data service. Total indeed power how. Board make inside just together we. Forward remain month Democrat.	2	105
4	Participant position west we Democrat against however. Remember current reach energy. Include foreign energy suffer program stay. Sign former generation.	1	290
5	Skill prevent choose style say. Father partner door talk lot admit start. Heavy either develop popular purpose Mr social. Single thing situation per there.	5	46
6	More despite ok early nothing. Door edge certain challenge. Thing worry sure home nice four. Instead audience realize its. Move house stop hotel few machine training.	4	114
7	Produce kind institution tough. Instead poor three this peace factor new. Different turn quickly pretty. Us source something far boy. Measure finish cold as red trade.	5	183
8	Particular black parent much listen road room. Wrong fear reveal toward himself. Feel apply million.	4	259
9	Money under suddenly laugh join item. Offer pick trade voice again capital. Race instead bag current must happy.	2	55
10	Remain never entire society. Account peace pay popular goal financial. Skin manager physical lay it reveal. Manage with born page stand share yes.	1	269
11	Ever money begin turn. Education although method. Military even baby physical environmental per.	3	110
12	Artist brother old development information job tree. Human reflect answer research piece. It law since deal create gun rise. Appear worker power drive project. Star participant friend difference finally. Age ground the fire hotel.	4	115
13	Including collection instead culture international the mind. View agent suffer develop. Maintain town machine produce. Later relationship social night.	4	40
14	Hard state finally ready practice pass. Indicate security enough individual light near. Say pay film campaign conference. Social sea rule nation community outside certain. Must station decide hot although.	1	29
15	Best even risk cultural. Start including ask similar everything very recently. Hope simple Democrat own current. Sea teach chance. Article high hotel deal play free.	4	127
16	Last argue land attack production whether moment itself. Office entire table make fine just why. Might just science. Often effort collection adult through food.	4	94
17	Forget customer within set. Medical piece various hard present. Both hot mention myself.	3	179
18	Arm most but myself bar mouth suggest. Herself modern wide recognize radio. Off time political writer indicate opportunity. Nice man always stage. Continue without end heart them.	2	147
19	Very current wish fine money PM. Happy read describe rich. Audience good always war. Ready try discussion discuss office gun.	4	164
20	Interview good thousand. Another environment section study. You finally position box more cup old. Family crime certainly measure before. Research doctor wind report song Mr. Give affect education when beyond almost occur guess.	4	114
21	Religious bring on nice six debate. Where line really bill scene. Able him follow expert effect mention. Morning future understand candidate.	1	253
22	Away society scene against customer. Note give common about. Unit nation eat live. Whom serious bad full people whole. Candidate growth suggest listen onto page cover when.	2	188
23	Name wind sense choice. Professor him happy recently city. Senior building beautiful necessary without outside win.	4	142
24	Test short yes. Action finally participant gas sure through add. Involve meeting more fill approach. New mind enter without. Interest by western thing.	2	290
25	Major TV decade along play. Fish role fish institution senior. Think society minute trial force. Grow draw above down significant late alone true.	2	109
26	Skin machine week he for. Environmental ball spring Congress one. Practice seem week interview by. Traditional down write indicate certainly same seat.	4	106
27	School indeed nice. Scene list tonight job. Century investment price wind gun stay father. Mrs sport degree create lead really.	1	280
28	Wait carry write everybody catch. Late direction dinner arrive entire key. Year what interest official interesting test.	2	166
29	Economic left animal thought marriage out. Themselves study agreement bar by store. Growth score produce head writer involve. Vote determine travel. Improve effect star machine.	4	71
30	Something necessary as mind strong scene. White but meeting follow pick shake. Tax nearly remember just finally very guess. Half organization organization scientist civil first music summer. Toward yeah fill top high. Deal throughout wide knowledge various.	2	181
31	Attorney crime instead this. Believe certain yes cause research citizen later view. Nature door again soon traditional. Road specific sing ready attack article key. Else close step ball well number. Have summer base determine have.	1	188
32	Responsibility really nor more. General return conference so home town. Various benefit history development letter away build.	1	34
33	Close score number college them your question. Recognize attorney around news. Nearly step keep pick enough nice he.	1	111
34	Six cup history father technology head. Machine hand organization eight magazine chance. Present radio white your budget public already door. Discuss them many gas gun program.	2	290
35	Small career choose realize girl range. Economic realize together former. City every stock raise behind like. Turn produce poor media they. Sign herself water foreign list. Son car federal defense one.	4	264
36	Door main drop cold. Anything firm image. Someone would meeting hair.	5	153
37	Red serve detail range that region avoid pick. Husband mother number group. Whom certainly life old lay do. Wait over also attack half action.	4	1
38	Main exactly weight me. Bad space write learn. Week everybody significant somebody reason. Why very opportunity time trip.	5	90
39	Score late make. Federal statement two Mrs per fine. Its late positive everything computer blood. May person as situation. Finish house long pressure.	5	23
40	Development TV tree deal business brother all. There nation establish bad few prepare agree. Something however off score end keep. National protect guy bar ability. Season majority final reveal.	5	171
41	Determine finish board onto ball. By during cold policy right. Interesting moment system leg those carry spring scientist. Need drug head blue rock.	2	252
42	Western vote you artist party popular want. Put year officer help law business sea customer. Citizen yet pattern few face possible ask. Page American father thought others behavior. Draw long spring whatever land stay firm what.	1	200
43	Painting exactly modern education and without responsibility. Police Democrat dream huge bag. Small particular have material kind. Service either boy may black church.	2	285
44	Past center training less realize door while. Three note send weight word everybody front. Carry worker bit travel yourself event surface.	2	213
45	Catch thought security close that fund space. Cultural clearly floor include. Mean hot year ten article. Notice out likely author. Despite maybe later quickly tend yeah.	1	232
46	Per place series even. Through whatever probably about particularly left above. Whole record maybe simply wear good. Exactly nature feel kind one particularly. True until no beyond discuss prove. Enough once agent will computer.	2	81
47	Go site never pick view identify. Training arm health five pattern standard artist. Wonder form can town though base continue. Dark act perform girl during artist seven onto.	5	163
48	Population half town difficult. By movie foreign. Eight pull music but. Clear note safe hand support official. College but think such Congress.	1	64
49	Those job glass discover. Stuff play whom. New around son keep film yeah near. Drive rock economic. Expect style sometimes act degree. Like for free you foreign.	4	277
50	Fear course weight pressure walk. Cell push machine however stock short buy. Run improve anyone evidence. As job yeah suddenly matter act serve lay. Get probably where candidate region situation. Now wrong by research care.	5	171
51	Space bit which idea person. Court investment store. Worker budget since official low. Draw page current decide person. Wait car north far already wait technology.	2	289
52	Including someone never. Idea glass material at administration him college. Wrong officer special. Learn less direction place field.	4	137
53	Argue rise cover dream sell. Several explain hit population style subject no real. Far mission control stop because. Green hold explain. Enter say miss water democratic room idea.	3	236
54	Blue high type structure TV. Get consider school price. Defense young explain sport send party father.	2	2
55	Gas explain spend economy they inside computer. Born relationship court arrive many whatever the. Personal someone key foreign peace left. Skin second again.	3	173
56	Media base not. Necessary walk model level. Case win challenge wait girl edge force. Hotel page teacher do cover.	2	26
57	Realize list view section. Number side stuff either customer. Minute house also tend. Have yes they happen box against. Bill though begin paper. Town leg window side.	1	174
58	Camera billion Republican rate often myself. Meeting day gas relate. Offer until treatment. Chance method build. Mother beyond image plant administration in treatment. Away after across.	2	270
59	Determine rich response company. Military case four from modern receive different. Early work son smile detail bed. Mouth eight moment table.	4	111
60	Lead when form require rich stock. Account piece agent. Stock responsibility away class have you trial wear. There should risk over. Much either program commercial seek security watch. Be try everyone chance like.	4	68
61	Sport husband stand media interview relate. Sense Mr great reflect none hear news lot. Staff avoid fly people.	3	79
62	Result section enough check huge magazine. Mr rest Congress high situation civil notice. Local matter TV court child difference reach trip. Through plant environmental blood why. Home wide half control gas ever.	1	277
63	Yeah trip nation real player smile. Seek draw body physical back. Remain dog after science teacher.	2	260
64	Ball personal fly foot feel thus cut. Although style light. Democratic coach treat company clear.	1	161
65	Catch yet source attorney in poor idea create. American page fall result with bring. Option trial water consumer whole believe six. The nor chance quickly possible authority involve.	5	84
66	Give air bad. Argue friend their bad action onto. Technology much method billion business side inside. Increase happy cultural focus painting. Town thing high. Home soon close others many across mission property.	4	201
67	Another economy to bag remember federal research never. Land sea player everything region offer economic. Particularly word must company relationship need. Under next particular kitchen she. Simply whole pressure window team.	3	112
68	National account notice management. Debate political guy young value else point. Energy behavior system particular compare chance. Senior service phone although clear fly not. Stock structure themselves yourself. Public consumer much.	1	267
69	Between including evidence water. Exactly according home audience travel floor. Child still government like. Employee style by talk case law. Together responsibility personal more agency run.	1	56
70	Appear own paper order view form. Keep whether single million herself soon knowledge. Anyone wait coach discussion class. Security assume little might suggest alone word. Day leg best including gas find nice. While add peace letter goal.	3	61
71	Save want nation watch knowledge. Finish write never whatever pass five stuff serve. Future training very near other.	3	201
72	Green whether during several. Investment development account. Rise she result both.	4	219
73	Believe or head and poor student wall. Consumer teacher economic billion allow. When star opportunity bar offer many news. Less cell car local.	3	294
74	Amount sign recent relationship send guess at we. Space young unit would him none. Break here type tough interest newspaper enough. Arm purpose use need possible read.	1	208
75	Increase door wait. Bed course support energy wonder. Recently either PM majority book character. Senior street reason big marriage.	1	227
76	American south project type four need. Cause four administration environment look production build serious. Sound debate forward place. Year test increase.	2	238
77	Garden knowledge serve. Act position consider control personal. Agreement again American federal financial although.	4	130
78	Laugh in meet plant about guy scene each. Open American word it add race. Save such since bit. Mind measure sound my data actually. Thus short shoulder want western. Sport she various much.	4	74
79	Education realize in outside any expect wall else. Tell each who vote dog draw run. Message understand together administration wrong. During require whole eight. Mission day piece black everyone if campaign. Beyond today fine baby.	2	132
80	Plan range middle place like. Trouble system security ability. Establish join interest system staff military Mrs.	4	109
81	Reality travel about guy along player include. Sing single chair put owner stay culture. Month style science environmental better space require. While approach work environmental describe. Project fund often. Detail organization attack finish.	2	285
82	Understand though apply thank off culture. Suffer positive real then. Serious write herself effort plant bill standard.	1	230
83	Treat stop war a article energy unit. Three its college dream drug center body. Whether marriage sign say pretty. Grow prove condition civil fish sell contain. Loss season together speak president realize. Fact itself agency down.	3	132
84	Their it east. Politics property into step. Page thought determine bring power image feel various.	3	31
85	Management floor professor explain writer expect should personal. Able today thus quickly season. Individual rule story popular. Fight popular suggest speak. Sea likely born front outside protect issue TV. Within property lead none sense look.	5	92
86	Travel on campaign fine. Fly purpose rise generation. Performance step truth computer side tell decision company. House animal seek draw others for. Image dream skin.	1	124
87	Chance theory million less soon. Chance piece white many whatever consumer month. Different natural treat Mrs nor hundred. Fear how director because. Property court entire star. Subject contain sense unit lose.	2	26
88	Head parent score race bar capital. Material film give there show special recently. Carry degree meet energy. Exactly choice once push piece ball what discuss. Age career international truth sometimes.	3	217
89	War own beautiful environmental something bill. Indicate hold throughout sister activity hospital. Peace who make safe teacher discuss example. Southern man structure discover build. Human in economic century follow should town.	3	213
90	Air or southern health network. Way song goal interview investment natural reach. Push return firm easy board training exactly catch. Light cup kind yet. Successful with mention sport throughout matter.	4	246
91	Experience most phone especially industry he sometimes. Clearly age international already sing wear wind rather. Ahead even knowledge arrive huge however.	4	15
92	Wonder stuff bill student side event environment. Same own democratic mission. Power them arm main true child. Politics walk better base dog suffer thank law.	4	252
93	Security boy century begin Democrat. Maintain affect without source. Know start its environment gun offer. Plan cover idea economy.	4	10
94	Strong structure although spend commercial leave note. Read local on close product travel matter. Different in charge fly. Account ten discuss shoulder dog card memory. Can eye wide decade new skin eat. Memory anyone century enough parent nature.	2	133
95	Life next write require address. Raise these value prove never upon. Interesting form away moment medical star. Society physical authority you I. Rest war bad picture end successful.	1	10
96	Game sort organization begin particular eye. Store those seat of movie as laugh. Oil politics science different. Network prepare budget Congress indeed. Green audience whose election party. Police they under table.	5	147
97	Magazine by require. Hour difficult dinner. Hand series recent benefit single hotel key. Feeling history ok region. Federal modern rather skin many where contain trouble.	5	234
98	Against finish hundred suggest act mean recently. Huge position lot term. Nature fine couple worry significant full.	4	206
99	Turn technology political call Mr know idea. Else place professional speak cause seven or. Whole each visit subject free out. Officer material eye training. Relationship despite nation. Improve range size.	1	216
100	Nor be wonder security success drug he. Matter cold even. Nation traditional level unit. Reduce street them never. Trial bad such occur. Actually prove event matter again option partner.	3	14
101	Specific real whole suggest. All ahead class case. Senior respond mind. Meeting only activity name according kind beyond production. Technology my age who why Republican.	1	11
102	State message various over town idea. Southern once support remember herself. Appear never international present. Throw training establish future thought quickly. President camera specific join her.	3	204
103	Weight mission beyond as gun somebody. Situation with why why clearly in. Watch draw think science.	1	69
104	Population inside similar today experience green. Bill see investment sense situation certainly especially. Speak sense modern work responsibility try old. Turn what support heavy reason. Should short stand yet sister eat.	1	60
105	Firm wear form century along street. Remember science body ok wish Republican story. Keep artist fall build eight.	2	178
106	Would catch color plant. Cut PM training area significant every almost. Pick collection force also water military. Machine soon billion fill customer bring. Science project country inside.	2	14
107	Particular person seat song health suddenly. Us drug discover discuss story class or. Upon system issue month stay international agency. Friend offer standard effort also pass involve.	1	70
108	While understand thus investment nothing clear current different. Message world ago plant poor pressure return. Among site strong dog local evening notice past. Health continue until career affect. Goal somebody send station coach your unit guess. May ok but answer fear later pick.	2	227
109	Fish security develop give will current sport. Yeah anyone how without example. Particularly star turn drug leave month cup. Drive author cultural defense form near off. Long raise buy start month run turn. Forget ask cover may find group medical.	5	141
110	Study practice debate check. Worry bag door large back. Money situation fear view. Style draw past answer.	5	213
111	Start surface dinner why. Simply him first particular far. Set few world billion on others provide. Indeed Mr rock there role first budget. Check plant member. Role Republican a between agency.	4	116
112	Big south enough billion bit. Six painting what news. With write few level may issue. Four hotel force science.	1	11
113	Purpose effort figure. Data yeah politics happen thousand fund kind. Project mother thousand behavior everybody fire weight blue. Performance I Democrat section.	4	196
114	Community subject so service least young. Finally information civil over edge financial who. Affect different own sell class small Mr. Face family media. Use and compare material space.	3	164
115	Have score gun worry economy bad. Available range week individual open drive. Charge physical sing admit. Democratic executive military activity must represent. Parent meeting lead professional reality lose.	4	44
116	It question term book develop weight board wife. Fish expect within politics. Rather serious special. Whom surface data check person thing.	3	235
117	Defense industry there theory. Man care computer write admit. City from bag report international indicate.	2	158
118	Process offer exactly air growth. Race total pass put. Realize protect letter pattern throw not large. Human yet pass major agree.	5	57
119	Stage now around adult actually kid respond. Friend movement fly coach. State finally store factor draw foot. Wife exist specific. So conference enjoy necessary. Prevent drive peace image.	1	292
120	Officer who around nice task. Source establish peace go. Least song represent real believe field yet. Value plan base wide popular few rather could.	2	64
121	Party parent though wait unit discover boy. Those bar name notice government up no. Other charge yard business you sister sort.	5	280
122	Direction very plant ok amount. Above data wife born. According green risk forward off. Happy research look parent cold. Onto along particularly art partner.	4	28
123	Conference cup white western growth. Join perhaps address her increase foot former. Cover care maybe health medical without who need. He government experience watch bank art. Century school American hope per provide. Put pattern fly scientist since.	2	272
124	Amount change everyone behind interesting. Able during physical after employee friend car. Government according member draw. Build firm light manager learn actually explain.	3	299
125	Section chance executive pass third. Peace little plan nearly with. Everybody data nor value. Paper blue make bring thing. Main about television style. South avoid down together.	1	264
126	Station account style citizen. Start particular must message Congress system stuff. Life dream artist. Court attention college much from. Practice environmental size make memory image particular.	1	185
127	Customer suffer perhaps evidence. Many goal so trial interview. Per hold lead manage discussion exactly beat learn. Moment beat senior game.	1	224
128	Option suggest reveal. They direction issue between guess. American keep government area continue maybe. Look begin sell only. Recent build southern receive raise up. Age green author generation radio fine.	4	11
129	Place stand almost ever which dark happy. And year book town. Spring identify draw fall prepare factor. Tax experience ball best often mouth. Bank structure hard.	3	222
130	Bad with if baby market car. Three great from free early. Last discuss edge report. Clearly thousand service study idea situation. Happy important away. Perhaps more still offer source.	3	254
131	Along our scientist south feel up model. Top close marriage property available bank establish. Good behavior however paper still artist thought. High build citizen carry half. Fish fine eye success.	5	142
132	Song cover matter. Anyone go couple community reflect. Few stop nearly should thank.	1	105
133	Issue pull about. Around radio opportunity local. Manager along small green employee personal crime particularly.	1	149
134	Public view strategy party actually. Feel one family. Treatment in public most gun. Difficult certain bill spend. Lawyer shoulder another year line. Citizen agreement owner other sure within matter.	4	101
135	Service rise eye bit. Between quite their arrive the top have certain. Determine make see health.	5	195
136	Coach choose really total. Without worry book reflect system. Claim research food growth everybody provide follow.	2	142
137	Mission color writer future probably building near. Parent note democratic pick state. Better sing well according not civil attention live. Open traditional article senior. Side political husband want do other approach. Customer measure star effort Mr wait prepare.	5	4
138	Stock toward seat point. Music war save else everything food ok. Great watch fish billion. Send throughout decision lay. Whom child person society century meeting. Including represent red very local upon.	1	99
139	Second daughter involve back senior. Coach crime trip interview appear standard lawyer probably. Citizen pick respond upon. Watch above everybody alone reveal government. Buy important pass fire open study.	1	298
140	Half story last kid water some writer. Avoid from seat world most. Suddenly pick exactly.	1	289
141	Trial call hold choose. Stand really one training court business. Position red ago sign why. Off respond receive practice world community.	2	33
142	Answer body painting dark war item list. Ability car network into kid let. Wall operation whom service. Federal this kid leader hold. Theory establish knowledge move chance risk. Everything team ahead gas society.	1	73
143	Feel behind ready challenge. Do happy bad cut foreign manager card. Forget early effect different full. Major most administration among my analysis enough.	3	263
144	Nearly sort much energy. Certain card wall final every smile parent. Full always own home.	5	151
145	Right phone full wear. Party view while growth. Although woman performance increase current product fast imagine. Major fire wall. Door best toward guess business political system. Difficult traditional particular nor month I.	2	70
146	Such coach season enough medical travel single. Still buy main international boy analysis trouble. Stuff food dream meet arrive simple tax.	2	26
147	West poor south show scientist let throw. Company look bad. By behind anything keep manage. Focus cup significant represent respond fall. Country oil southern trial work somebody. Page major red sell if.	3	288
148	Friend matter over gun effort. Condition left responsibility popular physical. Give rich miss trade. Then decade American some guess according. Wait could report.	5	100
149	Bar nice cut into share rock. Garden wide sometimes later anyone manage traditional. Set still bar against husband can. Apply line should born heart listen their. Century away the full production require move deep.	2	48
150	Picture walk most shake. Herself low agent record last. Painting pattern second the then language general. Kind eye character draw film late letter. Financial use final write memory top.	2	161
151	Surface agency affect cover. Local account laugh western yeah security affect. East plan assume. Ability trouble see everybody political major. Morning amount their value.	1	83
152	Food off traditional include paper study those skin. Design between create. College buy total remember five former evidence old. Recent them carry everything. Attorney discover yourself situation among alone assume.	5	276
153	Economic stock large senior history. Few doctor four sign stand or page. Former picture large.	2	234
154	View hear owner main put subject admit standard. Move must nice whether gas. Either special dog player base piece. Series network before single bed bag hundred manager.	4	69
155	Administration black what everyone result name once police. Tough month decision writer alone tell color. You memory them. Money so wind apply seem.	1	249
156	Area kitchen expert give. Road out Congress. Instead huge scene. Challenge century when window detail run.	3	268
157	Process traditional visit agent officer degree. Effort defense agency commercial brother interesting. Wear watch serious save medical glass. Choose will war everybody wait possible end. Again house either live car. Out could heavy dream.	2	194
158	Member item campaign model truth personal. Mrs must exist rather. Pick wear audience lawyer wide. Whom cover tree employee at center. Sister arrive style. Or recent care car teach concern.	2	157
159	Later mention visit. Act management claim section and draw left. Fall resource cold difficult. Strong show enough plant much however by. Economic garden identify material stand spend. Before responsibility director care available politics year color.	2	256
160	Theory control hot few. Today development PM church expert. View boy suggest order. Plan speech a commercial school above. Grow continue page its agent card.	1	5
161	Use perhaps white case season indeed. Too determine reveal agree fight. May whether born Mrs food these structure. Analysis once more face. Citizen choose then environmental nearly. Involve boy only paper high investment.	5	219
162	Social relate ability whole. Kitchen place herself international lot security daughter. Television huge behavior nothing language. Action impact anything require article treat.	5	145
163	Start protect actually probably. Truth hair stuff visit. Reason account recognize because.	1	176
164	Fall record prevent box over early. Method drop reduce subject true data oil. Success often smile close think. Think democratic decision according so allow. Practice read lead cup since citizen. Push share already whose. Buy cup act either dinner although.	5	292
165	Pm yet west senior ahead mention health. Eye protect each computer name never chance north. Plant plant finally interest. Simply article coach heart remain keep town. Music thought follow difference edge though charge. Environmental bed central trial.	3	120
166	Pm agency act figure fund. For adult try. A raise political inside southern generation center. Left red concern office. Much scene less include. Near discussion itself certainly pull.	2	48
167	Own authority name always suggest husband across type. Him rather rest site series. Pass tree yes technology authority. Send cost seem interview. Yourself painting actually majority us.	5	291
168	Behind red else he seem continue. Character meeting card truth article face. Into than choose whatever across report. Discuss foreign I voice.	4	111
169	During leave several yes. Sign on white yeah. Military skill relate left candidate may claim. Own health five quality fly stop where. My front animal individual. Help left religious garden help form daughter rule.	5	62
170	Quality fight describe time these. Walk sense task loss. Hit star pretty will treatment spring. Project put soon issue.	1	190
171	Board film either. Produce fish and assume affect recognize rule. Leader as young job western voice dinner. Wear trip street. Water alone source but catch space study.	4	156
172	Action professional lay task successful man blood. Area continue your land. Social whose road approach board stay. Although vote too sport theory offer. Force feeling each trip write. Force throughout cell kid whatever bill.	1	30
173	Eye live view dog well. Year also sister hair idea. Camera hit include action year whether population side.	4	105
174	Pretty information foot around. Reduce certainly throughout group nearly actually player. World condition describe suffer the old. Unit firm these forget contain statement gas. People fly in mouth week.	5	57
175	Expect again last room appear. Walk lay writer alone deep provide week. There attorney need something first miss. Generation once son doctor three enjoy perhaps. Rise anyone stage floor blue.	1	53
176	Conference nice tend as smile feel. Start move ok able story left strategy issue. Third yard low represent world service tree itself.	3	166
177	Pattern then service simply to their how. Item along I business. Sort for election. Class show director area conference argue. Event control his sound beat. Huge customer environmental glass crime minute budget operation.	5	94
178	Imagine voice film discover create likely. City live avoid including until. Forward expert tell strategy mean fire sometimes. Then happy compare bed.	2	288
179	Call nature amount edge. Ability kitchen early continue wife. Move five learn performance memory stay seat.	3	26
180	Offer student commercial nature. Player decade probably she even. Nice push reveal visit indicate example across. Citizen paper fly next. Green through instead force get.	3	28
181	Space participant really strategy civil order church. Place street blue PM personal. Response research spring third occur. Organization if social article.	1	247
182	Together thought into least. Hold their open owner participant size. Item certain attack sign. Economy peace hit base.	4	109
183	College house sound state page seem. Offer different son idea day. Sport opportunity feel Democrat management wear forget. Moment picture movement back trouble well state. Discover first theory picture political back.	5	231
184	Job want soldier pattern. Everybody lay economic culture peace campaign charge. Real soldier politics account population make.	2	284
185	Into discuss future firm know. Plant political including upon down image civil. Happen energy sell manager according main.	2	268
186	Put quickly woman trade. Evening control agree their unit kind remain. Step whose traditional become trip thousand. Experience instead stage man. Point simple note suffer because. With value interview investment.	1	180
187	Near finally scene country. Woman collection middle. Player population agent avoid important. Finally see listen social cost doctor. Glass anything whole final artist alone.	4	70
188	Play long across throw leader college Republican. Their find company throw. Head artist alone only rule. Yard buy page.	1	237
189	View whom choose control close similar. Mind along cup. Claim something level above reason cup.	5	188
190	Amount wife born once never nation. Line reason consider event important grow phone control. Its work role identify ground cover. Speech remain recently join success shake. Sell let standard simple.	3	101
191	Economy whatever little window this structure. Through write tonight serve class agree clearly. Forward second family wind property community. Worry into television grow. Stuff travel floor ever question remember.	3	118
192	Purpose boy option letter pull his question show. Without perform treat idea walk language information. Avoid case forget clear peace.	1	220
193	Morning practice natural guess young develop. Lead worker technology risk. Bring one officer which nor. World instead choose among. Phone author professor thought effort similar. Evening population record rate.	5	45
194	Small street pressure want. Investment few surface imagine attention nor. Though although about budget charge happy. Your under idea action hold ago capital. Because know reduce. Dog ten face manager.	3	33
195	None few interview tend foreign. Its how senior attack. Bill election adult. Win student soon office politics discuss record training.	5	78
196	Chair its reason record. I more player executive girl public. Letter group hear as teacher several.	1	169
197	Try food her wrong school draw fish. Tax call growth however training eat coach. No forget computer respond none month national. Keep maybe message interesting wish.	1	32
198	Standard buy piece much happy. Best year arm attention. Put address boy recently common east. Deep may staff nice affect important team. End business peace tell group become.	2	44
199	Buy seat always also. Point today focus trip rule why. Practice here fast. Partner religious such guy. Letter even anything water everything professor. Red example water effort sign and.	1	117
200	Paper event method put identify yeah also. Record he whole table occur certain happen. New without night Mr century medical. Western father join decision edge.	3	29
201	Trouble tax determine this speech various. My rich campaign owner modern democratic teacher. Address TV improve identify coach yourself different. Reach see design possible.	4	49
202	Team citizen but establish consider. Page purpose feeling young ever relationship. However share international coach. Information article wide matter sell hotel. Sense country deep now physical participant true.	3	269
203	Forward more beautiful sound. Heart drive rate then. Practice political computer fine box argue. Theory no keep tell drop dinner herself. West occur spring training exist expect little.	1	56
204	Like benefit less program month full like. Adult admit walk direction hear trial provide. Argue bad above create idea imagine against. Should health pay which care no.	4	165
205	Quite society American realize. Answer democratic Republican science. Drop stop finish fear. Market green idea board teach step take. News local trade skin development civil. Decide morning strong admit.	5	196
206	Stage put gas. Own find born student heavy performance. Idea tend serve last his.	2	162
207	Consider about he although. Series floor why look responsibility those history. Entire near nor determine product. Well key understand strategy not total.	3	52
208	Long article magazine wide ago instead. Investment wish model finally. Fly effect find born. Again particular among away close.	3	22
209	To peace organization baby season effort particularly thank. Find return create evidence term culture many. Military director certain wait year mention example. Style hope particular strategy sort. Dinner same reflect medical end woman.	5	27
210	Foot voice city cup point carry performance give. Since develop space they for under plan. Reduce than step yourself fire. Vote thank nice cell hospital painting so. Century fear forget body treatment. Similar same college positive.	2	255
211	Family in security although. Contain these coach day provide. Mrs discussion student. Meet seek financial research position.	3	236
212	Play road exactly clearly star strong. Item assume buy ability cell. Give conference trade short make indeed economic. If coach foot conference create measure. Suffer audience agent list million wife foreign.	2	213
213	Large where rock behavior current necessary. Travel certain matter people quality meet wind. White change morning law where.	5	104
214	Concern travel quite base walk. Discover seem discover whether admit. Tree argue these even rise long. Picture carry exist big write include.	5	258
215	That defense everybody break yeah. Heavy account traditional office role. Near whether memory continue sense story. Administration news draw late picture. Various during tell raise. World month bag service century writer.	2	288
216	Away small sign section summer animal. Allow crime watch view hard specific. Front talk relate huge specific.	1	270
217	Stuff soldier front shoulder road. Rest individual push sure late. Economy gas hour special consider population fill left. Camera green popular involve serve himself message. Reduce pretty view adult lay these. Assume note give pretty whole.	3	26
218	Opportunity quickly attorney operation up imagine. Approach at something color reason foreign spring. Community watch evening event civil situation go.	2	193
219	Crime he ever effect be ago. Because group free already. Number run win.	3	21
220	Imagine perhaps until sister miss watch even. Too spend value budget field only toward light. Service main able talk.	3	19
221	Center join office study. Reality remain so college building everything. Long movement own smile score.	1	101
222	Mission lawyer serious finish life theory value. Treat plant program simple truth close position. Half recognize pay. Yes improve look father father among. Tax black middle pressure risk for trade. Beautiful organization field space choose.	2	235
223	Court strategy few. System cultural how main appear. Child add fall question. Beyond ability employee available young player. Ok middle official rather especially bag foot.	4	200
224	Benefit former instead result hundred perhaps series. Happy land act lot really wife carry than. If relationship finish offer water. Themselves ready little best. Watch budget direction set plant suddenly.	3	221
225	Down want lay election movement federal suddenly. Live hard national change year health. Response large own rate throughout skin.	4	99
226	Guess account nearly early far voice. Whether wish one sense serve. Minute threat consider strategy television value major. Sing actually so. Pm natural phone stop. Environmental lay against carry.	5	294
227	Her break special seek lawyer set part. Significant treat store film build. Wrong admit human make identify.	5	79
228	Then operation physical collection. Artist can science adult ask area marriage cultural. Upon phone policy table later. Sign fact firm loss. Concern cost than feel door agency let. Heart air likely party should if million.	1	140
229	Especially voice trial off. Understand perform opportunity maybe source six consider. Yard up woman effect tell think. Effect finally win left assume material since.	1	25
230	Him tough cell bar movie. Draw finally Mr rise relationship safe. Cup kind later her as character education. Likely senior wear represent. Responsibility class we computer image any individual.	4	25
231	Order argue measure knowledge. Theory often although practice himself candidate. Sister buy government responsibility something speak. Edge sea third daughter ok. Scene talk training in guy.	2	140
232	Full age price. Statement available choose force build value evidence mind. Hotel increase important. Pass campaign eat clearly improve house star door. Employee land painting show dinner see size experience.	1	228
233	Despite strong true region hard performance treatment. Message dream end pass. Republican movie friend question ok. Suffer hair image opportunity into. Bad phone wall hold stand. Economic piece shoulder amount feeling interest writer it.	3	254
234	Better raise last. Kind down doctor eye answer. Science consider what peace. Boy anyone strategy political. Together he hand character house.	1	243
235	School up beat everybody four music return. Skin affect gas before anything environmental. Material within opportunity build cost never pass. Decade several wear.	2	52
236	Fight dream method place. Outside style financial add education artist. Newspaper business mean need old collection. Across kind meet half employee ever many.	1	160
237	Project strong reach. Accept item news. Item collection couple surface.	1	37
238	Situation as answer ago race program season. Approach cause network guess decide why. Stage important blue whom.	5	106
239	International through before. Mention relationship product value still better effect. Magazine high practice while worry scene opportunity adult. Hot very end should move. Former beyond light organization check mean seek.	5	92
240	Truth activity though popular. We good business Congress positive state social. Budget even join likely both wide the hospital. History shoulder including let serve because by. Today customer scientist prepare. Provide feeling little history commercial least recognize wonder.	2	55
241	Pay staff attack human campaign include. Bring recent specific happy court brother. Eight teach those character significant risk point middle. Usually lawyer bar.	5	32
242	Read professor true then. Compare ball allow share environment mind. Pay article space issue people window system. Relationship north continue enjoy.	2	231
243	Deep run southern natural have. Rule election sound be not. Method issue card wrong visit girl but. Once heart large no specific I establish. Particularly himself offer west surface television hundred.	2	204
244	Sign actually teacher very foreign. Control than community dog matter with matter. Huge president truth allow around structure including report.	5	148
245	Sense short fight would student different. Seek spend today throw difference. Health answer know reduce manager federal trade feel. Congress response several personal whether.	3	148
246	Foot point beautiful while. View possible born behind memory could official. Girl reveal camera class reality two return.	1	282
247	Follow feel American matter check yeah attorney. Environment body degree window report radio doctor for. Keep different political company pull shake event it. Care professor agreement citizen land. Country region wish throw officer must. Strategy model increase year.	2	45
248	Unit recently meeting leave. Although energy create plan name. Clear half born around rule between final.	1	137
249	Prevent lawyer wonder. Water so court next hear. Price evening camera onto campaign.	1	23
250	Second with poor. Answer spring dog including look. Bar campaign serve choose require. Traditional position stock lawyer world political. Member edge cover everything yard major water lot. Popular manage mission positive.	1	50
251	Write tax doctor increase radio whether race. Major official special. Professional air laugh hour west later because.	1	219
252	Author probably want manage seat stay Mr pretty. Theory eye personal image statement office back whole. Number friend subject of peace.	4	222
253	Decide long check over no specific give order. Property experience outside rise. Management range five country laugh sing. Traditional another community which.	1	61
254	Stay create them old she. Agency play technology possible capital. Young establish then consumer. Music large care concern own long. To physical fight travel member group oil. Community land American strong policy set who.	3	196
255	Hospital foreign prepare operation. Change dog land successful. School send never lot field must. Sound respond table music agreement chair law.	4	16
256	Pattern eye street interesting industry recently tell. I chance half those. Likely beyond add statement. Early finally word finally including thing. Power pull daughter main. Represent however report event production expect executive politics.	5	19
257	Building test budget young. Since dream under then pretty society write. President oil me data industry everyone politics.	3	150
258	Court make myself age. Good south officer reveal key drive eye. Can once not project sometimes scientist skin. Teacher reflect walk commercial visit better.	3	289
259	Third around develop opportunity specific subject situation. Daughter democratic wife fear part up. Middle skin attention democratic. Respond nature administration loss child style. Throw when find although political.	2	264
260	Company hold deal. Require similar by certainly nor west sure. Choose business walk thousand about.	4	184
261	Network source short every. Paper Republican believe husband collection. Natural final although generation even. Suddenly discuss discover.	5	2
262	Away country although clear certain term usually value. Include well leg evening tough push. Usually dark recently increase natural audience. Discussion forget large hard book. Glass point meeting fly control recently send. Similar realize sport.	2	126
263	Station deal poor. Cultural position goal security something industry outside. Response behavior growth free local look work.	5	14
264	Learn compare well team. Reality language series base nothing thing. Happen democratic change poor authority free do. Energy hand book free quality.	4	246
265	Involve allow force chance two. Trial tell party arm radio mind market career. Floor study gas.	5	192
266	Most as people small opportunity. Service red operation. Performance mean partner scene. Dinner ever among help. Can color degree instead owner will represent technology. Drug pull poor determine.	4	64
267	Bar determine wide real. Wind shake answer ready recent own. Short grow board oil. Be say develop wrong.	2	167
268	Cut rather manage consider. Race gas administration push want. Identify policy while few seven nothing.	5	248
269	Forward why fear century south here. Each focus what. Age where assume he reason ago. Life reflect instead center because later federal continue.	2	23
270	Already easy sing building. Age save certain discuss. Whatever effort light management enjoy. See for city meet ago. White ten measure long.	3	128
271	Show special real once writer well. Tend coach yes beyond provide. Short that brother baby scene almost stage against. Computer glass official wide message responsibility serious. Just seat agreement risk.	3	125
272	Drop within partner know each ever. Teacher court let camera agent you card. Available walk interesting.	3	288
273	Head stop among prepare rate trouble early. Training response subject above. Few painting common. Marriage process policy design.	3	267
274	Important management push size throughout style. Floor close authority few. Sign dog what never. Rise at clearly close generation mother already. Rest song officer other model decision.	3	106
275	Support listen door one these note. Reveal method material consumer. Professional win structure article.	1	261
276	Democratic thus gas people laugh eat central. Between sign identify test. Budget federal few southern argue by relate source. Entire politics establish treatment shake sign. Want reflect focus heavy size power short loss.	2	42
277	Test enough send once organization final. Small every wear also despite. Tonight follow public. Gas choose own state record. West radio far discover laugh onto always. Onto skill key ask service child.	3	184
278	Character age head believe there right soldier popular. Relationship plan himself decade suddenly their. By truth point hold. Worry occur own describe.	5	10
279	Include beat exist chair doctor. World focus ask list. Method Republican professor senior material firm. Measure build personal source far. There until pretty eight. Day while who lot together often field.	2	52
280	State capital trouble. From finish media when stay significant view. Evidence through fact bank contain party stuff. Necessary woman might. Shake card memory always.	1	66
281	Available often subject middle manage performance lose design. Couple both public heavy itself far because. Attorney place toward action truth appear. Kind interest fear week power. Bank major program much feel common. But professional wear crime ago.	4	128
282	Executive but same some. Learn yard present cause wonder. That grow give task chance man identify. Later go but college group wide.	5	287
283	On teach west challenge. To term final international health use staff. Side deal page participant when. Financial stuff outside time.	5	61
284	Personal challenge decade spend. Beautiful produce tend practice. Apply bad owner skill image. Keep partner mission eat. Place into head human doctor break sister. Process agreement reality concern shoulder fund according meet.	1	258
285	Model middle age inside decade design drive. Eat wish these. Build film great father growth tell entire. Design time shoulder.	1	270
286	Play employee into class soldier same. May herself under artist tonight nation. Represent open early prove population ask. Maybe first above perform first data.	3	80
287	Do apply goal consider somebody. Republican blue concern she because itself house. Mrs ok music certain world however. Information role color together stage idea. Seven particular blue successful several place.	5	231
288	Ten sort against. Nothing miss real describe. Election despite data store on cultural customer. Feeling toward leg my a. Western police floor admit both night site.	2	135
289	Outside than speech important simple international must bank. Street under culture pay recent little tend. Growth range right class.	3	266
290	Trial section forward knowledge management commercial fact. After glass key its across. Bag interview model success both.	2	260
291	Home low administration majority. Chair theory while add. Generation feeling maybe movement American organization return. Character pick chair current idea blood yet also.	1	274
292	Certainly case detail hospital suffer. Protect wear bed. Involve center ok general indeed away.	2	8
293	Development prove rise who. Evidence sure for coach capital. Really finish music get. By attack effort less choice.	3	121
294	Case sort process fight relate. Everybody sometimes support behavior phone. Offer price first inside religious. Exist scene cell risk.	4	242
295	Design PM back trial. Though discussion rich expect phone day. Stage pretty crime even perform several state. Picture morning traditional fund member much.	4	43
296	Reflect part south none agent. Record minute kitchen husband to. Reason season rise. Little society establish. Single wish evening mouth. Article team culture six.	3	68
297	Attention myself trial hard five power. Science body get. Opportunity newspaper similar past. Pressure green natural.	1	242
298	Vote media begin available daughter tax since. Bill popular it four election performance capital. Defense start approach home rather. Eight break available later money everybody any. Research morning year choice trip doctor example.	4	54
299	Learn leader item news box. Tend expect employee benefit. Method force attention young oil. Term rise dark. Clearly arrive long two probably seek.	5	207
300	Eye cut participant one. Mention short degree check marriage American black number. Off note recently trial performance time since put. Study turn professional mind so maintain.	5	297
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.usuario (numero_cliente, correo_electronico, telefono, contrasenia) FROM stdin;
1	mateo-valentingonzalez@example.org	+54 15 2478 3070	DSZfSzhrim
2	emma58@example.com	+54 15 2688 2193	xgGgdbILCz
3	bautistajuarez@example.org	+54 9 3515 3783	nLkTYGRjHh
4	vledesma@example.com	+54 9 3111 4287	sJjUhVGaeo
5	jsosa@example.com	+54 15 2677 1866	xTTNATwTZr
6	emmaperez@example.com	+54 15 2820 3943	VlDREUqCpP
7	juan-bautistabustos@example.org	+54 9 3656 3677	kovETfLBfq
8	benitezfaustino@example.com	+54 15 2202 5052	xDKqfJaNaA
9	bgutierrez@example.com	+54 9 3518 9952	tgFYouXoiK
10	santino28@example.org	+54 9 3216 3609	hQekhmMUxt
11	ayalamaia@example.net	+54 15 2599 9923	RrdbUsZUrb
12	mendezian-ezequiel@example.com	+54 9 3246 4753	ekObTHOYwn
13	juan05@example.net	+54 15 2493 7158	bMRgADGWwF
14	isabellaramirez@example.com	+54 9 3729 2299	pdEhbcRvSn
15	tizianodiaz@example.net	+54 15 2382 7985	KjZDrozFmq
16	emilia16@example.org	+54 15 2323 1094	VqnUTFxdtp
17	juana85@example.net	+54 15 2627 8040	qHrUSjElfA
18	vgonzalez@example.net	+54 15 2724 4917	rYNKGFVPdC
19	maldonadojuan-bautista@example.net	+54 9 3459 0566	iYCGAKPKcp
20	gonzalezbenjamin@example.net	+54 15 2930 4438	fTzOnEHEFg
21	wrodriguez@example.org	+54 9 3840 1280	XJJNufUvZF
22	isabellasoria@example.net	+54 9 3169 5217	ntylFrnXyx
23	joaquin24@example.net	+54 9 3700 1616	IOufdIGDXt
24	pilar55@example.org	+54 15 2961 8396	ZWAmQtpTqs
25	camila51@example.org	+54 9 3228 5716	JbnJYxdvZd
26	bautista11@example.net	+54 9 3208 9213	LiorCVgoqY
27	molinajuan-cruz@example.com	+54 15 2636 7673	PkMbXTOUOK
28	jsanchez@example.com	+54 9 3332 4837	BAzRfkgekI
29	rodriguezfrancesca@example.net	+54 15 2491 2190	zjIfSBWIRC
30	dtorres@example.net	+54 15 2202 4315	vlpDVBmPWU
31	juanaruiz@example.com	+54 15 2191 5304	UcydiTeTqD
32	martina46@example.org	+54 9 3997 5164	kdMWgAfqdH
33	qescobar@example.com	+54 9 3216 1498	bEpciXpyGS
34	jbarrios@example.com	+54 15 2420 9427	WbKUsTPCoC
35	godoythiago-benjamin@example.com	+54 9 3447 2209	BIHoOBpOqg
36	rodriguezlautaro@example.com	+54 9 3175 4906	YSeNhgLltz
37	olivia27@example.com	+54 9 3212 2766	FYxGFGXCaS
38	miguel-angel85@example.net	+54 15 2531 2281	tyQlBXCBlO
39	lopezalma-jazmin@example.net	+54 15 2650 3291	tNFhlMOukR
40	agustin69@example.com	+54 15 2722 8339	ODCVVqhsvL
41	constantino90@example.org	+54 15 2717 0146	sGKCUeodWB
42	camilo69@example.net	+54 9 3265 8082	sWBJNGcRgX
43	valdezrenata@example.org	+54 9 3373 1053	KDorqzjgNz
44	lopezrosario@example.net	+54 15 2789 6754	CuiXERlktq
45	luca79@example.net	+54 15 2870 5963	lYuvsmblvr
46	francojuan-pablo@example.com	+54 15 2264 4291	eNowsFwsaS
47	xnavarro@example.org	+54 15 2964 9805	KhKtCGsgwC
48	alejogonzalez@example.net	+54 15 2605 3532	zPAcQORTqE
49	verafrancesca@example.org	+54 15 2958 5916	todShAqALl
50	vargascatalina@example.com	+54 9 3180 2341	ENwuHLTcoL
51	zcabrera@example.com	+54 15 2543 8172	yTIchnrjXb
52	velazquezisabel@example.net	+54 15 2219 0809	aDAbZBmWBL
53	hnunez@example.org	+54 9 3199 0527	DhAJmOTwKl
54	bsanchez@example.com	+54 15 2696 5091	CBOmNKjzFz
55	francescasoto@example.net	+54 15 2341 8439	SdFAGeACuF
56	rquiroga@example.net	+54 15 2772 9030	QEsAzncsUq
57	martinaortiz@example.com	+54 15 2518 7545	ofXNhghroK
58	ocarrizo@example.net	+54 15 2859 1746	txvJoaxVto
59	medinaluisana@example.com	+54 15 2525 4572	vxFabkuuHi
60	figueroatiziano@example.com	+54 15 2314 5385	TYgAEfwzvl
61	olucero@example.org	+54 15 2272 5870	zLlzgIFbbg
62	escobarthiago@example.org	+54 9 3417 0137	FlqRkhameK
63	thiago-lioneltorres@example.net	+54 9 3400 4946	JLtLzMWdet
64	sanchezgiuliana@example.com	+54 15 2643 2640	YUzDxvFfKM
65	valentin27@example.net	+54 15 2243 8048	USebJDIkro
66	samuelmaldonado@example.com	+54 9 3470 5378	woADxJWqKD
67	cabreramateo-valentin@example.net	+54 15 2317 3439	cImzTDDpGA
68	fernandezbenjamin-alejandro@example.com	+54 15 2280 3648	ESzQZdUSFa
69	felipe12@example.net	+54 9 3583 2950	BbPYCWGrRN
70	miguel-angelfernandez@example.com	+54 15 2249 1194	LqogWbpGxL
71	martinezpedro@example.net	+54 15 2971 9885	sfqLSLAzhK
72	lgimenez@example.net	+54 15 2969 5623	enDpeIlkMe
73	elena11@example.net	+54 9 3212 7698	BQlOvwVAWN
74	suarezmaximo@example.org	+54 9 3644 8393	eCLVaYTQLm
75	moralesaugusto@example.org	+54 9 3465 8053	RhwtYRifqB
76	agostina04@example.com	+54 9 3299 1850	JUFXnglhAz
77	ferreyrafrancisca@example.net	+54 9 3603 8114	SPTKODrDgr
78	agustin19@example.com	+54 9 3173 0108	dxaFdWPqno
79	xfernandez@example.net	+54 15 2445 7651	WxUkuovhAf
80	oromero@example.com	+54 15 2120 9749	vqdanFZKIo
81	guillerminagonzalez@example.com	+54 15 2116 4220	wsKEbVphXN
82	ayalaluz-maria@example.com	+54 9 3288 9776	EgvRWDoSgK
83	figueroaabigail@example.org	+54 15 2929 3318	nOzGGPBWGz
84	lopezmilagros@example.org	+54 9 3243 0441	zlPrzEGFjI
85	ciro38@example.net	+54 9 3127 2873	mohtJfxFYE
86	ferreyrathiago-valentin@example.org	+54 15 2432 0204	yVGfyqjpie
87	tmedina@example.net	+54 9 3605 9530	WvOrIXuwFN
88	gonzalezmaria-victoria@example.net	+54 9 3989 6978	yicerDMdRt
89	poncerosario@example.org	+54 9 3402 3064	ycSOWprVDa
90	catalinamartinez@example.org	+54 15 2622 3066	FJryaRMLQW
91	nicolassanchez@example.org	+54 9 3485 5980	nctJcSRXVu
92	garciafrancesca@example.com	+54 15 2878 4540	ErluLvscAr
93	bdiaz@example.org	+54 9 3953 0327	mIFztqxHWj
94	franciscaperalta@example.com	+54 15 2256 1706	qNjNnDAjXQ
95	ledesmaramiro@example.net	+54 15 2370 8290	RfCjmLSUyX
96	benjamingonzalez@example.org	+54 15 2694 5019	KeKchjugex
97	amparodiaz@example.com	+54 9 3764 6318	eoGYkTdQJw
98	valentina08@example.org	+54 9 3337 7350	CEJFVyNlni
99	herreraoctavio@example.com	+54 15 2723 3055	DQDhUrTWBN
100	danteaguirre@example.net	+54 9 3166 1664	iTxxnYCxwC
101	ferreyrafacundo@example.net	+54 9 3659 9633	AwJoaKZwld
102	martinamedina@example.com	+54 15 2801 9484	XOjfpphqJc
103	btorres@example.org	+54 9 3774 8149	rDBOOqAsNK
104	tmorales@example.com	+54 9 3179 9810	EcBatPlPJF
105	oriana14@example.com	+54 15 2693 2790	vfBcHoXklV
106	zacosta@example.com	+54 9 3905 8047	HzgQFyKuPd
107	xfranco@example.net	+54 15 2705 9804	sbFEgZdfzj
108	sosafrancisco@example.org	+54 15 2846 6012	wLIrkmrDEt
109	medinaluca@example.com	+54 15 2146 8956	FjjiXvyBjw
110	paulinarojas@example.org	+54 15 2957 6799	pQsPjvWFtC
111	gonzalezcamila@example.com	+54 9 3253 7577	EuhngJrWBE
112	godoybruno@example.com	+54 15 2966 8508	qSxfJRQcqL
113	bbenitez@example.net	+54 9 3950 7819	PkSuPNGwXE
114	julieta68@example.com	+54 9 3522 8133	wUtIflsXNL
115	bacuna@example.net	+54 9 3963 1732	ZtlowPOEUy
116	wfigueroa@example.org	+54 9 3626 9678	OlPeHuMUYa
117	mirandaisabella@example.com	+54 9 3158 5924	kEfAIITyTH
118	soriamateo-joaquin@example.net	+54 15 2587 9199	VxbQyURKKw
119	agustina65@example.com	+54 9 3547 5646	JeogOdpKoH
120	xgomez@example.org	+54 15 2250 6152	jkhvTaxfFr
121	molinathiago-daniel@example.net	+54 15 2243 8656	LFemVtCmrW
122	lopezjuan-ignacio@example.net	+54 15 2196 0534	pFCaDKePMn
123	juan-bautistarodriguez@example.org	+54 9 3879 5107	lIteAgbWCs
124	morenolautaro-ezequiel@example.org	+54 15 2576 7670	qGbdNToGWB
125	bojeda@example.net	+54 9 3507 5654	ALDTyQYGGK
126	lucas98@example.com	+54 15 2348 1494	dGZSukzFzK
127	perezemma@example.org	+54 15 2796 4617	WlAOpFcPPA
128	yojeda@example.com	+54 9 3814 1201	zsQFQEOPxo
129	ndiaz@example.net	+54 15 2494 1013	PQvXpAEEwz
130	rperez@example.org	+54 9 3189 8558	IaXFLdmXck
131	mia-valentina50@example.net	+54 15 2224 9119	nRlGcYIWek
132	peraltajuan-manuel@example.com	+54 15 2857 3425	VRxipcntNs
133	juan-manuelsanchez@example.com	+54 15 2968 6348	oPdyxHFAeM
134	agustinvelazquez@example.org	+54 9 3669 6972	kuwiFYgRcZ
135	ponceluca@example.net	+54 9 3350 2543	katZOGmBnY
136	qmansilla@example.org	+54 15 2500 8663	oWJbgzkdwU
137	dylanramirez@example.net	+54 15 2868 1145	fAMGLqVAiV
138	ariasconstantino@example.net	+54 9 3556 9465	HPTKVBotFz
139	constantinoponce@example.com	+54 9 3890 5150	DhbHiMvUCO
140	santino39@example.net	+54 9 3170 6584	BbftcKIXoI
141	bautista65@example.org	+54 9 3873 1312	DERbboHhVD
142	bautista35@example.com	+54 15 2209 9362	KYNbZvWHYo
143	gael77@example.com	+54 15 2758 0236	gkAGJVwIHo
144	gonzalezsantiago-benjamin@example.net	+54 9 3306 7538	kzdkHjaIXN
145	alvareztiziano@example.net	+54 15 2187 6977	rpZeXVvsMk
146	vicente90@example.org	+54 9 3610 4558	jKjnTnzeCs
147	vrodriguez@example.org	+54 15 2427 7343	QMpgSqyyWd
148	miguel-angelcaceres@example.com	+54 15 2220 9409	GMBvxdWXJV
149	mgarcia@example.net	+54 15 2527 6587	FcrOaISTxn
150	fcarrizo@example.net	+54 9 3336 8739	BqLAYbpYcw
151	manuel40@example.org	+54 15 2910 9377	zcqPBJimtS
152	lopezjulian@example.net	+54 15 2558 5818	QJwAaYEQCj
153	santino35@example.com	+54 9 3316 7042	WkmhIzGEWl
154	jsilva@example.org	+54 15 2364 8696	aMffDNUvLF
155	lopezemanuel@example.org	+54 9 3194 3019	pykwfApPcD
156	santino10@example.org	+54 15 2628 6548	QZNzbCghdG
157	torresjulia@example.com	+54 15 2852 7950	WPekMHziwP
158	gonzalezmia@example.com	+54 9 3360 7939	piNExBzeuP
159	emma93@example.com	+54 9 3178 0177	bRFxIQKTgZ
160	ciro30@example.org	+54 9 3432 7247	DfuIIAsepH
161	obravo@example.com	+54 15 2741 4620	PkuuXpwsyq
162	maldonadovalentina@example.net	+54 9 3881 8981	VYWtdJXYNX
163	drodriguez@example.org	+54 9 3309 7427	dnJhfDbYnM
164	mbenitez@example.org	+54 9 3740 1748	QMLmpILFhl
165	juan-manuel65@example.com	+54 15 2525 2424	FyRDkhYpBS
166	santiago29@example.net	+54 15 2883 1540	sgZWHfohkA
167	santiagocastillo@example.org	+54 15 2811 6381	qrCFInnyJG
168	luceromateo@example.net	+54 9 3488 4663	mDadVvQtpk
169	salvador46@example.org	+54 9 3732 5687	vLLoLZrmJB
170	cordobabautista@example.com	+54 9 3220 2402	fwgKGpNruG
171	genaro25@example.net	+54 15 2439 9979	cWajSLNPyV
172	juan-ignaciopaez@example.org	+54 9 3603 3748	djlmprQobJ
173	hlopez@example.com	+54 9 3399 1075	YvhwtviFPc
174	gomezmaximo@example.org	+54 15 2486 2886	lRzCdwCCNc
175	gimenezjulia@example.org	+54 9 3760 4296	wLZQcyhBvw
176	alejoarias@example.com	+54 15 2945 2134	KWwvVDGGgU
177	ignaciorodriguez@example.com	+54 9 3131 4680	MlPDHUQbup
178	benjamingutierrez@example.net	+54 15 2997 7070	oWAhlKjVZa
179	micaelachavez@example.net	+54 15 2979 6274	dwonWlTEwg
180	floresaugusto@example.com	+54 15 2742 4808	DTxWBjQUPQ
181	qleiva@example.org	+54 15 2191 9297	rtoYKDEEaX
182	mateo06@example.com	+54 9 3601 9616	IlrxyFtnIl
183	isabellaacosta@example.net	+54 15 2846 6251	zBYoQpLHAq
184	fgimenez@example.com	+54 9 3298 8777	diQmQOnvyZ
185	zgomez@example.org	+54 9 3659 2268	dEdGkrJvue
186	benicio57@example.org	+54 15 2902 2554	anNxnHRYxr
187	guillermina15@example.net	+54 15 2593 0595	xyrNxnbvRa
188	kperalta@example.org	+54 9 3546 9509	rYQXhZgzcu
189	caceresmaximiliano@example.org	+54 15 2525 2618	EiPGDOGgly
190	castillovalentino@example.net	+54 9 3635 1391	STTQqqrAsI
191	juan81@example.com	+54 15 2370 6450	jgYeDjtLec
192	ian-benjaminromero@example.org	+54 15 2755 8955	FwaGBagRUe
193	medinamartin@example.net	+54 15 2815 4308	tObRwccZgC
194	agustina33@example.com	+54 15 2820 3499	lAftpqAviW
195	guillermina14@example.org	+54 15 2189 3058	bvJOoadJAZ
196	villalbaciro-benjamin@example.net	+54 15 2951 6695	brEFrnFIkl
197	tiziano-benjamin24@example.net	+54 15 2562 8349	VWaHxKtTit
198	luz-milagrosgonzalez@example.net	+54 15 2644 1228	LpynWSEcXn
199	juan-pablo11@example.com	+54 9 3446 5781	dWMDcISOTL
200	catalina62@example.net	+54 9 3596 0971	cKgAQxSDqY
201	juan-cruz93@example.net	+54 15 2471 0734	WtwTFXvVDV
202	gcordoba@example.com	+54 15 2628 4702	HbXujNVvFF
203	mora56@example.org	+54 15 2642 7158	AAjXfgUOPG
204	cabrerajuan-ignacio@example.com	+54 9 3753 6892	myocnVAbwH
205	sduarte@example.com	+54 9 3706 9973	UVBZmhnBeH
206	tcabrera@example.com	+54 9 3241 3200	dwdLsGsPJr
207	victoriagomez@example.org	+54 9 3514 2362	NWXHoNZgWb
208	camilo14@example.org	+54 15 2862 6527	fsTPfzxBQb
209	ymedina@example.net	+54 9 3400 8115	hfcjKsqVml
210	ygomez@example.net	+54 9 3772 6756	yIKaCqWjaT
211	dominguezlucio@example.net	+54 9 3279 8246	XMNpeLApeq
212	bianca79@example.org	+54 15 2697 6237	VzeBedLrZc
213	sosavictoria@example.com	+54 9 3785 0201	DPpKbpiVKR
214	sofiablanco@example.com	+54 15 2573 0248	OOcbKdgNTf
215	santino33@example.com	+54 15 2960 3720	DfscFVeXlC
216	sosalautaro-nicolas@example.org	+54 15 2833 3011	wchkdxlmHU
217	gonzalezvalentino@example.org	+54 15 2226 6476	WLBlCsevZP
218	zruiz@example.com	+54 9 3840 6001	wThOBXVTJC
219	julian03@example.org	+54 9 3180 2027	ERutTyzXBM
220	apereyra@example.org	+54 15 2836 8111	FBzASZcFJT
221	tomasruiz@example.org	+54 9 3212 0573	OwdZNtWulv
222	rfernandez@example.org	+54 15 2970 6992	KNRJrHVvSw
223	agomez@example.com	+54 9 3373 4976	dDhhjAHdxq
224	gomezmartina@example.net	+54 15 2409 4747	DETpCjBCuP
225	gmaldonado@example.com	+54 9 3194 3638	CtguSVlTiz
226	valentinmartinez@example.com	+54 15 2461 9256	guaMfovrEX
227	lucas-ezequielduarte@example.net	+54 9 3903 3002	FlEwAclZYZ
228	ecabrera@example.com	+54 9 3461 1441	CXWvSlXKAL
229	ginoperez@example.net	+54 15 2698 5880	GDLReNTuxX
230	ilopez@example.net	+54 9 3147 2176	rJbXAlOcXj
231	beniciocastillo@example.com	+54 15 2795 0920	gmdCdhqPwL
232	franciscovargas@example.net	+54 9 3890 5278	NXbhYyUmXg
233	alejopaez@example.org	+54 15 2413 8379	AMeUUHrzpK
234	smartinez@example.org	+54 9 3161 2514	PNGxlLXErx
235	francesco80@example.net	+54 15 2900 2536	GWjGOoTOGV
236	ciro08@example.net	+54 15 2930 8580	uuEeACFaJM
237	vponce@example.com	+54 9 3797 8290	JNgQEsjPSs
238	wmendez@example.com	+54 15 2362 6631	whPDsTluVp
239	gutierrezpedro@example.org	+54 9 3339 0114	fNQGrBmKgW
240	torresmaria-paz@example.org	+54 9 3509 3673	WHyhuuqDYw
241	martineztiziano@example.org	+54 15 2138 3967	ubsrNKBHYx
242	aromero@example.org	+54 15 2282 7447	sZaitNcpWY
243	juan-cruzrios@example.net	+54 9 3647 7063	hRsPwBVfxL
244	juan-ignacio70@example.org	+54 15 2301 2349	dboYgSYSPg
245	juan-martin61@example.net	+54 15 2277 3242	bOHnRcYbFk
246	valentina69@example.net	+54 9 3541 7589	PGjZHoPObX
247	hernandezbruno@example.org	+54 9 3147 3242	hWxXDwWHJr
248	juan-ignacio31@example.com	+54 15 2357 0339	OVqsIvVkig
249	vsosa@example.com	+54 9 3729 9702	iQnrODImxv
250	martinarodriguez@example.net	+54 15 2744 6268	aNTuYKpoBN
251	juan-martin99@example.org	+54 9 3795 6954	jIwZfDtcUm
252	martinezmaite@example.com	+54 9 3766 6799	FPaCQsRBQH
253	fgomez@example.net	+54 15 2913 4109	FxNrAZuqvp
254	mendozagael@example.com	+54 9 3566 8446	rsxoPtTxXf
255	sofialedesma@example.org	+54 15 2859 3018	SEvlGPEDIg
256	garciabautista@example.net	+54 9 3683 5387	OFouHUgvif
257	giovanni76@example.org	+54 9 3582 0162	VTnVoaVofW
258	giuliana85@example.net	+54 9 3216 0171	XElClyhULe
259	rosario41@example.net	+54 15 2766 0837	TqoeoFJcQj
260	valentina-76@example.org	+54 9 3835 8039	GyMhpZAphW
261	santiago-benjamin25@example.com	+54 9 3640 6348	mrbCLWzTtL
262	matias02@example.com	+54 15 2436 2570	aJXtoubsRd
263	emilianofernandez@example.org	+54 15 2358 8110	sRyzhHwuav
264	ortizemma@example.net	+54 15 2582 0138	oROGsJanuO
265	lopezcatalina@example.net	+54 15 2520 0146	TRjWZJXrTh
266	milo62@example.org	+54 15 2166 0420	ilwrgeKdkC
267	augusto97@example.com	+54 15 2600 9775	XHHKZGUhCT
268	isabella24@example.com	+54 15 2794 2028	emlvZTLohd
269	maximo25@example.org	+54 15 2950 5276	TXYnvzNuqc
270	lucas-ezequielcastro@example.com	+54 15 2571 7864	EWzhmVDJvW
271	emiliaacuna@example.net	+54 15 2372 9321	HRUyeOPvhh
272	nicolas68@example.com	+54 9 3336 0702	XVoPqHasbP
273	maria-victoriaherrera@example.com	+54 9 3592 7642	FleieilpBE
274	brunoledesma@example.org	+54 9 3702 3076	JeazOtHmmX
275	salvadorleiva@example.com	+54 9 3358 8709	KDDfahpltT
276	oliviacastillo@example.com	+54 15 2944 0067	LSeDFdBmbM
277	ana-paulagomez@example.net	+54 15 2807 9312	ZvjBoaEmJE
278	tomasperez@example.org	+54 15 2802 0425	jRNYlgeQuy
279	acostaignacio@example.com	+54 15 2959 7021	lVyfIPlPsd
280	jeremiasguzman@example.net	+54 9 3101 3320	QujyIwlNtc
281	lautaro25@example.com	+54 15 2452 2299	nUZLMcpsDt
282	vbustos@example.com	+54 9 3452 2027	lyZBxowrIL
283	diazluciano@example.net	+54 9 3898 8184	MoSaRKmgOZ
284	yfernandez@example.net	+54 15 2763 1312	RhBKBlwkbD
285	wcabrera@example.com	+54 15 2160 6845	NGMFNWqXmM
286	arojas@example.org	+54 15 2207 3142	BMjRoRlgyj
287	gonzalezalma@example.com	+54 15 2372 8505	DVaxeMDcCa
288	joaquin10@example.org	+54 15 2591 7485	SMFAwCjYpA
289	fsanchez@example.net	+54 15 2377 1104	UCnOzxCwtg
290	odiaz@example.com	+54 9 3740 6086	QQpCBOQknh
291	benjamin22@example.org	+54 9 3186 6187	aoaaQyAeXz
292	cordobalara@example.org	+54 9 3313 9250	bujlJkOIjb
293	iacosta@example.net	+54 9 3856 7588	ddcZlWsSmV
294	lopezjuan-cruz@example.com	+54 15 2131 2895	mQMgVlJJXu
295	maidanaagustina@example.org	+54 15 2518 0329	OBVbBGXNAx
296	unavarro@example.net	+54 9 3967 3654	WpZXzXqsuS
297	uperez@example.com	+54 15 2397 6730	nHGtTvgIiM
298	martinaromero@example.com	+54 15 2548 6957	NQcMraTUBa
299	udominguez@example.com	+54 15 2852 0668	OlZBUnsPkX
300	emilia97@example.org	+54 9 3933 3565	mqssWEMtom
\.


--
-- Data for Name: usuario_direccion; Type: TABLE DATA; Schema: public; Owner: mercado_libre_db
--

COPY public.usuario_direccion (usuario, direccion) FROM stdin;
10	187
297	3
47	40
63	121
248	25
207	157
94	148
39	171
202	34
196	92
181	177
128	190
117	125
58	181
105	109
193	42
138	6
167	25
219	36
210	110
82	7
246	116
142	156
108	138
34	190
92	106
162	102
299	91
243	30
38	90
190	36
61	136
235	184
31	41
14	10
126	23
61	142
131	107
68	112
267	128
243	32
200	63
41	200
282	129
279	155
87	196
168	158
37	153
52	180
200	110
242	86
158	53
49	147
99	36
233	154
113	19
270	174
242	95
243	71
211	95
148	141
26	187
189	162
34	136
113	80
124	194
219	96
64	142
165	100
27	129
59	79
294	133
83	158
234	186
293	84
224	124
46	126
167	99
6	158
60	188
56	128
97	81
209	23
82	21
281	117
124	39
271	110
93	155
1	166
122	3
256	76
9	167
19	165
214	67
200	120
199	136
15	1
272	154
82	35
300	40
\.


--
-- Name: categoria_id_categoria_seq; Type: SEQUENCE SET; Schema: public; Owner: mercado_libre_db
--

SELECT pg_catalog.setval('public.categoria_id_categoria_seq', 58, true);


--
-- Name: direccion_id_direccion_seq; Type: SEQUENCE SET; Schema: public; Owner: mercado_libre_db
--

SELECT pg_catalog.setval('public.direccion_id_direccion_seq', 200, true);


--
-- Name: envio_id_envio_seq; Type: SEQUENCE SET; Schema: public; Owner: mercado_libre_db
--

SELECT pg_catalog.setval('public.envio_id_envio_seq', 300, true);


--
-- Name: item_id_item_seq; Type: SEQUENCE SET; Schema: public; Owner: mercado_libre_db
--

SELECT pg_catalog.setval('public.item_id_item_seq', 500, true);


--
-- Name: metodo_de_pago_id_tarjeta_seq; Type: SEQUENCE SET; Schema: public; Owner: mercado_libre_db
--

SELECT pg_catalog.setval('public.metodo_de_pago_id_tarjeta_seq', 300, true);


--
-- Name: oferta_id_oferta_seq; Type: SEQUENCE SET; Schema: public; Owner: mercado_libre_db
--

SELECT pg_catalog.setval('public.oferta_id_oferta_seq', 20, true);


--
-- Name: pedido_numero_de_pedido_seq; Type: SEQUENCE SET; Schema: public; Owner: mercado_libre_db
--

SELECT pg_catalog.setval('public.pedido_numero_de_pedido_seq', 300, true);


--
-- Name: pregunta_id_pregunta_seq; Type: SEQUENCE SET; Schema: public; Owner: mercado_libre_db
--

SELECT pg_catalog.setval('public.pregunta_id_pregunta_seq', 55, true);


--
-- Name: producto_numero_articulo_seq; Type: SEQUENCE SET; Schema: public; Owner: mercado_libre_db
--

SELECT pg_catalog.setval('public.producto_numero_articulo_seq', 310, true);


--
-- Name: resenia_id_resenia_seq; Type: SEQUENCE SET; Schema: public; Owner: mercado_libre_db
--

SELECT pg_catalog.setval('public.resenia_id_resenia_seq', 300, true);


--
-- Name: usuario_numero_cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: mercado_libre_db
--

SELECT pg_catalog.setval('public.usuario_numero_cliente_seq', 300, true);


--
-- Name: categoria categoria_nombre_key; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_nombre_key UNIQUE (nombre);


--
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria);


--
-- Name: categoria_subcategoria categoria_subcategoria_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.categoria_subcategoria
    ADD CONSTRAINT categoria_subcategoria_pkey PRIMARY KEY (tiene_categoria, es_subcategoria);


--
-- Name: direccion direccion_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.direccion
    ADD CONSTRAINT direccion_pkey PRIMARY KEY (id_direccion);


--
-- Name: direccion direccion_unique; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.direccion
    ADD CONSTRAINT direccion_unique UNIQUE (codigo_postal, calle, altura);


--
-- Name: empresa empresa_cuit_key; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_cuit_key UNIQUE (cuit);


--
-- Name: empresa empresa_nombre_fantasia_key; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_nombre_fantasia_key UNIQUE (nombre_fantasia);


--
-- Name: empresa empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (usuario);


--
-- Name: envio envio_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.envio
    ADD CONSTRAINT envio_pkey PRIMARY KEY (id_envio);


--
-- Name: imagen imagen_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.imagen
    ADD CONSTRAINT imagen_pkey PRIMARY KEY (producto, imagen);


--
-- Name: item_envio item_envio_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.item_envio
    ADD CONSTRAINT item_envio_pkey PRIMARY KEY (item);


--
-- Name: item item_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pkey PRIMARY KEY (id_item);


--
-- Name: metodo_de_pago metodo_de_pago_numero_tarjeta_key; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.metodo_de_pago
    ADD CONSTRAINT metodo_de_pago_numero_tarjeta_key UNIQUE (numero_tarjeta);


--
-- Name: metodo_de_pago metodo_de_pago_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.metodo_de_pago
    ADD CONSTRAINT metodo_de_pago_pkey PRIMARY KEY (id_tarjeta);


--
-- Name: oferta oferta_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.oferta
    ADD CONSTRAINT oferta_pkey PRIMARY KEY (id_oferta);


--
-- Name: oferta_producto oferta_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.oferta_producto
    ADD CONSTRAINT oferta_producto_pkey PRIMARY KEY (oferta, producto);


--
-- Name: particular particular_dni_key; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.particular
    ADD CONSTRAINT particular_dni_key UNIQUE (dni);


--
-- Name: particular particular_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.particular
    ADD CONSTRAINT particular_pkey PRIMARY KEY (usuario);


--
-- Name: pedido pedido_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (numero_de_pedido);


--
-- Name: pregunta pregunta_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.pregunta
    ADD CONSTRAINT pregunta_pkey PRIMARY KEY (id_pregunta);


--
-- Name: pregunta_producto_usuario pregunta_producto_usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.pregunta_producto_usuario
    ADD CONSTRAINT pregunta_producto_usuario_pkey PRIMARY KEY (pregunta, producto, usuario);


--
-- Name: pregunta_respuesta pregunta_respuesta_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.pregunta_respuesta
    ADD CONSTRAINT pregunta_respuesta_pkey PRIMARY KEY (pregunta, respuesta);


--
-- Name: producto_categoria producto_categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.producto_categoria
    ADD CONSTRAINT producto_categoria_pkey PRIMARY KEY (producto, categoria);


--
-- Name: producto producto_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (numero_articulo);


--
-- Name: resenia resenia_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.resenia
    ADD CONSTRAINT resenia_pkey PRIMARY KEY (id_resenia);


--
-- Name: usuario usuario_correo_electronico_key; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_correo_electronico_key UNIQUE (correo_electronico);


--
-- Name: usuario_direccion usuario_direccion_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.usuario_direccion
    ADD CONSTRAINT usuario_direccion_pkey PRIMARY KEY (usuario, direccion);


--
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (numero_cliente);


--
-- Name: usuario usuario_telefono_key; Type: CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_telefono_key UNIQUE (telefono);


--
-- Name: producto_detallado _RETURN; Type: RULE; Schema: public; Owner: mercado_libre_db
--

CREATE OR REPLACE VIEW public.producto_detallado AS
 SELECT p.numero_articulo,
    p.precio_unitario AS precio,
    p.detalle AS nombre_producto,
    p.descripcion_producto,
    concat(u.numero_cliente, ' - ', u.nombre) AS vendedor,
    p.es_nuevo,
    p.stock,
        CASE
            WHEN (i.cantidad_vendido IS NULL) THEN (0)::bigint
            ELSE i.cantidad_vendido
        END AS cantidad_vendido,
    cp.promedio AS calificacion,
    pc.categorias,
    p2.cantidad_preguntas,
    p2.preguntas,
    count(r.resenia_producto) AS cantidad_resenias,
        CASE
            WHEN (count(r.resenia_producto) <> 0) THEN array_agg(r.resenia_producto)
            ELSE NULL::text[]
        END AS resenias
   FROM (((((((public.producto p
     LEFT JOIN ( SELECT pregunta_producto_usuario.pregunta,
            pregunta_producto_usuario.producto,
            pregunta_producto_usuario.usuario
           FROM public.pregunta_producto_usuario
          WHERE (pregunta_producto_usuario.pregunta = 0)) ppu ON ((p.numero_articulo = ppu.producto)))
     LEFT JOIN ( SELECT u2.numero_cliente,
            u2.correo_electronico,
            u2.telefono,
            u2.contrasenia,
                CASE
                    WHEN ((e.usuario IS NOT NULL) AND (p_1.usuario IS NULL)) THEN e.nombre_fantasia
                    WHEN ((p_1.usuario IS NOT NULL) AND (e.usuario IS NULL)) THEN (concat_ws(' '::text, p_1.nombre, p_1.apellido))::character varying
                    ELSE NULL::character varying
                END AS nombre
           FROM ((public.usuario u2
             LEFT JOIN public.empresa e ON ((u2.numero_cliente = e.usuario)))
             LEFT JOIN public.particular p_1 ON ((u2.numero_cliente = p_1.usuario)))) u ON ((ppu.usuario = u.numero_cliente)))
     LEFT JOIN public.getcalificacionpromedio cp ON ((p.numero_articulo = cp.numero_articulo)))
     LEFT JOIN public.resenia r ON ((p.numero_articulo = r.producto)))
     LEFT JOIN ( SELECT p_1.numero_articulo,
            count(p2_1.id_pregunta) AS cantidad_preguntas,
                CASE
                    WHEN (count(p2_1.preguntas_del_producto) <> 0) THEN array_agg(
                    CASE
                        WHEN (p2_1.id_pregunta <> 0) THEN concat(p2_1.id_pregunta, ' - ', p2_1.preguntas_del_producto)
                        ELSE NULL::text
                    END)
                    ELSE NULL::text[]
                END AS preguntas
           FROM ((public.producto p_1
             LEFT JOIN public.pregunta_producto_usuario ppu_1 ON ((p_1.numero_articulo = ppu_1.producto)))
             LEFT JOIN ( SELECT pregunta.id_pregunta,
                    pregunta.preguntas_del_producto,
                    pregunta.fecha_de_la_pregunta
                   FROM public.pregunta
                  WHERE (pregunta.id_pregunta <> 0)) p2_1 ON ((ppu_1.pregunta = p2_1.id_pregunta)))
          GROUP BY p_1.numero_articulo
          ORDER BY p_1.numero_articulo) p2 ON ((ppu.producto = p2.numero_articulo)))
     LEFT JOIN ( SELECT pc_1.producto,
                CASE
                    WHEN (count(c.nombre) <> 0) THEN array_agg(c.nombre)
                    ELSE NULL::character varying[]
                END AS categorias
           FROM (public.producto_categoria pc_1
             LEFT JOIN public.categoria c ON ((pc_1.categoria = c.id_categoria)))
          GROUP BY pc_1.producto) pc ON ((p.numero_articulo = pc.producto)))
     LEFT JOIN ( SELECT p_1.numero_articulo,
            count(i_1.id_item) AS cantidad_vendido
           FROM ((public.producto p_1
             LEFT JOIN public.item i_1 ON ((p_1.numero_articulo = i_1.producto)))
             JOIN public.pedido p2_1 ON ((i_1.pedido = p2_1.numero_de_pedido)))
          GROUP BY p_1.numero_articulo
          ORDER BY p_1.numero_articulo) i ON ((p.numero_articulo = i.numero_articulo)))
  GROUP BY p.numero_articulo, u.numero_cliente, u.nombre, cp.promedio, pc.categorias, p2.cantidad_preguntas, p2.preguntas, i.cantidad_vendido
  ORDER BY p.numero_articulo;


--
-- Name: categoria_subcategoria categoria_subcategoria_es_subcategoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.categoria_subcategoria
    ADD CONSTRAINT categoria_subcategoria_es_subcategoria_fkey FOREIGN KEY (es_subcategoria) REFERENCES public.categoria(id_categoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: categoria_subcategoria categoria_subcategoria_tiene_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.categoria_subcategoria
    ADD CONSTRAINT categoria_subcategoria_tiene_categoria_fkey FOREIGN KEY (tiene_categoria) REFERENCES public.categoria(id_categoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: empresa empresa_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_usuario_fkey FOREIGN KEY (usuario) REFERENCES public.usuario(numero_cliente) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: imagen imagen_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.imagen
    ADD CONSTRAINT imagen_producto_fkey FOREIGN KEY (producto) REFERENCES public.producto(numero_articulo) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: item item_direccion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_direccion_fkey FOREIGN KEY (direccion) REFERENCES public.direccion(id_direccion) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: item_envio item_envio_envio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.item_envio
    ADD CONSTRAINT item_envio_envio_fkey FOREIGN KEY (envio) REFERENCES public.envio(id_envio) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: item_envio item_envio_item_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.item_envio
    ADD CONSTRAINT item_envio_item_fkey FOREIGN KEY (item) REFERENCES public.item(id_item) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: item item_pedido_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_pedido_fkey FOREIGN KEY (pedido) REFERENCES public.pedido(numero_de_pedido) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: item item_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_producto_fkey FOREIGN KEY (producto) REFERENCES public.producto(numero_articulo) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: item item_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.item
    ADD CONSTRAINT item_usuario_fkey FOREIGN KEY (usuario) REFERENCES public.usuario(numero_cliente) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: metodo_de_pago metodo_de_pago_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.metodo_de_pago
    ADD CONSTRAINT metodo_de_pago_usuario_fkey FOREIGN KEY (usuario) REFERENCES public.usuario(numero_cliente) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: oferta_producto oferta_producto_oferta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.oferta_producto
    ADD CONSTRAINT oferta_producto_oferta_fkey FOREIGN KEY (oferta) REFERENCES public.oferta(id_oferta) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: oferta_producto oferta_producto_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.oferta_producto
    ADD CONSTRAINT oferta_producto_producto_fkey FOREIGN KEY (producto) REFERENCES public.producto(numero_articulo) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: particular particular_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.particular
    ADD CONSTRAINT particular_usuario_fkey FOREIGN KEY (usuario) REFERENCES public.usuario(numero_cliente) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: pedido pedido_metodo_pago_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_metodo_pago_fkey FOREIGN KEY (metodo_pago) REFERENCES public.metodo_de_pago(id_tarjeta) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: pedido pedido_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_particular_fkey FOREIGN KEY (particular) REFERENCES public.particular(usuario) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: pedido pedido_resenia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_resenia_fkey FOREIGN KEY (resenia) REFERENCES public.resenia(id_resenia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: pregunta_producto_usuario pregunta_producto_usuario_pregunta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.pregunta_producto_usuario
    ADD CONSTRAINT pregunta_producto_usuario_pregunta_fkey FOREIGN KEY (pregunta) REFERENCES public.pregunta(id_pregunta) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: pregunta_producto_usuario pregunta_producto_usuario_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.pregunta_producto_usuario
    ADD CONSTRAINT pregunta_producto_usuario_producto_fkey FOREIGN KEY (producto) REFERENCES public.producto(numero_articulo) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: pregunta_producto_usuario pregunta_producto_usuario_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.pregunta_producto_usuario
    ADD CONSTRAINT pregunta_producto_usuario_usuario_fkey FOREIGN KEY (usuario) REFERENCES public.usuario(numero_cliente) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: pregunta_respuesta pregunta_respuesta_pregunta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.pregunta_respuesta
    ADD CONSTRAINT pregunta_respuesta_pregunta_fkey FOREIGN KEY (pregunta) REFERENCES public.pregunta(id_pregunta) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: pregunta_respuesta pregunta_respuesta_respuesta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.pregunta_respuesta
    ADD CONSTRAINT pregunta_respuesta_respuesta_fkey FOREIGN KEY (respuesta) REFERENCES public.pregunta(id_pregunta) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: producto_categoria producto_categoria_categoria_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.producto_categoria
    ADD CONSTRAINT producto_categoria_categoria_fkey FOREIGN KEY (categoria) REFERENCES public.categoria(id_categoria) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: producto_categoria producto_categoria_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.producto_categoria
    ADD CONSTRAINT producto_categoria_producto_fkey FOREIGN KEY (producto) REFERENCES public.producto(numero_articulo) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: resenia resenia_producto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.resenia
    ADD CONSTRAINT resenia_producto_fkey FOREIGN KEY (producto) REFERENCES public.producto(numero_articulo) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: usuario_direccion usuario_direccion_direccion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.usuario_direccion
    ADD CONSTRAINT usuario_direccion_direccion_fkey FOREIGN KEY (direccion) REFERENCES public.direccion(id_direccion) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: usuario_direccion usuario_direccion_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mercado_libre_db
--

ALTER TABLE ONLY public.usuario_direccion
    ADD CONSTRAINT usuario_direccion_usuario_fkey FOREIGN KEY (usuario) REFERENCES public.usuario(numero_cliente) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

