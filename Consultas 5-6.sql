USE AdventureWorks2019
GO

/* 5 Crea un procedimiento que obtenga lista de cumpleañeros del mes ordenados alfabéticamente por el primer apellido y por el nombre del departamento, si no se especifica DepartmentID entonces deberá retornar todos los datos.*/


IF EXISTS(
SELECT * FROM INFORMATION_SCHEMA.ROUTINES
WHERE  SPECIFIC_SCHEMA(N'Employee')
AND SPECIFIC_NAME(N'pr_Birthday')
)
DROP PROCEDURE Employee.pr_Birthday
GO

CREATE PROCEDURE Employee.pr_Birthday
@DepartamentID SMALLINT =  null

AS

SELECT p.BusinessEntityID AS ID, p.LastName AS Apellido, p.FirstName AS Nombre, d.[Name] AS Departamento,  E.BirthDate AS Cumplea�os
FROM HumanResources.Department d 
LEFT JOIN HumanResources.Employee e on d.DepartmentID = e.BusinessEntityID
RIGHT JOIN HumanResources.EmployeeDepartmentHistory edh ON d.DepartmentID = edh.DepartmentID
INNER JOIN Person.Person p on edh.BusinessEntityID = p.BusinessEntityID
WHERE (@DepartamentID is null or @DepartamentID = d.DepartmentID AND  DATEPART(MM,E.BirthDate)=DATEPART(MONTH,GETDATE()))
ORDER BY P.LastName ASC;

GO
 
exec Employee.pr_Birthday 1
go


/* 6 Crea un procedimiento que obtenga la cantidad de empleados por departamento ordenados por nombre de departamento, si no se especifica DepartmentID entonces deberá retornar todos los datos.
*/

IF EXISTS(
SELECT * FROM INFORMATION_SCHEMA.ROUTINES
WHERE  SPECIFIC_SCHEMA(N'Employee')
AND SPECIFIC_NAME(N'pr_NumberOfEmployees')
)
DROP PROCEDURE Employee.pr_NumberOfEmployees
GO

CREATE PROCEDURE Employee.pr_NumberOfEmployees
@DepartamentID SMALLINT = null
AS
SELECT d.DepartmentID , d.[Name] AS Departamento, p.FirstName AS Nombre,  p.LastName AS Apellido
FROM HumanResources.Department d 
LEFT JOIN HumanResources.Employee e on d.DepartmentID = e.BusinessEntityID
RIGHT JOIN HumanResources.EmployeeDepartmentHistory edh ON d.DepartmentID = edh.DepartmentID
INNER JOIN Person.Person p on edh.BusinessEntityID = p.BusinessEntityID
WHERE (@DepartamentID is null or @DepartamentID = d.DepartmentID)
GROUP BY D.DepartmentID, D.[Name], P.FirstName, P.LastName
GO

exec Employee.pr_NumberOfEmployees 6

