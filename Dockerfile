FROM frappe/erpnext:v14

WORKDIR /home/frappe/frappe-bench

# Copy only necessary folders (not overwriting env/)
COPY --chown=frappe:frappe apps apps/
COPY --chown=frappe:frappe sites sites/
COPY --chown=frappe:frappe Procfile .
COPY --chown=frappe:frappe requirements.txt .

# Keep existing env intact
USER frappe

RUN bench setup requirements
RUN bench build --production

USER root

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
