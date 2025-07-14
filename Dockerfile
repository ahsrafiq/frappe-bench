FROM frappe/erpnext:v14

# Set working directory
WORKDIR /home/frappe/frappe-bench

# Switch to root (temporarily) to copy files with correct ownership
USER root

# Copy project files and set correct ownership
COPY --chown=frappe:frappe apps apps/
COPY --chown=frappe:frappe sites sites/
COPY --chown=frappe:frappe Procfile .
COPY --chown=frappe:frappe requirements.txt .

# Make sure frappe user owns everything
RUN chown -R frappe:frappe /home/frappe/frappe-bench

# Now switch to frappe before running bench commands
USER frappe

# Set up Python env and dependencies
RUN bench setup requirements
RUN bench build --production

# Switch back to root to configure entrypoint
USER root
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
