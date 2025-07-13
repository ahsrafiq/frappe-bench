FROM frappe/erpnext:v14.39.0

WORKDIR /home/frappe/frappe-bench

# Copy your custom bench code
COPY . .

# Set correct permissions
RUN chown -R frappe:frappe /home/frappe/frappe-bench

# Switch to frappe user
USER frappe

# Install dependencies
RUN bench setup requirements
RUN bench build --production

# Switch back if needed
USER root

# Entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
