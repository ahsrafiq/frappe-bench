FROM frappe/erpnext:v14.39.0

WORKDIR /home/frappe/frappe-bench

# Copy project files and assign correct ownership directly
COPY --chown=frappe:frappe . .

# Switch to frappe user
USER frappe

# Install dependencies
RUN bench setup requirements
RUN bench build --production

# Switch back to root to run startup script
USER root

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
