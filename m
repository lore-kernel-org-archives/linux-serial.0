From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/2] serial: atmel: evaluate linux,stdout-path property
Date: Sat,  8 Feb 2014 12:53:53 +0100
Message-ID: <1391860433-5343-2-git-send-email-plagnioj@jcrosoft.com>
References: <1391860433-5343-1-git-send-email-plagnioj@jcrosoft.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391860433-5343-1-git-send-email-plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

if the driver is built as module skip it as add_preferred_console is not
exported

Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
---
 drivers/tty/serial/atmel_serial.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index a49f10d..2ade64e 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2044,6 +2044,19 @@ static struct uart_ops atmel_pops = {
 #endif
 };
 
+static void atmel_of_preferred_console(struct atmel_uart_port *atmel_port,
+				       struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct uart_port *port = &atmel_port->uart;
+	char* option;
+
+	if (!np || !of_device_is_stdout_path(np, &option))
+		return;
+
+	add_preferred_console(ATMEL_DEVICENAME, port->line, option);
+}
+
 /*
  * Configure the port from the platform device resource info.
  */
@@ -2059,6 +2072,9 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 
 	atmel_init_rs485(atmel_port, pdev);
 
+	if (IS_BUILTIN(CONFIG_SERIAL_ATMEL))
+		atmel_of_preferred_console(atmel_port, pdev);
+
 	port->iotype		= UPIO_MEM;
 	port->flags		= UPF_BOOT_AUTOCONF;
 	port->ops		= &atmel_pops;
-- 
1.9.rc1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
