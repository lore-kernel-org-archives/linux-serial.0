From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 04/10] drivers: PL011: refactor pl011_set_termios()
Date: Wed,  4 Mar 2015 17:59:48 +0000
Message-ID: <1425491994-23913-5-git-send-email-andre.przywara@arm.com>
References: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1425491994-23913-1-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux@arm.linux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-arm-kernel@lists.infradead.org, rob.herring@linaro.org, arnd@arndb.de, linux-serial@vger.kernel.org, Dave.Martin@arm.com
List-Id: linux-serial@vger.kernel.org

Split the pl011_set_termios() function into smaller chunks to allow
easier reuse later when adding SBSA support.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   60 +++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4e0036c..37b55ee 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1807,6 +1807,38 @@ static void pl011_shutdown(struct uart_port *port)
 }
 
 static void
+pl011_setup_status_masks(struct uart_port *port, struct ktermios *termios)
+{
+	port->read_status_mask = UART011_DR_OE | 255;
+	if (termios->c_iflag & INPCK)
+		port->read_status_mask |= UART011_DR_FE | UART011_DR_PE;
+	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
+		port->read_status_mask |= UART011_DR_BE;
+
+	/*
+	 * Characters to ignore
+	 */
+	port->ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		port->ignore_status_mask |= UART011_DR_FE | UART011_DR_PE;
+	if (termios->c_iflag & IGNBRK) {
+		port->ignore_status_mask |= UART011_DR_BE;
+		/*
+		 * If we're ignoring parity and break indicators,
+		 * ignore overruns too (for real raw support).
+		 */
+		if (termios->c_iflag & IGNPAR)
+			port->ignore_status_mask |= UART011_DR_OE;
+	}
+
+	/*
+	 * Ignore all characters if CREAD is not set.
+	 */
+	if ((termios->c_cflag & CREAD) == 0)
+		port->ignore_status_mask |= UART_DUMMY_DR_RX;
+}
+
+static void
 pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 		     struct ktermios *old)
 {
@@ -1870,33 +1902,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	 */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	port->read_status_mask = UART011_DR_OE | 255;
-	if (termios->c_iflag & INPCK)
-		port->read_status_mask |= UART011_DR_FE | UART011_DR_PE;
-	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
-		port->read_status_mask |= UART011_DR_BE;
-
-	/*
-	 * Characters to ignore
-	 */
-	port->ignore_status_mask = 0;
-	if (termios->c_iflag & IGNPAR)
-		port->ignore_status_mask |= UART011_DR_FE | UART011_DR_PE;
-	if (termios->c_iflag & IGNBRK) {
-		port->ignore_status_mask |= UART011_DR_BE;
-		/*
-		 * If we're ignoring parity and break indicators,
-		 * ignore overruns too (for real raw support).
-		 */
-		if (termios->c_iflag & IGNPAR)
-			port->ignore_status_mask |= UART011_DR_OE;
-	}
-
-	/*
-	 * Ignore all characters if CREAD is not set.
-	 */
-	if ((termios->c_cflag & CREAD) == 0)
-		port->ignore_status_mask |= UART_DUMMY_DR_RX;
+	pl011_setup_status_masks(port, termios);
 
 	if (UART_ENABLE_MS(port, termios->c_cflag))
 		pl011_enable_ms(port);
-- 
1.7.9.5
