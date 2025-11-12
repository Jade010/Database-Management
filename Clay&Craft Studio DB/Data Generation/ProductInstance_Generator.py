import random
from datetime import datetime, timedelta

# Products and IDs
products = {
    1: 'Ceramic Mug',
    2: 'Dinnerware Set (Plates & Bowls)',
    3: 'Ceramic Baking Dish',
    4: 'Travel Cup with Silicone Sleeve & Lid',
    5: 'Self-Watering Planter',
    6: 'Teatime Set'
}

# Ceramic artists and their employment start dates
ceramic_artists = {
    3: datetime(2019, 6, 10),   # Joan Silva
    4: datetime(2019, 9, 5),    # Milo Tran
    5: datetime(2021, 11, 22),  # Leila Young
    6: datetime(2025, 1, 1)     # Ben Carr
}

# Number of product instances per year (doubling)
instance_counts_by_year = {
    2019: 30,
    2020: 60,
    2021: 120,
    2022: 240,
    2023: 480,
    2024: 960,
    2025: 1920
}

# Glaze and color types
glazes = ['Glossy', 'Matte', 'Satin', 'Crackle']
colors = ['White', 'Sand', 'Terracotta', 'Sage', 'Ochre', 'Moss', 'Charcoal', 'Rose', 'Blue', 'Copper', 'Grey']

# Product dimension info
dimensions_map = {
    1: '3.5x4 in',
    2: '10 in plates, 6 in bowls',
    3: '12x8 in',
    4: '6x3 in',
    5: '7 in diameter',
    6: 'Teapot: 5 in tall, Cups: 3 in'
}

# Helper: generate random date in year after artist start
def random_date_in_year(year, artist_start):
    start_date = max(datetime(year, 1, 1), artist_start)
    end_date = datetime(year, 12, 31)
    return start_date + timedelta(days=random.randint(0, (end_date - start_date).days))

# Generate SQL insert statements
sql_statements = []

for year, count in instance_counts_by_year.items():
    for _ in range(count):
        product_id = random.choice(list(products.keys()))
        glaze = random.choice(glazes)
        color = random.choice(colors)
        dimensions = dimensions_map[product_id]

        # Eligible artists based on hire date
        valid_artists = [aid for aid, start in ceramic_artists.items() if start <= datetime(year, 12, 31)]
        artist_id = random.choice(valid_artists)
        artist_start = ceramic_artists[artist_id]

        # Generate date and create SQL
        date_created = random_date_in_year(year, artist_start)
        sql = (
            f"({product_id}, {artist_id}, '{date_created.date()}', '{glaze}', '{color}', '{dimensions}'),"
        )
        sql_statements.append(sql)


# Optionally save to a .sql file
with open("C:/Users/Jade_/OneDrive/Documents/11 Clay & Craft Studio/Data Generation/insert_product_instances.sql", "w") as file:
    for statement in sql_statements:
        file.write(statement + "\n")
