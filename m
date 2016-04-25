From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 3/3] serial: mps2-uart: add support for early console
Date: Mon, 25 Apr 2016 09:47:48 +0100
Message-ID: <1461574068-14641-4-git-send-email-vladimir.murzin@arm.com>
References: <1461574068-14641-1-git-send-email-vladimir.murzin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1461574068-14641-1-git-send-email-vladimir.murzin@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de, jslaby@suse.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This adds support early console for MPS2 UART which can be enabled via
earlycon=mps2,0x40004000

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 drivers/tty/serial/Kconfig     |    1 +
 drivers/tty/serial/mps2-uart.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 3673ef0..4e6d2d1 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1450,6 +1450,7 @@ config SERIAL_MPS2_UART_CONSOLE
 	bool "MPS2 UART console support"
 	depends on SERIAL_MPS2_UART
 	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
 
 config SERIAL_MPS2_UART
 	bool "MPS2 UART port"
diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index e571e4c..da9e27d 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -450,6 +450,34 @@ static struct console mps2_uart_console = {
 
 #define MPS2_SERIAL_CONSOLE (&mps2_uart_console)
 
+static void mps2_early_putchar(struct uart_port *port, int ch)
+{
+	while (readb(port->membase + UARTn_STATE) & UARTn_STATE_TX_FULL)
+		cpu_relax();
+
+	writeb((unsigned char)ch, port->membase + UARTn_DATA);
+}
+
+static void mps2_early_write(struct console *con, const char *s, unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, mps2_early_putchar);
+}
+
+static int __init mps2_early_console_setup(struct earlycon_device *device,
+					   const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = mps2_early_write;
+
+	return 0;
+}
+
+OF_EARLYCON_DECLARE(mps2, "arm,mps2-uart", mps2_early_console_setup);
+
 #else
 #define MPS2_SERIAL_CONSOLE NULL
 #endif
-- 
1.7.9.5
