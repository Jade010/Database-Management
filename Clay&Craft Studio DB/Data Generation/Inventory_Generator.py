import random
import re

# Configuration
status_options = ['available', 'sold', 'returned', 'defective']
locations = ['Main Shelf A', 'Main Shelf B', 'Back Storage', 'Display Area', 'Transit Rack', 'Sold Inventory']

# File paths
input_sql_file = 'C:/Users/Jade_/OneDrive/Documents/11 Clay & Craft Studio/Data Generation/insert_product_instances.sql'
output_sql_file = 'C:/Users/Jade_/OneDrive/Documents/11 Clay & Craft Studio/Data Generation/inventory_records_insert.sql'

def generate_inventory_records(input_path, output_path):
    with open(input_path, 'r') as file:
        content = file.read()

    # Extract value tuples from ProductInstances insert SQL
    records = re.findall(
        r'\((\d+),\s*(\d+),\s*\'[\d\-]+\',\s*\'[^\']+\',\s*\'[^\']+\',\s*\'[^\']+\'\)',
        content
    )

    inventory_rows = []
    for i, _ in enumerate(records, start=1):
        status = random.choice(status_options)
        location = random.choice(locations)
        inventory_rows.append(f"({i}, '{status}', '{location}')")

    # Write to output SQL file
    with open(output_path, 'w') as outfile:
        outfile.write("INSERT INTO Inventory (instance_id, status, location)\nVALUES\n")
        outfile.write(",\n".join(inventory_rows))
        outfile.write(";\n")

    print(f"✅ SQL insert script saved to: {output_path}")

# Run script
generate_inventory_records(input_sql_file, output_sql_file)

