FROM frappe/erpnext:v14

WORKDIR /home/frappe/frappe-bench

COPY . .

RUN bench setup requirements
RUN bench build --production

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]

