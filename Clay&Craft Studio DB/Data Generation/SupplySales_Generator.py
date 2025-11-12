from datetime import datetime, timedelta
import random

# --- Configuration ---
supplies = {
    1: 18.50, 2: 24.00, 3: 28.00, 4: 32.00, 5: 34.00, 6: 30.00, 7: 31.00, 8: 32.00,
    9: 33.00, 10: 29.50, 11: 28.00, 12: 34.00, 13: 30.50, 14: 31.50, 15: 33.00,
    16: 35.00, 17: 30.00, 18: 12.99, 19: 6.50, 20: 45.00, 21: 3.50, 22: 4.25,
    23: 9.99, 24: 5.00, 25: 7.95, 26: 6.50, 27: 11.99, 28: 8.25, 29: 10.75,
    30: 6.25, 31: 12.00, 32: 38.00, 33: 49.00, 34: 2.50, 35: 1.20, 36: 4.75,
    37: 11.00, 38: 2.50, 39: 1.80, 40: 15.00, 41: 9.95, 42: 15.00, 43: 85.00,
    44: 24.50, 45: 12.00, 46: 65.00, 47: 18.00, 48: 32.00, 49: 22.00, 50: 110.00,
    51: 28.00, 52: 14.50, 53: 9.75
}

base_count_by_year = {
    2019: 20,
    2020: 40,
    2021: 80,
    2022: 160,
    2023: 320,
    2024: 640,
    2025: 1280
}

# --- Settings ---
total_customers = 4233
customer_ids = list(range(1, total_customers + 1))
output_file_path = "C:/Users/Jade_/OneDrive/Documents/11 Clay & Craft Studio/Data Generation/insert_supply_sales.sql"

# --- Helpers ---
def random_date(start, end):
    return start + timedelta(days=random.randint(0, (end - start).days))

# --- Generation Function ---
def generate_supply_sales_sql():
    all_rows = []
    base_repeat_customers = random.sample(customer_ids, k=total_customers // 3)

    for year, count in base_count_by_year.items():
        repeat_ratio = 0.33 + ((year - 2019) * 0.02)
        num_repeats = int(count * min(repeat_ratio, 0.90))  # Cap repeat ratio at 90%
        num_new = count - num_repeats

        repeat_customers = random.choices(base_repeat_customers, k=num_repeats)
        eligible_new = [cid for cid in customer_ids if cid not in base_repeat_customers]
        new_customers = random.choices(eligible_new, k=num_new)
        year_customers = repeat_customers + new_customers
        random.shuffle(year_customers)

        for i in range(count):
            sale_date = random_date(datetime(year, 1, 1), datetime(year, 12, 31))
            staff_id = 7 if (year < 2023 or sale_date < datetime(2023, 3, 20)) else 8
            supply_id = random.choice(list(supplies.keys()))
            quantity = random.randint(1, 10)
            total = round(supplies[supply_id] * quantity, 2)
            customer_id = year_customers[i]

            row = f"({staff_id}, {supply_id}, {customer_id}, '{sale_date.date()}', {quantity}, {total})"
            all_rows.append(row)

    # --- Save as SQL file ---
    with open(output_file_path, 'w') as f:
        f.write(",\n".join(all_rows))
        f.write(";\n")

    print(f"✅ Supply sales insert file saved to: {output_file_path}")

# --- Run it ---
generate_supply_sales_sql()

