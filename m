From: Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v3] tty/serial: at91: restore dynamic driver binding
Date: Fri, 26 Feb 2016 11:15:04 +0100
Message-ID: <1456481704-18997-1-git-send-email-romain.izard.pro@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Jiri Slaby <jslaby@suse.com>, Romain Izard <romain.izard.pro@gmail.com>
List-Id: linux-serial@vger.kernel.org

In commit c39dfebc7798956fd2140ae6321786ff35da30c3, the modular support
code for atmel_serial was removed, as the driver cannot be built as a
module. Because no use case was proposed, the dynamic driver binding
support was removed as well.

The atmel_serial driver can manage up to 7 serial controllers, which are
multiplexed with other functions. For example, in the Atmel SAMA5D2, the
Flexcom controllers can work as USART, SPI or I2C controllers, and on
all Atmel devices serial lines can be reconfigured as GPIOs.

My use case uses GPIOs to transfer a firmware update using a custom
protocol on the lines used as a serial port during the normal life of
the device. If it is not possible to unbind the atmel_serial driver, the
GPIO lines remain reserved and prevent this case from working.

This patch reinstates the atmel_serial_remove function, and fixes it as
it failed to clear the "clk" field on removal, triggering an oops when
a device was bound again after being unbound.

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
Changelog:
v2: Add the rationale for keeping the "remove" function as a comment.
v3: Do not cleanup the spaces in the driver initializer, as requested by
  the maintainer

 drivers/tty/serial/atmel_serial.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 1c0884d8ef32..969084455f94 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2759,14 +2759,47 @@ err:
 	return ret;
 }
 
+/*
+ * Even if the driver is not modular, it makes sense to be able to
+ * unbind a device: there can be many bound devices, and there are
+ * situations where dynamic binding and unbinding can be useful.
+ *
+ * For example, a connected device can require a specific firmware update
+ * protocol that needs bitbanging on IO lines, but use the regular serial
+ * port in the normal case.
+ */
+static int atmel_serial_remove(struct platform_device *pdev)
+{
+	struct uart_port *port = platform_get_drvdata(pdev);
+	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	int ret = 0;
+
+	tasklet_kill(&atmel_port->tasklet);
+
+	device_init_wakeup(&pdev->dev, 0);
+
+	ret = uart_remove_one_port(&atmel_uart, port);
+
+	kfree(atmel_port->rx_ring.buf);
+
+	/* "port" is allocated statically, so we shouldn't free it */
+
+	clear_bit(port->line, atmel_ports_in_use);
+
+	clk_put(atmel_port->clk);
+	atmel_port->clk = NULL;
+
+	return ret;
+}
+
 static struct platform_driver atmel_serial_driver = {
 	.probe		= atmel_serial_probe,
+	.remove		= atmel_serial_remove,
 	.suspend	= atmel_serial_suspend,
 	.resume		= atmel_serial_resume,
 	.driver		= {
 		.name			= "atmel_usart",
 		.of_match_table		= of_match_ptr(atmel_serial_dt_ids),
-		.suppress_bind_attrs    = true,
 	},
 };
 
-- 
2.5.0
