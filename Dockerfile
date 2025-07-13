FROM frappe/erpnext:v14.39.0

WORKDIR /home/frappe/frappe-bench

# Copy files and set ownership
COPY --chown=frappe:frappe . .

USER frappe

# 🛠️ Step 1: Create Python virtual environment
RUN bench setup env

# 🧰 Step 2: Install dependencies into virtual env
RUN bench setup requirements

# 🏗️ Step 3: Build frontend assets
RUN bench build --production

USER root

# Entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
