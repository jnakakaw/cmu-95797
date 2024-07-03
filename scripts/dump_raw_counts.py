import duckdb
import pandas as pd

raw_tables = ["central_park_weather",
              "fhv_bases",
              "fhv_tripdata",
              "fhvhv_tripdata",
              "green_tripdata",
              "yellow_tripdata",
              "bike_data"]

def main():
    rows_list = []

    with duckdb.connect("main.db") as con:
        # Tables are imported in a for loop
        for table_name in raw_tables:
            rows = con.sql(f"SELECT COUNT(*) FROM {table_name}").fetchone()[0]
            rows_list.append(rows)

    # Formating and printing output
    row_counts_df = pd.DataFrame({"Table": raw_tables, "Number of rows": rows_list})
    with open('./answers/raw_counts.txt', 'wt') as f:
        f.write(row_counts_df.to_string(header=True, index=False))

if __name__ == "__main__":
    main()