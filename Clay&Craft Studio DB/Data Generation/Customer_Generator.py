import random
from faker import Faker

fake = Faker()
Faker.seed(42)
random.seed(42)

num_customers = 4233
customers = set()
sql_values = []

# Keep track of used emails to ensure uniqueness
used_emails = set()

while len(customers) < num_customers:
    name = fake.name()
    email = fake.unique.email()
    address = fake.address().replace("\n", ", ")
    phone = fake.phone_number()

    # Ensure email uniqueness in case Faker doesn't
    if email in used_emails:
        continue

    used_emails.add(email)
    customers.add((name, email, address, phone))

# Format for SQL
for name, email, address, phone in customers:
    # Escape single quotes in SQL strings by doubling them
    name_escaped = name.replace("'", "''")
    email_escaped = email.replace("'", "''")
    address_escaped = address.replace("'", "''")
    phone_escaped = phone.replace("'", "''")

    entry = f"('{name_escaped}', '{email_escaped}', '{address_escaped}', '{phone_escaped}')"
    sql_values.append(entry)

# Write to file
output_path = "C:/Users/Jade_/OneDrive/Documents/11 Clay & Craft Studio/Data Generation/insert_customers.sql"
with open(output_path, "w", encoding="utf-8") as f:
    f.write(",\n".join(sql_values))
    f.write(";\n")

print(f"✅ Generated {num_customers} customer records in: {output_path}")
