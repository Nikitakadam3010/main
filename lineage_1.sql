-- Third set of queries with new aliases and database names
INSERT OVERWRITE TABLE more_db_copy.invoices_result
SELECT
    users_col.new_col1, orders_col.new_col1 AS ord_col2, emp_col.new_col3_sum AS emp_col3, new_col4, prod_col.*, cust_col.cust_name
FROM
    more_db.users users_col
JOIN
    more_db_copy.orders orders_col ON users_col.id = orders_col.users_id
LEFT JOIN
    (SELECT users_id, sum(new_col3) AS new_col3_sum FROM more_db.employees GROUP BY users_id) emp_col ON users_col.id = emp_col.users_id
CROSS JOIN
    more_db.products prod_col
LEFT JOIN
    more_db.customers cust_col ON users_col.id = cust_col.users_id;

INSERT OVERWRITE TABLE more_db_copy.transactions_result
SELECT
    inv_col.new_col1, inv_col.new_col2 + sale_col.new_col2 AS col2_sum, cust_col.cust_name AS customer_name
FROM
    more_db_copy.invoices_result inv_col
LEFT JOIN
    more_db.sales sale_col ON inv_col.new_col1 = sale_col.new_col1
LEFT JOIN
    more_db.customers cust_col ON inv_col.users_id = cust_col.users_id;

-- Fourth set of queries with new aliases and database names
INSERT OVERWRITE TABLE final_db.invoices_result
SELECT
    users_col.final_col1, orders_col.final_col1 AS ord_col2, emp_col.final_col3_sum AS emp_col3, final_col4, prod_col.*, cust_col.cust_name
FROM
    final_db.users users_col
JOIN
    final_db_copy.orders orders_col ON users_col.id = orders_col.users_id
LEFT JOIN
    (SELECT users_id, sum(final_col3) AS final_col3_sum FROM final_db.employees GROUP BY users_id) emp_col ON users_col.id = emp_col.users_id
CROSS JOIN
    final_db.products prod_col
LEFT JOIN
    final_db.customers cust_col ON users_col.id = cust_col.users_id;

INSERT OVERWRITE TABLE final_db_copy.transactions_result
SELECT
    inv_col.final_col1, inv_col.final_col2 + sale_col.final_col2 AS col2_sum, cust_col.cust_name AS customer_name
FROM
    final_db_copy.invoices_result inv_col
LEFT JOIN
    final_db.sales sale_col ON inv_col.final_col1 = sale_col.final_col1
LEFT JOIN
    final_db.customers cust_col ON inv_col.users_id = cust_col.users_id;

