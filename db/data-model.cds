namespace CAPM1_ComputerShop_Batch2.db;

using { managed } from '@sap/cds/common';

entity Computers
{
    key ID : Integer;
    name : String;
    model : String;
    unitprice : Integer;
    stock : Integer;
}

entity Customers
{
    key ID : Integer;
    name : String(100);
    address : String(100);
    phone : String(100);
}

entity Sales : managed
{
    key ID : UUID
        @Core.Computed;
    customerID : Integer;
    computerID : Integer;
    price : Decimal;
}

entity sales_overview as
    select key sal.ID as salesID,
    sal.customerID as customerID,
    cust.name as customerName,
    cust.address as customerAddress,
    cust.phone as customerPhone,
    com.ID as computerID,
    com.name as computerName,
    sal.price as salesAmount from Sales as sal
    left join Customers as cust
        on sal.customerID = cust.ID
    left join Computers as com
        on sal.computerID = com.ID;
