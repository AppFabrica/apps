USE [Contactar]
GO
/****** Object:  StoredProcedure [dbo].[BUSCARTEXTOENSP]    Script Date: 06/16/2015 08:54:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--------------------------------------------
-- OBJECT NAME: p_FindText
-- AUTHOR: Raúl Alfredo Epstein
-- AUTHOR EMAIL: raultuc@hotmail.com
-- DATE: 30/04/2005
--
-- INPUTS: @strFind -> Cadena a buscar
--@varDBName -> DB en la que se buscará, por defecto en Northwind
--
-- OUTPUTS: Nombres de SP que contienen la cadena buscada
--
-- DEPENDENCIES: Ninguna
--
-- DESCRIPTION:
/*
El método consta de utilizar una SP que busca entre las tablas de sistema
de una determinada DB, utilizando un LIKE contra el campo dónde el motor
guarda el texto de los SP. Es importante destacar que, obviamente, esto no
funciona con los SP encriptados. */
 
-- MODIFICATION HISTORY:
-------------------------------------------------
-- 30/04/2005 - Raúl Alfredo Epstein
-- Creación.
-------------------------------------------------
-------------------------------------------------
ALTER PROCEDURE [dbo].[BUSCARTEXTOENSP]
@strFind varchar (100),
@varDBName varchar (100) = 'Contactar'
as
BEGIN
 
DECLARE @_strFind varchar (100),
	@_varDBName varchar (100)
SET @_strFind = @strFind
SET @_varDBName = @varDBName

declare @varQuery varchar (1000)
 
select @varQuery =
'SELECT distinct ' +
'name SP_Name, ''sp_helptext '''''' + name + ''''''''SP_HT ' +
'FROM [' + @_varDBName + '].[dbo].[sysobjects] inner join [' + @_varDBName + '].[dbo].[syscomments] ' +
'on [' + @_varDBName + '].[dbo].[sysobjects].id = [' + @_varDBName + '].[dbo].[syscomments].id ' +
'where xtype = ''P'' ' +
'and text like ''%' + @_strFind + '%'' ' +
'order by name '
 
exec (@varQuery)
 
END --sp
 
