From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/4] TTY: serial/m32r_sio, simplify old_serial_port
Date: Tue, 12 Jan 2016 10:59:07 +0100
Message-ID: <1452592749-25150-2-git-send-email-jslaby@suse.cz>
References: <1452592749-25150-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452592749-25150-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

The only variables in old_serial_port are port and irq. So make
old_serial_port contain only those two and move the initialization of
the rest to the place where old_serial_port is actually read.

Also get rid of SERIAL_PORT_DFNS. It is ugly and having the
initializer where it belongs makes more sense. Finally, use already
defined UART_NR in the loop.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/m32r_sio.c | 57 ++++++++++++-------------------------------
 1 file changed, 15 insertions(+), 42 deletions(-)

diff --git a/drivers/tty/serial/m32r_sio.c b/drivers/tty/serial/m32r_sio.c
index 3c76ffc2d10a..835b5697a455 100644
--- a/drivers/tty/serial/m32r_sio.c
+++ b/drivers/tty/serial/m32r_sio.c
@@ -66,48 +66,22 @@
 
 #define PASS_LIMIT	256
 
-#define BASE_BAUD	115200
-
 /* Standard COM flags */
 #define STD_COM_FLAGS (UPF_BOOT_AUTOCONF | UPF_SKIP_TEST)
 
-/*
- * SERIAL_PORT_DFNS tells us about built-in ports that have no
- * standard enumeration mechanism.   Platforms that can find all
- * serial ports via mechanisms like ACPI or PCI need not supply it.
- */
-#if defined(CONFIG_PLAT_USRV)
-
-#define SERIAL_PORT_DFNS						\
-       /* UART  CLK     PORT   IRQ            FLAGS */			\
-	{ 0, BASE_BAUD, 0x3F8, PLD_IRQ_UART0, STD_COM_FLAGS }, /* ttyS0 */ \
-	{ 0, BASE_BAUD, 0x2F8, PLD_IRQ_UART1, STD_COM_FLAGS }, /* ttyS1 */
-
-#else /* !CONFIG_PLAT_USRV */
-
-#if defined(CONFIG_SERIAL_M32R_PLDSIO)
-#define SERIAL_PORT_DFNS						\
-	{ 0, BASE_BAUD, ((unsigned long)PLD_ESIO0CR), PLD_IRQ_SIO0_RCV,	\
-	  STD_COM_FLAGS }, /* ttyS0 */
-#else
-#define SERIAL_PORT_DFNS						\
-	{ 0, BASE_BAUD, M32R_SIO_OFFSET, M32R_IRQ_SIO0_R,		\
-	  STD_COM_FLAGS }, /* ttyS0 */
-#endif
-
-#endif /* !CONFIG_PLAT_USRV */
-
 static const struct {
-	unsigned int uart;
-	unsigned int baud_base;
 	unsigned int port;
 	unsigned int irq;
-	unsigned int flags;
-	unsigned char io_type;
-	unsigned char __iomem *iomem_base;
-	unsigned short iomem_reg_shift;
 } old_serial_port[] = {
-	SERIAL_PORT_DFNS
+#if defined(CONFIG_PLAT_USRV)
+	/* PORT  IRQ            FLAGS */
+	{ 0x3F8, PLD_IRQ_UART0 }, /* ttyS0 */
+	{ 0x2F8, PLD_IRQ_UART1 }, /* ttyS1 */
+#elif defined(CONFIG_SERIAL_M32R_PLDSIO)
+	{ ((unsigned long)PLD_ESIO0CR), PLD_IRQ_SIO0_RCV }, /* ttyS0 */
+#else
+	{ M32R_SIO_OFFSET, M32R_IRQ_SIO0_R }, /* ttyS0 */
+#endif
 };
 
 #define UART_NR	ARRAY_SIZE(old_serial_port)
@@ -959,15 +933,14 @@ static void __init m32r_sio_init_ports(void)
 		return;
 	first = 0;
 
-	for (i = 0, up = m32r_sio_ports; i < ARRAY_SIZE(old_serial_port);
-	     i++, up++) {
+	for (i = 0, up = m32r_sio_ports; i < UART_NR; i++, up++) {
 		up->port.iobase   = old_serial_port[i].port;
 		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
-		up->port.uartclk  = old_serial_port[i].baud_base * 16;
-		up->port.flags    = old_serial_port[i].flags;
-		up->port.membase  = old_serial_port[i].iomem_base;
-		up->port.iotype   = old_serial_port[i].io_type;
-		up->port.regshift = old_serial_port[i].iomem_reg_shift;
+		up->port.uartclk  = BAUD_RATE * 16;
+		up->port.flags    = STD_COM_FLAGS;
+		up->port.membase  = 0;
+		up->port.iotype   = 0;
+		up->port.regshift = 0;
 		up->port.ops      = &m32r_sio_pops;
 	}
 }
-- 
2.7.0
