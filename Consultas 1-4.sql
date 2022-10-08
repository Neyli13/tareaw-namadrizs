USE AdventureWorks2019
GO

/*Cree una vista de las que muestre un listado de los productos descontinuados. Los productos (Production.Product) descontinuados son aquellos cuyo valor en DiscontinuedDate es distinto de NULL */
CREATE VIEW productos_descontinuados
AS
SELECT DiscontinuedDate
FROM production.Product
WHERE DiscontinuedDate <> NULL;
GO

SELECT * FROM productos_descontinuados;
GO

/*Crea una vista que muestre un listado de productos (Production.Product) activos con sus respectivas categorías (Production.ProductCategory), subcategorías (Production.ProductSubcategory) y modelo (Production.ProductModel). Deben mostrarse todos los productos activos aunque no tengan modelo asociado.*/
CREATE VIEW lista_productos
AS
SELECT p.ProductID as ProductID, p[Name] as Producto, pc.ProductCategoryID as CategoriaID, pc.[Name] as  Categoria, psc.ProductSubcategoryID, psc.[Name] as
FROM Production.Product p
FULL JOIN Production.ProductModel pm on p.ProductID = pm.ProductModelID
LEFT JOIN Production.ProductCategory pc on p.ProductsubCategoryID = pc.ProductCategoryID
LEFT JOIN Production.ProductsubCategory psc on p.ProductID = psc.ProductsubCategoryID
GROUP BY p.ProductID, p.Name, pc.ProductCategoryID, pc.Name, psc.ProductSubcategoryID, psc.Name, pm.ProductModelID, pm.Name
GO
DROP VIEW lista_productos

SELECT * FROM lista_productos
GO

SELECT * FROM Production.Product
SELECT * FROM Production.ProductCategory
SELECT * FROM Production.ProductSubcategory
SELECT * FROM Production.ProductModel


/*Crea una consulta que obtenga los datos generales de los empleados (HumanResources.Employee) del departamento (HumanResources.Department) ‘Document Control’.*/
SELECT e.BusinessEntityID, e.*,
d.Name
FROM HumanResources.Employee e 
inner join 
HumanResources.EmployeeDepartmentHistory h
on e.BusinessEntityID = h.BusinessEntityID
inner join HumanResources.Department d
on d.DepartmentID = h.DepartmentID
and h.EndDate is null
and d.Name in ('Quality Assurance', 'Production');


/*Crea un procedimiento almacenado que obtenga los datos generales de los empleados por departamento.*/

CREATE PROCEDURE datos_generales_empleados 
AS
SELECT * FROM HumanResources.Department
GO

EXEC datos_generales_empleados;
GO

