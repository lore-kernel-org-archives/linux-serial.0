From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] tty/serial: remove AVR32 specific access wrappers
Date: Tue, 13 Jun 2017 22:25:17 +0200
Message-ID: <20170613202517.26558-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

Now that AVR32 is gone, the specific wrappers for that architecture are
unnecessary and will not be compiled anymore.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/tty/serial/atmel_serial.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 937d67f22fba..8bfc566df2da 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -228,21 +228,6 @@ static inline void atmel_uart_writel(struct uart_port *port, u32 reg, u32 value)
 	__raw_writel(value, port->membase + reg);
 }
 
-#ifdef CONFIG_AVR32
-
-/* AVR32 cannot handle 8 or 16bit I/O accesses but only 32bit I/O accesses */
-static inline u8 atmel_uart_read_char(struct uart_port *port)
-{
-	return __raw_readl(port->membase + ATMEL_US_RHR);
-}
-
-static inline void atmel_uart_write_char(struct uart_port *port, u8 value)
-{
-	__raw_writel(value, port->membase + ATMEL_US_THR);
-}
-
-#else
-
 static inline u8 atmel_uart_read_char(struct uart_port *port)
 {
 	return __raw_readb(port->membase + ATMEL_US_RHR);
@@ -253,8 +238,6 @@ static inline void atmel_uart_write_char(struct uart_port *port, u8 value)
 	__raw_writeb(value, port->membase + ATMEL_US_THR);
 }
 
-#endif
-
 #ifdef CONFIG_SERIAL_ATMEL_PDC
 static bool atmel_use_pdc_rx(struct uart_port *port)
 {
-- 
2.11.0
