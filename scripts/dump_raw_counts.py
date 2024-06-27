import duckdb
import pandas as pd

tables = {'yellow_tripdata': './data/taxi/yellow_tripdata.parquet', 'green_tripdata': './data/taxi/green_tripdata*.parquet', 
          'fhvhv_tripdata': './data/taxi/fhvhv_tripdata*.parquet', 'fhv_tripdata': './data/taxi/fhv_tripdata*.parquet', 
          'fhv_bases': './data/fhv_bases.csv', 'central_park_weather': './data/central_park_weather.csv', 
          'bike_data': './data/citibike-tripdata.csv.gz'}

rows_list = []

# Tables are imported in a for loop
for table_name, table_path in tables.items():
    if table_path.split(".")[-1] == "parquet":
        duckdb.read_parquet(table_path)
    else:
        duckdb.read_csv(table_path)
    
    # Query to count rows
    rows_count_query = int(duckdb.sql("SELECT COUNT(*) FROM '{}'".format(table_path)).df().iloc[0, 0])
    rows_list.append(rows_count_query)

# Formating and printing output
row_counts_df = pd.DataFrame({"Table": list(tables.keys()), "Number of rows": rows_list})
with open('./answers/raw_counts.txt', 'wt') as f:
    f.write(row_counts_df.to_string(header=True, index=False))
