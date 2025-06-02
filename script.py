import pandas as pd
import logging
from sqlalchemy import create_engine


logging.basicConfig(filename = 'errors.log', level=logging.ERROR, format="%(asctime)s -%(message)s")

db_user = 'root'
db_password = 'Mysql123#' #(use your MySQL password instead)
db_host = 'localhost'
db_name = 'e-commerce'

engine = create_engine(f"mysql+pymysql://{db_user}:{db_password}@{db_host}/{db_name}")

csv_files = {'customer':'cleaned_customer.csv',
             'product':'cleaned_product.csv',
             'transaction':'cleaned_transaction.csv'}

primary_keys = {'customer':'CustomerID',
                'product':'ProductID',
                'transaction':'TransactionID'}


def csv_to_sql(table_name, file_path, primary_key):
    try:
        df = pd.read_csv(file_path)
        
        if table_name == 'transaction':
            df['TransactionTimestamp'] = pd.to_datetime(df['TransactionTimestamp'], errors='coerce').dt.date
            df['CartStartTimestamp'] = pd.to_datetime(df['CartStartTimestamp'], errors='coerce').dt.date
            df['ExpectedDeliveryDate'] = pd.to_datetime(df['ExpectedDeliveryDate'], errors='coerce').dt.date
        
        existing_df = pd.read_sql(f"select * from {table_name}", con=engine)

        new_data = df[~df[primary_key].isin(existing_df[primary_key])]
        
        if table_name == 'transaction':  # Validate CustomerID before inserting
            customer_ids = pd.read_sql("SELECT CustomerID FROM customer", con=engine)['CustomerID'].tolist()
            new_data = new_data[new_data['CustomerID'].isin(customer_ids)]
            
        if table_name == 'transaction':
            product_ids = pd.read_sql("SELECT ProductID FROM product", con=engine)['ProductID'].tolist()
            new_data = new_data[new_data['ProductPurchased'].isin(product_ids)]
        
                
        if not new_data.empty:
            new_data.to_sql(table_name, con=engine, if_exists = 'append', index =False)
            print(f'{len(new_data)} new records added to {table_name}')
        else:
            print(f'no new record for {table_name}')

    except Exception as e:
        logging.error(f'error syncing {table_name}:{str(e)}')
        print(f'error syncing {table_name}')

def main():
    for table, file in csv_files.items():
        csv_to_sql(table, file, primary_keys[table])
    print('all csv files synced successfully')


if __name__ =='__main__':
    main()