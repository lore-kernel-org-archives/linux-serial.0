From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] serial: meson: hide an unused function
Date: Mon, 22 May 2017 15:37:03 +0200
Message-ID: <20170522133746.880230-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Heiner Kallweit <hkallweit1@gmail.com>
List-Id: linux-serial@vger.kernel.org

The newly added meson_uart_enable_tx_engine function is only called
from the console setup, not the runtime uart, which has an open-coded
version of the same register access. This produces a harmless warning
when the console code is disabled:

drivers/tty/serial/meson_uart.c:127:13: error: 'meson_uart_enable_tx_engine' defined but not used [-Werror=unused-function]

Let's move the function inside of the #ifdef to avoid the warning.

Fixes: ba50f1df13c8 ("serial: meson: remove unneeded variable assignment in meson_serial_port_write")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/meson_uart.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 082e038e67f8..c0e34dabadd8 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -124,15 +124,6 @@ static void meson_uart_stop_rx(struct uart_port *port)
 	writel(val, port->membase + AML_UART_CONTROL);
 }
 
-static void meson_uart_enable_tx_engine(struct uart_port *port)
-{
-	u32 val;
-
-	val = readl(port->membase + AML_UART_CONTROL);
-	val |= AML_UART_TX_EN;
-	writel(val, port->membase + AML_UART_CONTROL);
-}
-
 static void meson_uart_shutdown(struct uart_port *port)
 {
 	unsigned long flags;
@@ -451,6 +442,14 @@ static struct uart_ops meson_uart_ops = {
 };
 
 #ifdef CONFIG_SERIAL_MESON_CONSOLE
+static void meson_uart_enable_tx_engine(struct uart_port *port)
+{
+	u32 val;
+
+	val = readl(port->membase + AML_UART_CONTROL);
+	val |= AML_UART_TX_EN;
+	writel(val, port->membase + AML_UART_CONTROL);
+}
 
 static void meson_console_putchar(struct uart_port *port, int ch)
 {
-- 
2.9.0
