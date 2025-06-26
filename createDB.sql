-- Script de Base de Datos: Bienes y Concesiones - COMPLETO
-- Versión completa para SQL Server 2022

USE DGBIDB;
GO

-- ==============================================
-- CREAR ESQUEMA SI NO EXISTE
-- ==============================================
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'dbo')
BEGIN
    EXEC('CREATE SCHEMA dbo');
END;
GO

-- ==============================================
-- TABLAS PRINCIPALES DEL SISTEMA SIGAF
-- ==============================================

-- Tabla 01: Relación BAC SIGAF
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '01_RELACION_BAC_SIGAF')
BEGIN
    CREATE TABLE dbo.[01_RELACION_BAC_SIGAF] (
        id_oc_bac varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        o_ente varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        aa_ocompra varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        t_ocompra varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        n_ocompra varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
    );
    PRINT 'Tabla [01_RELACION_BAC_SIGAF] creada exitosamente';
END;
GO

-- Tabla 02: SPR Renglones  
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '02_SPR_RENGLONES')
BEGIN
    CREATE TABLE dbo.[02_SPR_RENGLONES] (
        aa_oca_original varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_oca_original varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_ente varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        aa_ocompra varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        t_ocompra varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        n_ocompra varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        c_unid_ejec varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fh_estado datetime NOT NULL,
        fh_alta datetime NOT NULL,
        fh_autorizacion datetime NULL,
        n_renglon_pliego varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        k_adjudicada decimal(15,2) NOT NULL,
        i_unitario decimal(15,2) NOT NULL,
        total_renglon decimal(15,2) NULL,
        e_ocompra char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        [Total renglon] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [02_SPR_RENGLONES] creada exitosamente';
END;
GO

-- Tabla 03: SPR Imputaciones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '03_SPR_IMPUTACIONES')
BEGIN
    CREATE TABLE dbo.[03_SPR_IMPUTACIONES] (
        aa_ocompra varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        t_ocompra varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        n_ocompra varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        o_ente varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        c_unid_ejec varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        aa_oca_original varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        n_oca_original varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        fh_estado datetime NOT NULL,
        e_ocompra char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        c_numcred varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        c_juris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        c_sjuris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        c_entidad varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        c_inciso varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        c_pprincipal varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        c_pparcial varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        c_ubica_geo varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        i_total decimal(15,2) NOT NULL
    );
    PRINT 'Tabla [03_SPR_IMPUTACIONES] creada exitosamente';
END;
GO

-- Tabla 04: RPR SPR PRD
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '04_RPR_SPR_PRD')
BEGIN
    CREATE TABLE dbo.[04_RPR_SPR_PRD] (
        aa_oca_original varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_oca_original varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_rprovision varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_rprovision varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_rprovision varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_ente varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_juris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_sjuris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_entidad varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_unid_ejec varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        f_desde date NULL,
        f_hasta date NULL,
        fh_autorizacion datetime NULL,
        fh_alta datetime NULL,
        t_ocompra varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_ocompra varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_precepcion varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_precepcion varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_precepcion varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        e_rprovision char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [04_RPR_SPR_PRD] creada exitosamente';
END;
GO

-- Tabla 05: RPR Renglones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '05_RPR_RENGLONES')
BEGIN
    CREATE TABLE dbo.[05_RPR_RENGLONES] (
        aa_oca_original varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_oca_original varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_rprovision varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_rprovision varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_rprovision varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_ente varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_juris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_sjuris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_entidad varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_unid_ejec varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        f_desde date NULL,
        f_hasta date NULL,
        fh_autorizacion datetime NULL,
        n_renglon_pliego varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        k_rdefinitiva decimal(15,6) NULL,
        i_unitario decimal(15,2) NULL,
        total_renglon decimal(15,2) NULL,
        e_rprovision char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [Total renglon] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [05_RPR_RENGLONES] creada exitosamente';
END;
GO

-- Tabla 06: RPR Imputaciones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '06_RPR_IMPUTACIONES')
BEGIN
    CREATE TABLE dbo.[06_RPR_IMPUTACIONES] (
        aa_oca_original varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_oca_original varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_rprovision varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_rprovision varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_rprovision varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_unid_ejec varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        f_desde date NULL,
        f_hasta date NULL,
        fh_autorizacion datetime NULL,
        c_numcred varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_juris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_sjuris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_entidad varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_ubica_geo varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_inciso varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_pprincipal varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_pparcial varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        i_total decimal(15,2) NULL,
        e_rprovision char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [06_RPR_IMPUTACIONES] creada exitosamente';
END;
GO

-- Tabla 07: PRD Renglones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '07_PRD_RENGLONES')
BEGIN
    CREATE TABLE dbo.[07_PRD_RENGLONES] (
        aa_oca_original varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_oca_original varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_ente varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        i_total_adjudicacion decimal(15,2) NULL,
        aa_precepcion varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_precepcion varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_precepcion varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_rprovision varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_rprovision varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_rprovision varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        e_formulario char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        f_desde varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        f_hasta varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_unid_ejec varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_renglon_pliego varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        k_rdefinitiva decimal(15,6) NULL,
        i_unitario decimal(15,2) NULL,
        k_rdefinitiva_x_i_unitario decimal(15,2) NULL,
        fh_alta varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fh_autorizacion varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fh_firma varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_precepcion_1 varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [RENPRD.K_RDEFINITIVA*RENPRD.I_UNITARIO] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [07_PRD_RENGLONES] creada exitosamente';
END;
GO

-- Tabla 08: PRD Imputaciones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '08_PRD_IMPUTACIONES')
BEGIN
    CREATE TABLE dbo.[08_PRD_IMPUTACIONES] (
        aa_oca_original varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_oca_original varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_precepcion varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_precepcion varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_precepcion varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_numcred varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_juris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_sjuris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_entidad varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_inciso varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_pprincipal varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_pparcial varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_ubica_geo varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        i_total decimal(15,2) NULL,
        e_formulario char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [08_PRD_IMPUTACIONES] creada exitosamente';
END;
GO

-- Tabla 09: PRD Facturas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '09_PRD_FACTURAS')
BEGIN
    CREATE TABLE dbo.[09_PRD_FACTURAS] (
        aa_oca_original varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_oca_original varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_precepcion varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_precepcion varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_precepcion varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_factura varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_factura varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        e_factura_1 char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        e_factura_2 char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_fact_proveedor varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_suc_fact_proveedor varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_fact_proveedor varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        f_factura datetime NULL,
        fhu_actualiz datetime NULL,
        n_renglon_pliego varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        k_facturada decimal(15,6) NULL,
        i_unitario decimal(15,2) NULL,
        e_factura varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [09_PRD_FACTURAS] creada exitosamente';
END;
GO

-- Tabla 10: Facturas OP Pagos
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '10_FACTURAS_OP_PAGOS')
BEGIN
    CREATE TABLE dbo.[10_FACTURAS_OP_PAGOS] (
        aa_ocompra varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_ocompra varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_factura varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_factura varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_factura varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_precepcion varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_precepcion varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_precepcion varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_formulario varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_formulario varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_formulario varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        f_emision datetime NULL,
        f_autorizacion datetime NULL,
        f_vencimiento_factura datetime NULL,
        fh_pago datetime NULL,
        e_firma char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        u_firma varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        f_firma datetime NULL,
        importe_op decimal(15,2) NULL,
        importe_pago decimal(15,2) NULL,
        importe_factura decimal(15,2) NULL,
        neto decimal(15,2) NULL,
        c_mediopago varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        e_pago char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [10_FACTURAS_OP_PAGOS] creada exitosamente';
END;
GO

-- Tabla 11: RP
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '11_RP')
BEGIN
    CREATE TABLE dbo.[11_RP] (
        aa_ocompra varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_orden_redet varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        e_redeterminacion char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        f_aplicacion varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_redeterminacion varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_renglon_pliego varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        i_unitario_ant decimal(15,2) NULL,
        n_porc_redet decimal(8,2) NULL,
        i_unitario_redet decimal(15,2) NULL,
        diferencia_redet decimal(15,2) NULL,
        fh_alta varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fh_autorizacion varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [11_RP] creada exitosamente';
END;
GO

-- Tabla 12: DRP Renglones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '12_DRP_RENGLONES')
BEGIN
    CREATE TABLE dbo.[12_DRP_RENGLONES] (
        aa_ocompra varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_devengado varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_devengado varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_devengado varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_ente varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_rprovision varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_rprovision varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_rprovision varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_orden_redet varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_redeterminacion varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_renglon_pliego varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        k_rdefinitiva decimal(15,6) NULL,
        i_variacion decimal(15,6) NULL,
        e_devengado char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fh_alta varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        f_autorizacion varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fh_firma varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [12_DRP_RENGLONES] creada exitosamente';
END;
GO

-- Tabla 13: DRP Imputaciones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '13_DRP_IMPUTACIONES')
BEGIN
    CREATE TABLE dbo.[13_DRP_IMPUTACIONES] (
        aa_ocompra varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_devengado varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_devengado varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_devengado varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_numcred varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_juris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_sjuris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_entidad varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_programa varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_inciso varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_pprincipal varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_pparcial varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_psparcial varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_ubica_geo varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        i_devengado decimal(15,2) NULL,
        e_devengado char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [13_DRP_IMPUTACIONES] creada exitosamente';
END;
GO

-- Tabla 14: DRP Facturas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '14_DRP_FACTURAS')
BEGIN
    CREATE TABLE dbo.[14_DRP_FACTURAS] (
        aa_ocompra varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_certificado varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_form_medicion varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_certificado varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_factura varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_factura varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_factura varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        e_factura char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_fact_proveedor varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_suc_fact_proveedor varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_fact_proveedor varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        f_factura datetime NULL,
        fh_alta datetime NULL,
        f_autorizacion datetime NULL,
        c_numcred varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_juris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_sjuris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_entidad varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_programa varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_inciso varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_pprincipal varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_pparcial varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_psparcial varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_ubica_geo varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        i_devengado decimal(15,2) NULL,
        i_pagado decimal(15,2) NULL
    );
    PRINT 'Tabla [14_DRP_FACTURAS] creada exitosamente';
END;
GO

-- Tabla 15: DRP Facturas Pagos
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '15_DRP_FACTURAS_PAGOS')
BEGIN
    CREATE TABLE dbo.[15_DRP_FACTURAS_PAGOS] (
        aa_ocompra varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_factura varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_factura varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_factura varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        e_factura char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_devengado varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_devengado varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_devengado varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_devengado varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_formulario varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_formulario varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_formulario varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fh_alta datetime NULL,
        f_autorizacion datetime NULL,
        f_vencimiento_factura datetime NULL,
        f_firma datetime NULL,
        fh_pago datetime NULL,
        e_firma char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        u_firma varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        importe_op decimal(15,2) NULL,
        ia_pagado decimal(15,2) NULL,
        importe_neto decimal(15,2) NULL,
        c_mediopago varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        e_pago char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [15_DRP_FACTURAS_PAGOS] creada exitosamente';
END;
GO

-- Tabla 16: Preciario
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '16_PRECIARIO')
BEGIN
    CREATE TABLE dbo.[16_PRECIARIO] (
        aa_ocompra varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_ocompra varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        e_ocompra char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_ente varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fh_estado datetime NULL,
        aa_ocompra_orig varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_ocompra_orig varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra_orig varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_procedimiento varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_renglon_pliego varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        xl_descripcion varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        k_adjudicada decimal(15,6) NULL,
        i_unitario decimal(15,2) NULL,
        total_renglon decimal(15,2) NULL,
        fh_alta datetime NULL,
        fh_autorizacion datetime NULL,
        [Total renglon] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [16_PRECIARIO] creada exitosamente';
END;
GO

-- Tabla 17: Preciario Imputaciones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '17_PRECIARIO_IMPUTACIONES')
BEGIN
    CREATE TABLE dbo.[17_PRECIARIO_IMPUTACIONES] (
        aa_ocompra varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_ocompra varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        e_ocompra char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fh_estado datetime NULL,
        o_ente varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_ocompra_orig varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_ocompra_orig varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra_orig varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_procedimiento varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_numcred varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_juris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_sjuris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_entidad varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_inciso varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_pprincipal varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_pparcial varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_ubica_geo varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        i_total decimal(15,2) NULL
    );
    PRINT 'Tabla [17_PRECIARIO_IMPUTACIONES] creada exitosamente';
END;
GO

-- Tabla 18: PRD Preciario
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '18_PRD_PRECIARIO')
BEGIN
    CREATE TABLE dbo.[18_PRD_PRECIARIO] (
        t_ocompra varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_ocompra varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_precepcion varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_precepcion varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_precepcion varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_ente varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_unid_ejec varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fh_autorizacion datetime NULL,
        fh_alta datetime NULL,
        aa_ocompra_orig varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_ocompra_orig varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra_orig varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        e_formulario char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [18_PRD_PRECIARIO] creada exitosamente';
END;
GO

-- Tabla 19: PRD Preciario Renglones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '19_PRD_PRECIARIO_RENGLONES')
BEGIN
    CREATE TABLE dbo.[19_PRD_PRECIARIO_RENGLONES] (
        aa_ocompra varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_ocompra varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_precepcion varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_precepcion varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_precepcion varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_ente varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_ocompra_orig varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_ocompra_orig varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra_orig varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_unid_ejec varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fh_autorizacion datetime NULL,
        f_desde datetime NULL,
        f_hasta datetime NULL,
        n_renglon_pliego varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        xl_descripcion varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        k_rdefinitiva decimal(15,6) NULL,
        i_unitario decimal(15,2) NULL,
        total_renglon decimal(15,2) NULL,
        e_formulario char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [Total renglon] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [19_PRD_PRECIARIO_RENGLONES] creada exitosamente';
END;
GO

-- Tabla 20: PRD Preciario Imputaciones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '20_PRD_PRECIARIO_IMPUTACIONES')
BEGIN
    CREATE TABLE dbo.[20_PRD_PRECIARIO_IMPUTACIONES] (
        aa_ocompra varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_ocompra varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_precepcion varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_precepcion varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_precepcion varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_ocompra_orig varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_ocompra_orig varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra_orig varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_unid_ejec varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fh_autorizacion datetime NULL,
        f_desde datetime NULL,
        f_hasta datetime NULL,
        c_numcred varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_juris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_sjuris varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_entidad varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_inciso varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_pprincipal varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_pparcial varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_ubica_geo varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        i_total decimal(15,2) NULL,
        e_formulario char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_ente int NULL
    );
    PRINT 'Tabla [20_PRD_PRECIARIO_IMPUTACIONES] creada exitosamente';
END;
GO

-- Tabla 21: PRD Preciario Facturas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '21_PRD_PRECIARIO_FACTURAS')
BEGIN
    CREATE TABLE dbo.[21_PRD_PRECIARIO_FACTURAS] (
        aa_ocompra varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_ocompra varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_precepcion varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_precepcion varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_precepcion varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_factura varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_factura varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_factura varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_ocompra_orig varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_ocompra_orig varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra_orig varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        c_unid_ejec varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fh_autorizacion datetime NULL,
        f_desde datetime NULL,
        f_hasta datetime NULL,
        n_renglon_pliego varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        xl_descripcion varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        k_facturada decimal(15,6) NULL,
        i_unitario decimal(15,2) NULL,
        total_renglon decimal(15,2) NULL,
        t_fact_proveedor varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_suc_fact_proveedor varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_fact_proveedor varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        f_factura datetime NULL,
        e_formulario char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        e_factura varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fhu_actualiz varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [Total renglon] varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [21_PRD_PRECIARIO_FACTURAS] creada exitosamente';
END;
GO

-- Tabla 22: Pagos Preciario
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '22_PAGOS_PRECIARIO')
BEGIN
    CREATE TABLE dbo.[22_PAGOS_PRECIARIO] (
        aa_ocompra varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_ocompra varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_ocompra varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_factura varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_factura varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_factura varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_precepcion varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_precepcion varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        n_precepcion varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        aa_formulario varchar(4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        t_formulario varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        o_formulario varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        f_emision datetime NULL,
        f_autorizacion datetime NULL,
        f_firma datetime NULL,
        f_vencimiento_factura datetime NULL,
        fh_pago datetime NULL,
        e_firma char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        u_firma varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        importe_op decimal(15,2) NULL,
        importe_pago decimal(15,2) NULL,
        importe_factura decimal(15,2) NULL,
        neto decimal(15,2) NULL,
        c_mediopago varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        e_pago char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [22_PAGOS_PRECIARIO] creada exitosamente';
END;
GO

-- Tabla 23: Unidades Ejecutoras
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '23_UNIDADES_EJECUTORAS')
BEGIN
    CREATE TABLE dbo.[23_UNIDADES_EJECUTORAS] (
        c_unid_ejec varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        xl_unid_ejec varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [23_UNIDADES_EJECUTORAS] creada exitosamente';
END;
GO

-- Tabla 24: Periodos Fiscales
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '24_PERIODOS_FISCALES')
BEGIN
    CREATE TABLE dbo.[24_PERIODOS_FISCALES] (
        año int NOT NULL
    );
    PRINT 'Tabla [24_PERIODOS_FISCALES] creada exitosamente';
END;
GO

-- Tabla 25: Entes
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '25_ENTES')
BEGIN
    CREATE TABLE dbo.[25_ENTES] (
        o_ente varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL PRIMARY KEY,
        denom_ente varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        nro_oc_sigaf varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla [25_ENTES] creada exitosamente';
END;
GO

-- ==============================================
-- TABLAS DE BIENES
-- ==============================================

-- Tabla: Bienes Beneficiarios
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Bienes_01_BENEFICIARIOS')
BEGIN
    CREATE TABLE dbo.Bienes_01_BENEFICIARIOS (
        id int IDENTITY(1,1) PRIMARY KEY,
        documento_tipo varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        documento varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        nombre varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        email varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        emailadicional varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        telefono varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        tipo_persona varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        fechanacimiento datetime NULL,
        sexo char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        activo char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL DEFAULT 'S',
        tipo_domicilio varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        calle varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        piso varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        dpto varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        localidad varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        codigo_postal varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        fecha_registro datetime DEFAULT GETDATE()
    );
    PRINT 'Tabla Bienes_01_BENEFICIARIOS creada exitosamente';
END;
GO

-- Tabla: Bienes Carteras
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Bienes_02_CARTERAS')
BEGIN
    CREATE TABLE dbo.Bienes_02_CARTERAS (
        id int IDENTITY(1,1) PRIMARY KEY,
        barrio varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        ley int NULL,
        identificacion varchar(64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        circunscripcion int NULL,
        seccion int NULL,
        manzana int NULL,
        parcela int NULL,
        division varchar(64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        tipo_unidad varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        nrounidad int NULL,
        piso varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        depto varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        telefono varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        partidaunidad varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        digitoverificador varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        tipoplano varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        valuacionfiscal decimal(15,2) NULL,
        nueva char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        mtstotales decimal(10,2) NULL,
        mtscubiertos decimal(10,2) NULL,
        habilitado char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL DEFAULT 'S'
    );
    PRINT 'Tabla Bienes_02_CARTERAS creada exitosamente';
END;
GO

-- Tabla: Bienes Contratos
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Bienes_03_CONTRATOS')
BEGIN
    CREATE TABLE dbo.Bienes_03_CONTRATOS (
        id int IDENTITY(1,1) PRIMARY KEY,
        nro int NOT NULL,
        expediente varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fechafirma datetime NOT NULL,
        tipo_contrato varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        tipo_calculo varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        tipo_unidad varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        identificacion varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        descripcion varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        nrounidad varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        vigente char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        nombre varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        documento varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        desde datetime NOT NULL,
        hasta datetime NOT NULL,
        principal char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
    );
    PRINT 'Tabla Bienes_03_CONTRATOS creada exitosamente';
END;
GO

-- Tabla: Bienes Plan de Pagos
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Bienes_04_PLAN_DE_PAGOS')
BEGIN
    CREATE TABLE dbo.Bienes_04_PLAN_DE_PAGOS (
        id int IDENTITY(1,1) PRIMARY KEY,
        tipo varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        objetivo_prestacion varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        nombre varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        documento varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        email varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        emailadicional varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        tipo_persona varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        calle varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        carpeta varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        identificacion varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        sub_division varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        nrounidad varchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        tipo_contrato varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        tipo_calculo varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        resp_adjudicatatio varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        documento1 varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        fecha_creacion datetime NOT NULL,
        nro_expediente varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        observaciones varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        numero varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        vencimiento datetime NULL,
        fechabui datetime NULL,
        total decimal(12,2) NULL,
        observacion varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        estado varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fechapago datetime NULL,
        resp_cumplimiento varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        cuil varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
        legajo varchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
    );
    PRINT 'Tabla Bienes_04_PLAN_DE_PAGOS creada exitosamente';
END;
GO

-- ==============================================
-- TABLAS DE CONCESIONES  
-- ==============================================

-- Tabla: Concesiones Beneficiarios
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Concesiones_01_BENEFICIARIOS')
BEGIN
    CREATE TABLE dbo.Concesiones_01_BENEFICIARIOS (
        id int IDENTITY(1,1) PRIMARY KEY,
        documento_tipo varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        documento varchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        nombre varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        email varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        emailadicional varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        tipo_persona varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fechanacimiento datetime NULL,
        sexo char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        telefono varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        activo char(1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL DEFAULT 'S',
        tipo_domicilio varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        calle varchar(300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        piso varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        dpto varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        localidad varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        codigo_postal varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fecha_registro datetime DEFAULT GETDATE()
    );
    PRINT 'Tabla Concesiones_01_BENEFICIARIOS creada exitosamente';
END;
GO

-- Tabla: Concesiones Carteras
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Concesiones_02_CARTERAS')
BEGIN
    CREATE TABLE dbo.Concesiones_02_CARTERAS (
        id int IDENTITY(1,1) PRIMARY KEY,
        barrio varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        ley varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        identificacion varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        circunscripcion varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        seccion varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        manzana varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        parcela varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        division varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        tipo_unidad varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        nrounidad varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        partidaunidad varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        digitoverificador varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        tipoplano varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        valuacionfiscal varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        nueva varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        mtstotales varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        mtscubiertos varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        habilitado varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla Concesiones_02_CARTERAS creada exitosamente';
END;
GO

-- Tabla: Concesiones Contratos
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Concesiones_03_CONTRATOS')
BEGIN
    CREATE TABLE dbo.Concesiones_03_CONTRATOS (
        id int IDENTITY(1,1) PRIMARY KEY,
        nro varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        expediente varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fechafirma varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        tipo_contrato varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        tipo_calculo varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        tipo_unidad varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        identificacion varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        descripcion varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        nrounidad varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        vigente varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        nombre varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        documento varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        desde varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        hasta varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        principal varchar(10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla Concesiones_03_CONTRATOS creada exitosamente';
END;
GO

-- Tabla: Concesiones Plan de Pagos
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Concesiones_04_PLAN_DE_PAGOS')
BEGIN
    CREATE TABLE dbo.Concesiones_04_PLAN_DE_PAGOS (
        id int IDENTITY(1,1) PRIMARY KEY,
        tipo varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        objetivo_prestacion varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        nombre varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        documento varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        email varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        emailadicional varchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        tipo_persona varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        calle varchar(300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        carpeta varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        identificacion varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        sub_division varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        nrounidad varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        tipo_contrato varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        tipo_calculo varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        resp_adjudicatatio varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        documento1 varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fecha_creacion varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        nro_expediente varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        observaciones varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        numero varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        vencimiento varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fechabui varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        total varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        observacion varchar(500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        estado varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        fechapago varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        resp_cumplimiento varchar(200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        cuil varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        legajo varchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
    );
    PRINT 'Tabla Concesiones_04_PLAN_DE_PAGOS creada exitosamente';
END;
GO

-- ==============================================
-- VISTAS PRINCIPALES
-- ==============================================

-- Vista: Relación BAC SIGAF
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_RELACION_BAC_SIGAF')
BEGIN
    EXEC('CREATE VIEW dbo.VW_RELACION_BAC_SIGAF AS SELECT * FROM dbo.[01_RELACION_BAC_SIGAF]');
    PRINT 'Vista VW_RELACION_BAC_SIGAF creada exitosamente';
END;
GO

-- Vista: SPR Renglones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_SPR_RENGLONES')
BEGIN
    EXEC('CREATE VIEW dbo.VW_SPR_RENGLONES AS SELECT * FROM dbo.[02_SPR_RENGLONES]');
    PRINT 'Vista VW_SPR_RENGLONES creada exitosamente';
END;
GO

-- Vista: SPR Imputaciones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_SPR_IMPUTACIONES')
BEGIN
    EXEC('CREATE VIEW dbo.VW_SPR_IMPUTACIONES AS SELECT * FROM dbo.[03_SPR_IMPUTACIONES]');
    PRINT 'Vista VW_SPR_IMPUTACIONES creada exitosamente';
END;
GO

-- Vista: RPR SPR PRD
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_RPR_SPR_PRD')
BEGIN
    EXEC('CREATE VIEW dbo.VW_RPR_SPR_PRD AS SELECT * FROM dbo.[04_RPR_SPR_PRD]');
    PRINT 'Vista VW_RPR_SPR_PRD creada exitosamente';
END;
GO

-- Vista: RPR Renglones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_RPR_RENGLONESAS')
BEGIN
    EXEC('CREATE VIEW dbo.VW_RPR_RENGLONESAS AS SELECT * FROM dbo.[05_RPR_RENGLONES]');
    PRINT 'Vista VW_RPR_RENGLONESAS creada exitosamente';
END;
GO

-- Vista: RPR Imputaciones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_RPR_IMPUTACIONES')
BEGIN
    EXEC('CREATE VIEW dbo.VW_RPR_IMPUTACIONES AS SELECT * FROM dbo.[06_RPR_IMPUTACIONES]');
    PRINT 'Vista VW_RPR_IMPUTACIONES creada exitosamente';
END;
GO

-- Vista: PRD Renglones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_PRD_RENGLONES')
BEGIN
    EXEC('CREATE VIEW dbo.VW_PRD_RENGLONES AS SELECT * FROM dbo.[07_PRD_RENGLONES]');
    PRINT 'Vista VW_PRD_RENGLONES creada exitosamente';
END;
GO

-- Vista: PRD Imputaciones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_PRD_IMPUTACIONES')
BEGIN
    EXEC('CREATE VIEW dbo.VW_PRD_IMPUTACIONES AS SELECT * FROM dbo.[08_PRD_IMPUTACIONES]');
    PRINT 'Vista VW_PRD_IMPUTACIONES creada exitosamente';
END;
GO

-- Vista: PRD Facturas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_PRD_FACTURAS')
BEGIN
    EXEC('CREATE VIEW dbo.VW_PRD_FACTURAS AS SELECT * FROM dbo.[09_PRD_FACTURAS]');
    PRINT 'Vista VW_PRD_FACTURAS creada exitosamente';
END;
GO

-- Vista: Facturas OP Pagos
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_FACTURAS_OP_PAGOS')
BEGIN
    EXEC('CREATE VIEW dbo.VW_FACTURAS_OP_PAGOS AS SELECT * FROM dbo.[10_FACTURAS_OP_PAGOS]');
    PRINT 'Vista VW_FACTURAS_OP_PAGOS creada exitosamente';
END;
GO

-- Vista: RP
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_RP')
BEGIN
    EXEC('CREATE VIEW dbo.VW_RP AS SELECT * FROM dbo.[11_RP]');
    PRINT 'Vista VW_RP creada exitosamente';
END;
GO

-- Vista: DRP Renglones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_DRP_RENGLONES')
BEGIN
    EXEC('CREATE VIEW dbo.VW_DRP_RENGLONES AS SELECT * FROM dbo.[12_DRP_RENGLONES]');
    PRINT 'Vista VW_DRP_RENGLONES creada exitosamente';
END;
GO

-- Vista: DRP Imputaciones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_DRP_IMPUTACIONES')
BEGIN
    EXEC('CREATE VIEW dbo.VW_DRP_IMPUTACIONES AS SELECT * FROM dbo.[13_DRP_IMPUTACIONES]');
    PRINT 'Vista VW_DRP_IMPUTACIONES creada exitosamente';
END;
GO

-- Vista: DRP Facturas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_DRP_FACTURAS')
BEGIN
    EXEC('CREATE VIEW dbo.VW_DRP_FACTURAS AS SELECT * FROM dbo.[14_DRP_FACTURAS]');
    PRINT 'Vista VW_DRP_FACTURAS creada exitosamente';
END;
GO

-- Vista: DRP Facturas Pagos
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_DRP_FACTURAS_PAGOS')
BEGIN
    EXEC('CREATE VIEW dbo.VW_DRP_FACTURAS_PAGOS AS SELECT * FROM dbo.[15_DRP_FACTURAS_PAGOS]');
    PRINT 'Vista VW_DRP_FACTURAS_PAGOS creada exitosamente';
END;
GO

-- Vista: Preciario
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_PRECIARIO')
BEGIN
    EXEC('CREATE VIEW dbo.VW_PRECIARIO AS SELECT * FROM dbo.[16_PRECIARIO]');
    PRINT 'Vista VW_PRECIARIO creada exitosamente';
END;
GO

-- Vista: Preciario Imputaciones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_PRECIARIO_IMPUTACIONES')
BEGIN
    EXEC('CREATE VIEW dbo.VW_PRECIARIO_IMPUTACIONES AS SELECT * FROM dbo.[17_PRECIARIO_IMPUTACIONES]');
    PRINT 'Vista VW_PRECIARIO_IMPUTACIONES creada exitosamente';
END;
GO

-- Vista: PRD Preciario
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_PRD_PRECIARIO')
BEGIN
    EXEC('CREATE VIEW dbo.VW_PRD_PRECIARIO AS SELECT * FROM dbo.[18_PRD_PRECIARIO]');
    PRINT 'Vista VW_PRD_PRECIARIO creada exitosamente';
END;
GO

-- Vista: PRD Preciario Renglones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_PRD_PRECIARIO_RENGLONES')
BEGIN
    EXEC('CREATE VIEW dbo.VW_PRD_PRECIARIO_RENGLONES AS SELECT * FROM dbo.[19_PRD_PRECIARIO_RENGLONES]');
    PRINT 'Vista VW_PRD_PRECIARIO_RENGLONES creada exitosamente';
END;
GO

-- Vista: PRD Preciario Imputaciones
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_PRD_PRECIARIO_IMPUTACIONES')
BEGIN
    EXEC('CREATE VIEW dbo.VW_PRD_PRECIARIO_IMPUTACIONES AS SELECT * FROM dbo.[20_PRD_PRECIARIO_IMPUTACIONES]');
    PRINT 'Vista VW_PRD_PRECIARIO_IMPUTACIONES creada exitosamente';
END;
GO

-- Vista: PRD Preciario Facturas
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_PRD_PRECIARIO_FACTURAS')
BEGIN
    EXEC('CREATE VIEW dbo.VW_PRD_PRECIARIO_FACTURAS AS SELECT * FROM dbo.[21_PRD_PRECIARIO_FACTURAS]');
    PRINT 'Vista VW_PRD_PRECIARIO_FACTURAS creada exitosamente';
END;
GO

-- Vista: Pagos Preciario
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_PAGOS_PRECIARIO')
BEGIN
    EXEC('CREATE VIEW dbo.VW_PAGOS_PRECIARIO AS SELECT * FROM dbo.[22_PAGOS_PRECIARIO]');
    PRINT 'Vista VW_PAGOS_PRECIARIO creada exitosamente';
END;
GO

-- Vista: Unidades Ejecutoras
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_UNIDADES_EJECUTORAS')
BEGIN
    EXEC('CREATE VIEW dbo.VW_UNIDADES_EJECUTORAS AS SELECT * FROM dbo.[23_UNIDADES_EJECUTORAS]');
    PRINT 'Vista VW_UNIDADES_EJECUTORAS creada exitosamente';
END;
GO

-- Vista: Periodos Fiscales
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_PERIODOS_FISCALES')
BEGIN
    EXEC('CREATE VIEW dbo.VW_PERIODOS_FISCALES AS SELECT * FROM dbo.[24_PERIODOS_FISCALES]');
    PRINT 'Vista VW_PERIODOS_FISCALES creada exitosamente';
END;
GO

-- Vista: Entes
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vw_entes')
BEGIN
    EXEC('CREATE VIEW dbo.vw_entes AS SELECT o_ente, denom_ente, nro_oc_sigaf FROM dbo.[25_ENTES]');
    PRINT 'Vista vw_entes creada exitosamente';
END;
GO

-- Vista: Bienes Beneficiarios
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_Bienes_Beneficiarios')
BEGIN
    EXEC('CREATE VIEW dbo.VW_Bienes_Beneficiarios AS SELECT * FROM dbo.Bienes_01_BENEFICIARIOS');
    PRINT 'Vista VW_Bienes_Beneficiarios creada exitosamente';
END;
GO

-- Vista: Bienes Carteras
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_Bienes_Carteras')
BEGIN
    EXEC('CREATE VIEW dbo.VW_Bienes_Carteras AS SELECT * FROM dbo.Bienes_02_CARTERAS');
    PRINT 'Vista VW_Bienes_Carteras creada exitosamente';
END;
GO

-- Vista: Bienes Contratos
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_Bienes_Contratos')
BEGIN
    EXEC('CREATE VIEW dbo.VW_Bienes_Contratos AS SELECT * FROM dbo.Bienes_03_CONTRATOS');
    PRINT 'Vista VW_Bienes_Contratos creada exitosamente';
END;
GO

-- Vista: Bienes Plan de Pagos
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_Bienes_Plan_de_pagos')
BEGIN
    EXEC('CREATE VIEW dbo.VW_Bienes_Plan_de_pagos AS SELECT * FROM dbo.Bienes_04_PLAN_DE_PAGOS');
    PRINT 'Vista VW_Bienes_Plan_de_pagos creada exitosamente';
END;
GO

-- Vista: Concesiones Beneficiarios  
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_Concesiones_Beneficiarios')
BEGIN
    EXEC('CREATE VIEW dbo.VW_Concesiones_Beneficiarios AS SELECT * FROM dbo.Concesiones_01_BENEFICIARIOS');
    PRINT 'Vista VW_Concesiones_Beneficiarios creada exitosamente';
END;
GO

-- Vista: Concesiones Carteras
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_Concesiones_Carteras')
BEGIN
    EXEC('CREATE VIEW dbo.VW_Concesiones_Carteras AS SELECT * FROM dbo.Concesiones_02_CARTERAS');
    PRINT 'Vista VW_Concesiones_Carteras creada exitosamente';
END;
GO

-- Vista: Concesiones Contratos
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_Concesiones_Contratos')
BEGIN
    EXEC('CREATE VIEW dbo.VW_Concesiones_Contratos AS SELECT * FROM dbo.Concesiones_03_CONTRATOS');
    PRINT 'Vista VW_Concesiones_Contratos creada exitosamente';
END;
GO

-- Vista: Concesiones Plan de Pagos
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'VW_Concesiones_Plan_de_pagos')
BEGIN
    EXEC('CREATE VIEW dbo.VW_Concesiones_Plan_de_pagos AS SELECT * FROM dbo.Concesiones_04_PLAN_DE_PAGOS');
    PRINT 'Vista VW_Concesiones_Plan_de_pagos creada exitosamente';
END;
GO

-- ==============================================
-- VERIFICACIÓN FINAL
-- ==============================================
PRINT '========================================';
PRINT 'VERIFICACIÓN DE ESTRUCTURA CREADA';
PRINT '========================================';

SELECT 
    'TABLA' as TIPO,
    TABLE_SCHEMA as ESQUEMA, 
    TABLE_NAME as NOMBRE
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dbo'
UNION ALL
SELECT 
    'VISTA' as TIPO,
    TABLE_SCHEMA as ESQUEMA,
    TABLE_NAME as NOMBRE  
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_SCHEMA = 'dbo'
ORDER BY TIPO, NOMBRE;

PRINT '========================================';
PRINT '¡ESTRUCTURA COMPLETA DE BASE DE DATOS CREADA!';
PRINT 'Total de objetos creados:'
PRINT '- 29 Tablas del sistema SIGAF (01_ a 25_)'
PRINT '- 8 Tablas de Bienes y Concesiones'
PRINT '- 32 Vistas correspondientes'
PRINT '========================================';