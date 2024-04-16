PGDMP                      |            KrakenDB    16.1    16.1 t    C           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            D           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            E           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            F           1262    24805    KrakenDB    DATABASE     �   CREATE DATABASE "KrakenDB" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Guatemala.1252';
    DROP DATABASE "KrakenDB";
                postgres    false            �            1255    24935    get_average_dining_time()    FUNCTION     &  CREATE FUNCTION public.get_average_dining_time() RETURNS TABLE(num_diners integer, average_time interval)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT num_diners, AVG(fecha_hora_cierre - fecha_hora_apertura) AS average_time
    FROM Cuenta
    GROUP BY num_diners;
END;
$$;
 0   DROP FUNCTION public.get_average_dining_time();
       public          postgres    false            �            1255    24937 P   get_complaints_by_dish(timestamp without time zone, timestamp without time zone)    FUNCTION     �  CREATE FUNCTION public.get_complaints_by_dish(start_date timestamp without time zone, end_date timestamp without time zone) RETURNS TABLE(dish_name character varying, total_complaints integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT plato_bebida, COUNT(*) AS total_complaints
    FROM Queja
    WHERE fecha_hora BETWEEN start_date AND end_date
    GROUP BY plato_bebida
    ORDER BY total_complaints DESC;
END;
$$;
 {   DROP FUNCTION public.get_complaints_by_dish(start_date timestamp without time zone, end_date timestamp without time zone);
       public          postgres    false            �            1255    24936 R   get_complaints_by_person(timestamp without time zone, timestamp without time zone)    FUNCTION     �  CREATE FUNCTION public.get_complaints_by_person(start_date timestamp without time zone, end_date timestamp without time zone) RETURNS TABLE(person character varying, total_complaints integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT persona, COUNT(*) AS total_complaints
    FROM Queja
    WHERE fecha_hora BETWEEN start_date AND end_date
    GROUP BY persona
    ORDER BY total_complaints DESC;
END;
$$;
 }   DROP FUNCTION public.get_complaints_by_person(start_date timestamp without time zone, end_date timestamp without time zone);
       public          postgres    false            �            1255    24933 Q   get_most_ordered_plates(timestamp without time zone, timestamp without time zone)    FUNCTION       CREATE FUNCTION public.get_most_ordered_plates(start_date timestamp without time zone, end_date timestamp without time zone) RETURNS TABLE(plate_name character varying, total_orders integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT p.nombre AS plate_name, COUNT(*) AS total_orders
    FROM Pedido pe
    JOIN Cuenta c ON pe.cuenta_id = c.cuenta_id
    JOIN Plato p ON pe.plato_id = p.plato_id
    WHERE pe.fecha_hora_pedido BETWEEN start_date AND end_date
    GROUP BY p.nombre
    ORDER BY total_orders DESC;
END;
$$;
 |   DROP FUNCTION public.get_most_ordered_plates(start_date timestamp without time zone, end_date timestamp without time zone);
       public          postgres    false            �            1255    24934 N   get_peak_order_times(timestamp without time zone, timestamp without time zone)    FUNCTION     �  CREATE FUNCTION public.get_peak_order_times(start_date timestamp without time zone, end_date timestamp without time zone) RETURNS TABLE(order_hour integer, total_orders integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT EXTRACT(HOUR FROM fecha_hora_pedido) AS order_hour, COUNT(*) AS total_orders
    FROM Pedido
    WHERE fecha_hora_pedido BETWEEN start_date AND end_date
    GROUP BY order_hour
    ORDER BY total_orders DESC;
END;
$$;
 y   DROP FUNCTION public.get_peak_order_times(start_date timestamp without time zone, end_date timestamp without time zone);
       public          postgres    false            �            1255    24938    get_waiter_efficiency_report()    FUNCTION     �  CREATE FUNCTION public.get_waiter_efficiency_report() RETURNS TABLE(waiter_name character varying, month date, avg_friendliness_rating numeric, avg_accuracy_rating numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT c.nombre AS waiter_name,
           DATE_TRUNC('month', e.fecha_hora) AS month,
           AVG(e.calificacion_amabilidad) AS avg_friendliness_rating,
           AVG(e.calificacion_exactitud) AS avg_accuracy_rating
    FROM Encuesta e
    JOIN Cliente c ON e.cliente_id = c.cliente_id
    WHERE e.fecha_hora > CURRENT_DATE - INTERVAL '6 months'
    GROUP BY c.nombre, DATE_TRUNC('month', e.fecha_hora)
    ORDER BY c.nombre, DATE_TRUNC('month', e.fecha_hora);
END;
$$;
 5   DROP FUNCTION public.get_waiter_efficiency_report();
       public          postgres    false            �            1259    24807    area    TABLE     �   CREATE TABLE public.area (
    area_id integer NOT NULL,
    nombre character varying(100),
    tipo character varying(50),
    capacidad_maxima integer
);
    DROP TABLE public.area;
       public         heap    postgres    false            �            1259    24806    area_area_id_seq    SEQUENCE     �   CREATE SEQUENCE public.area_area_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.area_area_id_seq;
       public          postgres    false    216            G           0    0    area_area_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.area_area_id_seq OWNED BY public.area.area_id;
          public          postgres    false    215            �            1259    24859    bebida    TABLE     �   CREATE TABLE public.bebida (
    bebida_id integer NOT NULL,
    nombre character varying(100),
    descripcion text,
    precio numeric(10,2)
);
    DROP TABLE public.bebida;
       public         heap    postgres    false            �            1259    24858    bebida_bebida_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bebida_bebida_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.bebida_bebida_id_seq;
       public          postgres    false    226            H           0    0    bebida_bebida_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.bebida_bebida_id_seq OWNED BY public.bebida.bebida_id;
          public          postgres    false    225            �            1259    24868    cliente    TABLE     �   CREATE TABLE public.cliente (
    cliente_id integer NOT NULL,
    nombre character varying(100),
    direccion character varying(200),
    nit character varying(20)
);
    DROP TABLE public.cliente;
       public         heap    postgres    false            �            1259    24867    cliente_cliente_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cliente_cliente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.cliente_cliente_id_seq;
       public          postgres    false    228            I           0    0    cliente_cliente_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.cliente_cliente_id_seq OWNED BY public.cliente.cliente_id;
          public          postgres    false    227            �            1259    24826    cuenta    TABLE     �   CREATE TABLE public.cuenta (
    cuenta_id integer NOT NULL,
    mesa_id integer,
    estado character varying(20),
    fecha_hora_apertura timestamp without time zone,
    fecha_hora_cierre timestamp without time zone
);
    DROP TABLE public.cuenta;
       public         heap    postgres    false            �            1259    24825    cuenta_cuenta_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cuenta_cuenta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.cuenta_cuenta_id_seq;
       public          postgres    false    220            J           0    0    cuenta_cuenta_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.cuenta_cuenta_id_seq OWNED BY public.cuenta.cuenta_id;
          public          postgres    false    219            �            1259    24950    detallepedido    TABLE     �   CREATE TABLE public.detallepedido (
    detalle_pedido_id integer NOT NULL,
    pedido_id integer,
    producto_id integer,
    cantidad integer,
    mesa_id integer,
    area_id integer
);
 !   DROP TABLE public.detallepedido;
       public         heap    postgres    false            �            1259    24949 #   detallepedido_detalle_pedido_id_seq    SEQUENCE     �   CREATE SEQUENCE public.detallepedido_detalle_pedido_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.detallepedido_detalle_pedido_id_seq;
       public          postgres    false    240            K           0    0 #   detallepedido_detalle_pedido_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.detallepedido_detalle_pedido_id_seq OWNED BY public.detallepedido.detalle_pedido_id;
          public          postgres    false    239            �            1259    24899    encuesta    TABLE     �   CREATE TABLE public.encuesta (
    encuesta_id integer NOT NULL,
    cliente_id integer,
    calificacion_amabilidad integer,
    calificacion_exactitud integer
);
    DROP TABLE public.encuesta;
       public         heap    postgres    false            �            1259    24898    encuesta_encuesta_id_seq    SEQUENCE     �   CREATE SEQUENCE public.encuesta_encuesta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.encuesta_encuesta_id_seq;
       public          postgres    false    234            L           0    0    encuesta_encuesta_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.encuesta_encuesta_id_seq OWNED BY public.encuesta.encuesta_id;
          public          postgres    false    233            �            1259    24875 	   formapago    TABLE     �   CREATE TABLE public.formapago (
    forma_pago_id integer NOT NULL,
    descripcion character varying(100),
    cuenta_id integer
);
    DROP TABLE public.formapago;
       public         heap    postgres    false            �            1259    24874    formapago_forma_pago_id_seq    SEQUENCE     �   CREATE SEQUENCE public.formapago_forma_pago_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.formapago_forma_pago_id_seq;
       public          postgres    false    230            M           0    0    formapago_forma_pago_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.formapago_forma_pago_id_seq OWNED BY public.formapago.forma_pago_id;
          public          postgres    false    229            �            1259    24814    mesa    TABLE     �   CREATE TABLE public.mesa (
    mesa_id integer NOT NULL,
    area_id integer,
    capacidad integer,
    estado character varying(20)
);
    DROP TABLE public.mesa;
       public         heap    postgres    false            �            1259    24813    mesa_mesa_id_seq    SEQUENCE     �   CREATE SEQUENCE public.mesa_mesa_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.mesa_mesa_id_seq;
       public          postgres    false    218            N           0    0    mesa_mesa_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.mesa_mesa_id_seq OWNED BY public.mesa.mesa_id;
          public          postgres    false    217            �            1259    24838    pedido    TABLE     �   CREATE TABLE public.pedido (
    pedido_id integer NOT NULL,
    cuenta_id integer,
    fecha_hora_pedido timestamp without time zone,
    producto_id integer
);
    DROP TABLE public.pedido;
       public         heap    postgres    false            �            1259    24837    pedido_pedido_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pedido_pedido_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.pedido_pedido_id_seq;
       public          postgres    false    222            O           0    0    pedido_pedido_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.pedido_pedido_id_seq OWNED BY public.pedido.pedido_id;
          public          postgres    false    221            �            1259    24850    plato    TABLE     �   CREATE TABLE public.plato (
    plato_id integer NOT NULL,
    nombre character varying(100),
    descripcion text,
    precio numeric(10,2)
);
    DROP TABLE public.plato;
       public         heap    postgres    false            �            1259    24849    plato_plato_id_seq    SEQUENCE     �   CREATE SEQUENCE public.plato_plato_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.plato_plato_id_seq;
       public          postgres    false    224            P           0    0    plato_plato_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.plato_plato_id_seq OWNED BY public.plato.plato_id;
          public          postgres    false    223            �            1259    24887    propina    TABLE     q   CREATE TABLE public.propina (
    propina_id integer NOT NULL,
    pedido_id integer,
    monto numeric(10,2)
);
    DROP TABLE public.propina;
       public         heap    postgres    false            �            1259    24886    propina_propina_id_seq    SEQUENCE     �   CREATE SEQUENCE public.propina_propina_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.propina_propina_id_seq;
       public          postgres    false    232            Q           0    0    propina_propina_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.propina_propina_id_seq OWNED BY public.propina.propina_id;
          public          postgres    false    231            �            1259    24911    queja    TABLE     �   CREATE TABLE public.queja (
    queja_id integer NOT NULL,
    cliente_id integer,
    fecha_hora timestamp without time zone,
    motivo text,
    clasificacion integer,
    persona character varying(50),
    plato_bebida character varying(100)
);
    DROP TABLE public.queja;
       public         heap    postgres    false            �            1259    24910    queja_queja_id_seq    SEQUENCE     �   CREATE SEQUENCE public.queja_queja_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.queja_queja_id_seq;
       public          postgres    false    236            R           0    0    queja_queja_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.queja_queja_id_seq OWNED BY public.queja.queja_id;
          public          postgres    false    235            �            1259    24925    usuarios    TABLE     �   CREATE TABLE public.usuarios (
    usuario_id integer NOT NULL,
    nombre_usuario character varying(50) NOT NULL,
    "contraseña_hash" character varying(128) NOT NULL
);
    DROP TABLE public.usuarios;
       public         heap    postgres    false            �            1259    24924    usuarios_usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuarios_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.usuarios_usuario_id_seq;
       public          postgres    false    238            S           0    0    usuarios_usuario_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.usuarios_usuario_id_seq OWNED BY public.usuarios.usuario_id;
          public          postgres    false    237            a           2604    24810    area area_id    DEFAULT     l   ALTER TABLE ONLY public.area ALTER COLUMN area_id SET DEFAULT nextval('public.area_area_id_seq'::regclass);
 ;   ALTER TABLE public.area ALTER COLUMN area_id DROP DEFAULT;
       public          postgres    false    215    216    216            f           2604    24862    bebida bebida_id    DEFAULT     t   ALTER TABLE ONLY public.bebida ALTER COLUMN bebida_id SET DEFAULT nextval('public.bebida_bebida_id_seq'::regclass);
 ?   ALTER TABLE public.bebida ALTER COLUMN bebida_id DROP DEFAULT;
       public          postgres    false    225    226    226            g           2604    24871    cliente cliente_id    DEFAULT     x   ALTER TABLE ONLY public.cliente ALTER COLUMN cliente_id SET DEFAULT nextval('public.cliente_cliente_id_seq'::regclass);
 A   ALTER TABLE public.cliente ALTER COLUMN cliente_id DROP DEFAULT;
       public          postgres    false    228    227    228            c           2604    24829    cuenta cuenta_id    DEFAULT     t   ALTER TABLE ONLY public.cuenta ALTER COLUMN cuenta_id SET DEFAULT nextval('public.cuenta_cuenta_id_seq'::regclass);
 ?   ALTER TABLE public.cuenta ALTER COLUMN cuenta_id DROP DEFAULT;
       public          postgres    false    219    220    220            m           2604    24953    detallepedido detalle_pedido_id    DEFAULT     �   ALTER TABLE ONLY public.detallepedido ALTER COLUMN detalle_pedido_id SET DEFAULT nextval('public.detallepedido_detalle_pedido_id_seq'::regclass);
 N   ALTER TABLE public.detallepedido ALTER COLUMN detalle_pedido_id DROP DEFAULT;
       public          postgres    false    239    240    240            j           2604    24902    encuesta encuesta_id    DEFAULT     |   ALTER TABLE ONLY public.encuesta ALTER COLUMN encuesta_id SET DEFAULT nextval('public.encuesta_encuesta_id_seq'::regclass);
 C   ALTER TABLE public.encuesta ALTER COLUMN encuesta_id DROP DEFAULT;
       public          postgres    false    234    233    234            h           2604    24878    formapago forma_pago_id    DEFAULT     �   ALTER TABLE ONLY public.formapago ALTER COLUMN forma_pago_id SET DEFAULT nextval('public.formapago_forma_pago_id_seq'::regclass);
 F   ALTER TABLE public.formapago ALTER COLUMN forma_pago_id DROP DEFAULT;
       public          postgres    false    230    229    230            b           2604    24817    mesa mesa_id    DEFAULT     l   ALTER TABLE ONLY public.mesa ALTER COLUMN mesa_id SET DEFAULT nextval('public.mesa_mesa_id_seq'::regclass);
 ;   ALTER TABLE public.mesa ALTER COLUMN mesa_id DROP DEFAULT;
       public          postgres    false    218    217    218            d           2604    24841    pedido pedido_id    DEFAULT     t   ALTER TABLE ONLY public.pedido ALTER COLUMN pedido_id SET DEFAULT nextval('public.pedido_pedido_id_seq'::regclass);
 ?   ALTER TABLE public.pedido ALTER COLUMN pedido_id DROP DEFAULT;
       public          postgres    false    221    222    222            e           2604    24853    plato plato_id    DEFAULT     p   ALTER TABLE ONLY public.plato ALTER COLUMN plato_id SET DEFAULT nextval('public.plato_plato_id_seq'::regclass);
 =   ALTER TABLE public.plato ALTER COLUMN plato_id DROP DEFAULT;
       public          postgres    false    223    224    224            i           2604    24890    propina propina_id    DEFAULT     x   ALTER TABLE ONLY public.propina ALTER COLUMN propina_id SET DEFAULT nextval('public.propina_propina_id_seq'::regclass);
 A   ALTER TABLE public.propina ALTER COLUMN propina_id DROP DEFAULT;
       public          postgres    false    232    231    232            k           2604    24914    queja queja_id    DEFAULT     p   ALTER TABLE ONLY public.queja ALTER COLUMN queja_id SET DEFAULT nextval('public.queja_queja_id_seq'::regclass);
 =   ALTER TABLE public.queja ALTER COLUMN queja_id DROP DEFAULT;
       public          postgres    false    235    236    236            l           2604    24928    usuarios usuario_id    DEFAULT     z   ALTER TABLE ONLY public.usuarios ALTER COLUMN usuario_id SET DEFAULT nextval('public.usuarios_usuario_id_seq'::regclass);
 B   ALTER TABLE public.usuarios ALTER COLUMN usuario_id DROP DEFAULT;
       public          postgres    false    237    238    238            (          0    24807    area 
   TABLE DATA           G   COPY public.area (area_id, nombre, tipo, capacidad_maxima) FROM stdin;
    public          postgres    false    216   �       2          0    24859    bebida 
   TABLE DATA           H   COPY public.bebida (bebida_id, nombre, descripcion, precio) FROM stdin;
    public          postgres    false    226   %�       4          0    24868    cliente 
   TABLE DATA           E   COPY public.cliente (cliente_id, nombre, direccion, nit) FROM stdin;
    public          postgres    false    228   ��       ,          0    24826    cuenta 
   TABLE DATA           d   COPY public.cuenta (cuenta_id, mesa_id, estado, fecha_hora_apertura, fecha_hora_cierre) FROM stdin;
    public          postgres    false    220   ��       @          0    24950    detallepedido 
   TABLE DATA           n   COPY public.detallepedido (detalle_pedido_id, pedido_id, producto_id, cantidad, mesa_id, area_id) FROM stdin;
    public          postgres    false    240   Ò       :          0    24899    encuesta 
   TABLE DATA           l   COPY public.encuesta (encuesta_id, cliente_id, calificacion_amabilidad, calificacion_exactitud) FROM stdin;
    public          postgres    false    234   ��       6          0    24875 	   formapago 
   TABLE DATA           J   COPY public.formapago (forma_pago_id, descripcion, cuenta_id) FROM stdin;
    public          postgres    false    230   ��       *          0    24814    mesa 
   TABLE DATA           C   COPY public.mesa (mesa_id, area_id, capacidad, estado) FROM stdin;
    public          postgres    false    218   �       .          0    24838    pedido 
   TABLE DATA           V   COPY public.pedido (pedido_id, cuenta_id, fecha_hora_pedido, producto_id) FROM stdin;
    public          postgres    false    222   H�       0          0    24850    plato 
   TABLE DATA           F   COPY public.plato (plato_id, nombre, descripcion, precio) FROM stdin;
    public          postgres    false    224   e�       8          0    24887    propina 
   TABLE DATA           ?   COPY public.propina (propina_id, pedido_id, monto) FROM stdin;
    public          postgres    false    232   ��       <          0    24911    queja 
   TABLE DATA           o   COPY public.queja (queja_id, cliente_id, fecha_hora, motivo, clasificacion, persona, plato_bebida) FROM stdin;
    public          postgres    false    236   ͓       >          0    24925    usuarios 
   TABLE DATA           R   COPY public.usuarios (usuario_id, nombre_usuario, "contraseña_hash") FROM stdin;
    public          postgres    false    238   �       T           0    0    area_area_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.area_area_id_seq', 1, true);
          public          postgres    false    215            U           0    0    bebida_bebida_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.bebida_bebida_id_seq', 2, true);
          public          postgres    false    225            V           0    0    cliente_cliente_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.cliente_cliente_id_seq', 1, false);
          public          postgres    false    227            W           0    0    cuenta_cuenta_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.cuenta_cuenta_id_seq', 1, false);
          public          postgres    false    219            X           0    0 #   detallepedido_detalle_pedido_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.detallepedido_detalle_pedido_id_seq', 1, false);
          public          postgres    false    239            Y           0    0    encuesta_encuesta_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.encuesta_encuesta_id_seq', 1, false);
          public          postgres    false    233            Z           0    0    formapago_forma_pago_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.formapago_forma_pago_id_seq', 1, false);
          public          postgres    false    229            [           0    0    mesa_mesa_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.mesa_mesa_id_seq', 2, true);
          public          postgres    false    217            \           0    0    pedido_pedido_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.pedido_pedido_id_seq', 1, false);
          public          postgres    false    221            ]           0    0    plato_plato_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.plato_plato_id_seq', 1, true);
          public          postgres    false    223            ^           0    0    propina_propina_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.propina_propina_id_seq', 1, false);
          public          postgres    false    231            _           0    0    queja_queja_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.queja_queja_id_seq', 1, false);
          public          postgres    false    235            `           0    0    usuarios_usuario_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.usuarios_usuario_id_seq', 8, true);
          public          postgres    false    237            o           2606    24812    area area_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (area_id);
 8   ALTER TABLE ONLY public.area DROP CONSTRAINT area_pkey;
       public            postgres    false    216            y           2606    24866    bebida bebida_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.bebida
    ADD CONSTRAINT bebida_pkey PRIMARY KEY (bebida_id);
 <   ALTER TABLE ONLY public.bebida DROP CONSTRAINT bebida_pkey;
       public            postgres    false    226            {           2606    24873    cliente cliente_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cliente_id);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public            postgres    false    228            s           2606    24831    cuenta cuenta_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.cuenta
    ADD CONSTRAINT cuenta_pkey PRIMARY KEY (cuenta_id);
 <   ALTER TABLE ONLY public.cuenta DROP CONSTRAINT cuenta_pkey;
       public            postgres    false    220            �           2606    24955     detallepedido detallepedido_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.detallepedido
    ADD CONSTRAINT detallepedido_pkey PRIMARY KEY (detalle_pedido_id);
 J   ALTER TABLE ONLY public.detallepedido DROP CONSTRAINT detallepedido_pkey;
       public            postgres    false    240            �           2606    24904    encuesta encuesta_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.encuesta
    ADD CONSTRAINT encuesta_pkey PRIMARY KEY (encuesta_id);
 @   ALTER TABLE ONLY public.encuesta DROP CONSTRAINT encuesta_pkey;
       public            postgres    false    234            }           2606    24880    formapago formapago_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.formapago
    ADD CONSTRAINT formapago_pkey PRIMARY KEY (forma_pago_id);
 B   ALTER TABLE ONLY public.formapago DROP CONSTRAINT formapago_pkey;
       public            postgres    false    230            q           2606    24819    mesa mesa_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.mesa
    ADD CONSTRAINT mesa_pkey PRIMARY KEY (mesa_id);
 8   ALTER TABLE ONLY public.mesa DROP CONSTRAINT mesa_pkey;
       public            postgres    false    218            u           2606    24843    pedido pedido_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_pkey PRIMARY KEY (pedido_id);
 <   ALTER TABLE ONLY public.pedido DROP CONSTRAINT pedido_pkey;
       public            postgres    false    222            w           2606    24857    plato plato_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.plato
    ADD CONSTRAINT plato_pkey PRIMARY KEY (plato_id);
 :   ALTER TABLE ONLY public.plato DROP CONSTRAINT plato_pkey;
       public            postgres    false    224                       2606    24892    propina propina_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.propina
    ADD CONSTRAINT propina_pkey PRIMARY KEY (propina_id);
 >   ALTER TABLE ONLY public.propina DROP CONSTRAINT propina_pkey;
       public            postgres    false    232            �           2606    24918    queja queja_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.queja
    ADD CONSTRAINT queja_pkey PRIMARY KEY (queja_id);
 :   ALTER TABLE ONLY public.queja DROP CONSTRAINT queja_pkey;
       public            postgres    false    236            �           2606    24932 $   usuarios usuarios_nombre_usuario_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_nombre_usuario_key UNIQUE (nombre_usuario);
 N   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_nombre_usuario_key;
       public            postgres    false    238            �           2606    24930    usuarios usuarios_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (usuario_id);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public            postgres    false    238            �           2606    24832    cuenta cuenta_mesa_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.cuenta
    ADD CONSTRAINT cuenta_mesa_id_fkey FOREIGN KEY (mesa_id) REFERENCES public.mesa(mesa_id);
 D   ALTER TABLE ONLY public.cuenta DROP CONSTRAINT cuenta_mesa_id_fkey;
       public          postgres    false    218    220    4721            �           2606    24956 *   detallepedido detallepedido_pedido_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallepedido
    ADD CONSTRAINT detallepedido_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES public.pedido(pedido_id);
 T   ALTER TABLE ONLY public.detallepedido DROP CONSTRAINT detallepedido_pedido_id_fkey;
       public          postgres    false    222    240    4725            �           2606    24961 ,   detallepedido detallepedido_producto_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallepedido
    ADD CONSTRAINT detallepedido_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.plato(plato_id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.detallepedido DROP CONSTRAINT detallepedido_producto_id_fkey;
       public          postgres    false    224    240    4727            �           2606    24966 -   detallepedido detallepedido_producto_id_fkey1    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallepedido
    ADD CONSTRAINT detallepedido_producto_id_fkey1 FOREIGN KEY (producto_id) REFERENCES public.bebida(bebida_id) ON DELETE CASCADE;
 W   ALTER TABLE ONLY public.detallepedido DROP CONSTRAINT detallepedido_producto_id_fkey1;
       public          postgres    false    4729    240    226            �           2606    24905 !   encuesta encuesta_cliente_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.encuesta
    ADD CONSTRAINT encuesta_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(cliente_id);
 K   ALTER TABLE ONLY public.encuesta DROP CONSTRAINT encuesta_cliente_id_fkey;
       public          postgres    false    234    228    4731            �           2606    24976    detallepedido fk_area_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallepedido
    ADD CONSTRAINT fk_area_id FOREIGN KEY (area_id) REFERENCES public.area(area_id) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.detallepedido DROP CONSTRAINT fk_area_id;
       public          postgres    false    216    240    4719            �           2606    24944    pedido fk_bebida_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_bebida_id FOREIGN KEY (producto_id) REFERENCES public.bebida(bebida_id) ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.pedido DROP CONSTRAINT fk_bebida_id;
       public          postgres    false    222    4729    226            �           2606    24971    detallepedido fk_mesa_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.detallepedido
    ADD CONSTRAINT fk_mesa_id FOREIGN KEY (mesa_id) REFERENCES public.mesa(mesa_id) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.detallepedido DROP CONSTRAINT fk_mesa_id;
       public          postgres    false    4721    240    218            �           2606    24939    pedido fk_producto_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT fk_producto_id FOREIGN KEY (producto_id) REFERENCES public.plato(plato_id) ON DELETE CASCADE;
 ?   ALTER TABLE ONLY public.pedido DROP CONSTRAINT fk_producto_id;
       public          postgres    false    222    224    4727            �           2606    24881 "   formapago formapago_cuenta_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.formapago
    ADD CONSTRAINT formapago_cuenta_id_fkey FOREIGN KEY (cuenta_id) REFERENCES public.cuenta(cuenta_id);
 L   ALTER TABLE ONLY public.formapago DROP CONSTRAINT formapago_cuenta_id_fkey;
       public          postgres    false    220    4723    230            �           2606    24820    mesa mesa_area_id_fkey    FK CONSTRAINT     y   ALTER TABLE ONLY public.mesa
    ADD CONSTRAINT mesa_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.area(area_id);
 @   ALTER TABLE ONLY public.mesa DROP CONSTRAINT mesa_area_id_fkey;
       public          postgres    false    216    4719    218            �           2606    24844    pedido pedido_cuenta_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedido
    ADD CONSTRAINT pedido_cuenta_id_fkey FOREIGN KEY (cuenta_id) REFERENCES public.cuenta(cuenta_id);
 F   ALTER TABLE ONLY public.pedido DROP CONSTRAINT pedido_cuenta_id_fkey;
       public          postgres    false    4723    220    222            �           2606    24893    propina propina_pedido_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.propina
    ADD CONSTRAINT propina_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES public.pedido(pedido_id);
 H   ALTER TABLE ONLY public.propina DROP CONSTRAINT propina_pedido_id_fkey;
       public          postgres    false    222    232    4725            �           2606    24919    queja queja_cliente_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.queja
    ADD CONSTRAINT queja_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.cliente(cliente_id);
 E   ALTER TABLE ONLY public.queja DROP CONSTRAINT queja_cliente_id_fkey;
       public          postgres    false    228    4731    236            (   #   x�3��J,J9�6�ӵ�$�(3���Д+F��� �E      2   T   x�3�t�ON�u��I��KT���2S�Ҋ29����8}2s��S 
s����T�������Ԣ�bNCS=�=... ni�      4      x������ � �      ,      x������ � �      @      x������ � �      :      x������ � �      6      x������ � �      *      x�3�4�4���L*J�2����=... Z�      .      x������ � �      0   ;   x�3�Ȭ�JTHIU(,M-�WH-*��K���KT( ��($��Ad9M��b���� @�      8      x������ � �      <      x������ � �      >   >  x�Uйv�@ @њ�k�J� ��q8i@�U ����'�$����#�	-e�'�f$	��P�����;Ml�bC�7�C�9a����W��)��v?Q���p����A�O�����t)��k�K��4��4��M�t��{��ˈ ��:.vb�ž
sa�6�K8�K�/d�[�p�&˯�i�t������]A��q�Q#��Ȩ:K���.�#���%�]��YIr�A�K["�k$y�{GR�����QݵVt`�����J���ҋi��'�ڣC�0Y���e��[6�aDA���շ��#��O!#� � >��     