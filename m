From: Helmut Grohne <h.grohne@intenta.de>
Subject: [PATCH v3 2/3] serial: xuartps: reduce hardware TX race condition
Date: Mon, 4 Jun 2018 12:22:11 +0200
Message-ID: <14d0c12dd975957c11afc5a9730f90756a309292.1528106392.git.h.grohne@intenta.de>
References: <cover.1528106392.git.h.grohne@intenta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cover.1528106392.git.h.grohne@intenta.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
List-Id: linux-serial@vger.kernel.org

After sending data to the uart, the driver was waiting until the TX
FIFO was empty (for every single char written). After that, TX was
disabled by writing the original TX state to the status register. At
that time however, the state machine could still be shifting
characters. Not waiting can result in strange hardware states,
especially when coupled with calls to cdns_uart_set_termios, whose
symptom generally is garbage characters being received from uart or a
hang.

According to UG585, the TACTIVE bit of the channel status register
indicates the shifter operation and we should be waiting for that bit
to clear.

Sending characters does not require the TX FIFO to be empty, but merely
to not be full. So cdns_uart_console_putchar is updated accordingly.

During tests with an instrumented kernel and an oscilloscope, we could
determine that the chance of a race is reduced by this patch. It is not
removed entirely. On the oscilloscope, one can see that disabling the
transmitter early can result in the transmission hanging in the middle
of a character for a tiny duration. This hiccup is enough to
desynchronize with a remote device for a sequence of characters until a
data bit doesn't match the start or stop bits anymore.

Link: https://www.spinics.net/lists/linux-serial/msg23156.html
Link: https://www.spinics.net/lists/linux-serial/msg26139.html
Signed-off-by: Helmut Grohne <h.grohne@intenta.de>
Acked-by: S=F6ren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx=
_uartps.c
index e4b2d8102a04..a34b2c757593 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -167,6 +167,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
 #define CDNS_UART_SR_TXEMPTY	0x00000008 /* TX FIFO empty */
 #define CDNS_UART_SR_TXFULL	0x00000010 /* TX FIFO full */
 #define CDNS_UART_SR_RXTRIG	0x00000001 /* Rx Trigger */
+#define CDNS_UART_SR_TACTIVE	0x00000800 /* TX state machine active */
 =

 /* baud dividers min/max values */
 #define CDNS_UART_BDIV_MIN	4
@@ -1138,23 +1139,14 @@ static struct uart_port *cdns_uart_get_port(int id)
 =

 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 /**
- * cdns_uart_console_wait_tx - Wait for the TX to be full
- * @port: Handle to the uart port structure
- */
-static void cdns_uart_console_wait_tx(struct uart_port *port)
-{
-	while (!(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXEMPTY))
-		barrier();
-}
-
-/**
  * cdns_uart_console_putchar - write the character to the FIFO buffer
  * @port: Handle to the uart port structure
  * @ch: Character to be written
  */
 static void cdns_uart_console_putchar(struct uart_port *port, int ch)
 {
-	cdns_uart_console_wait_tx(port);
+	while (readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)
+		cpu_relax();
 	writel(ch, port->membase + CDNS_UART_FIFO);
 }
 =

@@ -1241,7 +1233,10 @@ static void cdns_uart_console_write(struct console *=
co, const char *s,
 	writel(ctrl, port->membase + CDNS_UART_CR);
 =

 	uart_console_write(port, s, count, cdns_uart_console_putchar);
-	cdns_uart_console_wait_tx(port);
+	while ((readl(port->membase + CDNS_UART_SR) &
+			(CDNS_UART_SR_TXEMPTY | CDNS_UART_SR_TACTIVE)) !=3D
+			CDNS_UART_SR_TXEMPTY)
+		cpu_relax();
 =

 	writel(ctrl, port->membase + CDNS_UART_CR);
 =

-- =

2.11.0
