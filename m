From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] serial: omap: Prevent DoS using unprivileged ioctl(TIOCSRS485)
Date: Tue, 12 Jan 2016 15:14:46 -0800
Message-ID: <1452640486-13974-1-git-send-email-peter@hurleysoftware.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, "Matwey V . Kornilov" <matwey@sai.msu.ru>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>, "# 3 . 12+" <stable@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

The omap-serial driver emulates RS485 delays using software timers,
but neglects to clamp the input values from the unprivileged
ioctl(TIOCSRS485). Because the software implementation busy-waits,
malicious userspace could stall the cpu for ~49 days.

Clamp the input values to < 100ms.

Fixes: 4a0ac0f55b18 ("OMAP: add RS485 support")
Cc: <stable@vger.kernel.org>  # 3.12+
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/omap-serial.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index b645f92..27d3b97 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1343,7 +1343,7 @@ static inline void serial_omap_add_console_port(struct uart_omap_port *up)
 
 /* Enable or disable the rs485 support */
 static int
-serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
+serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485)
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
 	unsigned int mode;
@@ -1356,8 +1356,12 @@ serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 	up->ier = 0;
 	serial_out(up, UART_IER, 0);
 
+	/* Clamp the delays to [0, 100ms] */
+	rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
+	rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send, 100U);
+
 	/* store new config */
-	port->rs485 = *rs485conf;
+	port->rs485 = *rs485;
 
 	/*
 	 * Just as a precaution, only allow rs485
-- 
2.7.0
