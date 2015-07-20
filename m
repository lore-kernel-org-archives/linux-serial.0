From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] tty/serial: atmel: use proper accessors
Date: Mon, 20 Jul 2015 15:56:12 +0200
Message-ID: <1437400572-16575-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

On ARM, it is necessary to use the _relaxed versions of read[bl] and
write[bl] to ensure we do the correct endianness conversion when running in
big endian.
Keep using avr32 __raw version on avr32 to avoid breakage.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---

This patch applies after [PATCH v4 0/5] tty/serial: at91: add support to FIFOs
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/353704.html

 drivers/tty/serial/atmel_serial.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index e91b3b2f0590..451acf054281 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -194,6 +194,7 @@ to_atmel_uart_port(struct uart_port *uart)
 	return container_of(uart, struct atmel_uart_port, uart);
 }
 
+#ifdef CONFIG_AVR32
 static inline u32 atmel_uart_readl(struct uart_port *port, u32 reg)
 {
 	return __raw_readl(port->membase + reg);
@@ -213,6 +214,27 @@ static inline void atmel_uart_writeb(struct uart_port *port, u32 reg, u8 value)
 {
 	__raw_writeb(value, port->membase + reg);
 }
+#else
+static inline u32 atmel_uart_readl(struct uart_port *port, u32 reg)
+{
+	return readl_relaxed(port->membase + reg);
+}
+
+static inline void atmel_uart_writel(struct uart_port *port, u32 reg, u32 value)
+{
+	writel_relaxed(value, port->membase + reg);
+}
+
+static inline u8 atmel_uart_readb(struct uart_port *port, u32 reg)
+{
+	return readb_relaxed(port->membase + reg);
+}
+
+static inline void atmel_uart_writeb(struct uart_port *port, u32 reg, u8 value)
+{
+	writeb_relaxed(value, port->membase + reg);
+}
+#endif
 
 #ifdef CONFIG_SERIAL_ATMEL_PDC
 static bool atmel_use_pdc_rx(struct uart_port *port)
-- 
2.1.4
