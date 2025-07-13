FROM frappe/erpnext:v13.55.2

WORKDIR /home/frappe/frappe-bench

COPY . .

RUN bench setup requirements
RUN bench build --production

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]

