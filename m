From: Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
Subject: [PATCH] serial: 8250: Add CAP_MINI, set for bcm2835aux
Date: Fri, 19 May 2017 16:07:23 +0100
Message-ID: <8d9c605a-bff7-607c-2c5b-4ec75e68ac2d@raspberrypi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

The AUX/mini-UART in the BCM2835 family of procesors is a cut-down
8250 clone. In particular it is lacking support for the following
features: CSTOPB PARENB PARODD CMSPAR CS5 CS6

Add a new capability (UART_CAP_MINI) that exposes the restrictions to
the user of the termios API by turning off the unsupported features in
the request.

N.B. It is almost possible to automatically discover the missing
features by reading back the LCR register, but the CSIZE bits don't
cooperate (contrary to the documentation, both bits are significant,
but CS5 and CS6 are mapped to CS7) and the code is much longer.

See: https://github.com/raspberrypi/linux/issues/1561

Signed-off-by: Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
---
 drivers/tty/serial/8250/8250.h            | 3 +++
 drivers/tty/serial/8250/8250_bcm2835aux.c | 2 +-
 drivers/tty/serial/8250/8250_port.c       | 6 ++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index ce8d4ff..b2bdc35 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -81,6 +81,9 @@ struct serial8250_config {
 #define UART_CAP_HFIFO	(1 << 14)	/* UART has a "hidden" FIFO */
 #define UART_CAP_RPM	(1 << 15)	/* Runtime PM is active while idle */
 #define UART_CAP_IRDA	(1 << 16)	/* UART supports IrDA line discipline */
+#define UART_CAP_MINI	(1 << 17)	/* Mini UART on BCM283X family lacks:
+					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
+					 */
 
 #define UART_BUG_QUOT	(1 << 0)	/* UART has buggy quot LSB */
 #define UART_BUG_TXEN	(1 << 1)	/* UART has buggy TX IIR status */
diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index e10f124..a23c7da 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -39,7 +39,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 
 	/* initialize data */
 	spin_lock_init(&data->uart.port.lock);
-	data->uart.capabilities = UART_CAP_FIFO;
+	data->uart.capabilities = UART_CAP_FIFO | UART_CAP_MINI;
 	data->uart.port.dev = &pdev->dev;
 	data->uart.port.regshift = 2;
 	data->uart.port.type = PORT_16550;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 09a65a3..dd218a1 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2584,6 +2584,12 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 	unsigned long flags;
 	unsigned int baud, quot, frac = 0;
 
+	if (up->capabilities & UART_CAP_MINI) {
+		termios->c_cflag &= ~(CSTOPB | PARENB | PARODD | CMSPAR);
+		if ((termios->c_cflag & CSIZE) == CS5 ||
+		    (termios->c_cflag & CSIZE) == CS6)
+			termios->c_cflag = (termios->c_cflag & ~CSIZE) | CS7;
+	}
 	cval = serial8250_compute_lcr(up, termios->c_cflag);
 
 	baud = serial8250_get_baud_rate(port, termios, old);
-- 
1.9.1
