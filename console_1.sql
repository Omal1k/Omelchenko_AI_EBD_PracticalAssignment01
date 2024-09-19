use testDB;

WITH AnalysisCredit AS (
    select C.customer_id,
           A.account_id,
           COALESCE(A.balance, 0) as balance,
           T.amount as transaction_amount,
           COALESCE(L.loan_amount, 0),
           P.payment_amount,
           P.payment_date,
           T.transaction_type

    from testDB.Customers as C

    join
        testDB.Accounts A on C.customer_id = A.customer_id
    join
        testDB.Loans L on A.customer_id = L.customer_id
    join
        testDB.Transactions T on A.account_id = T.amount
    join
        testDB.Payments P on L.loan_id = P.loan_id
    where T.transaction_type = 'credit'
    GROUP BY C.customer_id, A.account_id, A.balance, T.amount, L.loan_amount, P.payment_amount, P.payment_date
    ORDER BY customer_id ASC
),
AnalysisDebit AS (
    select C.customer_id,
           A.account_id,
           COALESCE(A.balance, 0) as balance,
           T.amount as transaction_amount,
           COALESCE(L.loan_amount, 0),
           P.payment_amount,
           P.payment_date,
           T.transaction_type

    from testDB.Customers as C

    join
        testDB.Accounts A on C.customer_id = A.customer_id
    join
        testDB.Loans L on A.customer_id = L.customer_id
    join
        testDB.Transactions T on A.account_id = T.amount
    join
        testDB.Payments P on L.loan_id = P.loan_id
    where T.transaction_type = 'debit'
    GROUP BY C.customer_id, A.account_id, A.balance, T.amount, L.loan_amount, P.payment_amount, P.payment_date
    ORDER BY customer_id ASC
)
SELECT * FROM AnalysisCredit
UNION
SELECT * FROM AnalysisDebit


