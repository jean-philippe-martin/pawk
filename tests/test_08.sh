#!/bin/bash
set -e
# README example (adapted)
cat << EOF | diff - <(pawk --file data/delta_byte_array.parquet --last 'print(header)')
['c_customer_id', 'c_salutation', 'c_first_name', 'c_last_name', 'c_preferred_cust_flag', 'c_birth_country', 'c_login', 'c_email_address', 'c_last_review_date']
EOF
