FROM frappe/erpnext:v14

WORKDIR /home/frappe/frappe-bench

# Use root to copy everything and fix permissions
USER root

COPY --chown=frappe:frappe apps apps/
COPY --chown=frappe:frappe sites sites/
COPY --chown=frappe:frappe Procfile .
COPY --chown=frappe:frappe requirements.txt .
COPY --chown=frappe:frappe entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Default user (needed for CMD)
USER frappe

CMD ["/entrypoint.sh"]
