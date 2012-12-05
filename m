From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 3/4] UART / 8250: Add declearation of serial8250 driver.
Date: Wed,  5 Dec 2012 11:51:58 +0800
Message-ID: <16400c00779542a9cd31381fce4d799189e8300b.1354677953.git.lv.zheng@intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com> <cover.1354677952.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1354677952.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>
List-Id: linux-serial@vger.kernel.org

Export serial8250 uart driver for uart bus enumerator users.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/tty/serial/8250/8250.c |    5 ++---
 include/linux/serial_8250.h    |    2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 3ba4234..af78374 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -56,8 +56,6 @@ static unsigned int share_irqs = SERIAL8250_SHARE_IRQS;
 
 static unsigned int nr_uarts = CONFIG_SERIAL_8250_RUNTIME_UARTS;
 
-static struct uart_driver serial8250_reg;
-
 static int serial_index(struct uart_port *port)
 {
 	return (serial8250_reg.minor - 64) + port->line;
@@ -2902,7 +2900,7 @@ int serial8250_find_port(struct uart_port *p)
 #define SERIAL8250_CONSOLE	NULL
 #endif
 
-static struct uart_driver serial8250_reg = {
+struct uart_driver serial8250_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "serial",
 	.dev_name		= "ttyS",
@@ -2910,6 +2908,7 @@ static struct uart_driver serial8250_reg = {
 	.minor			= 64,
 	.cons			= SERIAL8250_CONSOLE,
 };
+EXPORT_SYMBOL_GPL(serial8250_reg);
 
 /*
  * early_serial_setup - early registration for 8250 ports
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index c174c90..687af38 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -96,6 +96,8 @@ struct uart_8250_port {
 	void			(*dl_write)(struct uart_8250_port *, int);
 };
 
+extern struct uart_driver serial8250_reg;
+
 int serial8250_register_8250_port(struct uart_8250_port *);
 void serial8250_unregister_port(int line);
 void serial8250_suspend_port(int line);
-- 
1.7.10

