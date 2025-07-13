FROM frappe/erpnext:v14

WORKDIR /home/frappe/frappe-bench

# Copy your ERPNext project files with correct ownership
COPY --chown=frappe:frappe . .

# Switch to frappe user
USER frappe

# Only install dependencies and build (skip env setup)
RUN bench setup requirements
RUN bench build --production

USER root

# Copy and configure entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
