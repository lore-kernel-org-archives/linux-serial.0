From: dean_jenkins@mentor.com
Subject: [PATCH 5/5] serial: imx: clean up imx_poll_get_char()
Date: Fri,  9 May 2014 16:19:48 +0100
Message-ID: <1399648788-26061-6-git-send-email-dean_jenkins@mentor.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: dirk.behme@de.bosch.com, s.hauer@pengutronix.de, dean_jenkins@mentor.com, b32955@freescale.com, linux-arm-kernel@lists.infradead.org, shawn.guo@freescale.com
List-Id: linux-serial@vger.kernel.org

From: Dirk Behme <dirk.behme@de.bosch.com>

Looking at the get_poll_char() function of the 8250.c serial driver,
we learn:

* poll_get_char() doesn't have to save/disable/restore the interrupt
  registers. No interrupt handling is needed in this function at all.
  Remove it.

* Don't block in case there is no data available. So instead blocking
  in the do {} while loop, just return with NO_POLL_CHAR, immediately .

Additionally, while the i.MX6 register URXD[7-0] contain the RX_DATA,
the upper bits of this register (URXD[15-10]) might contain some
control flags. To ensure that these are not returned with the data
read, just mask out URXD[7-0].

These changes fix the 'hang' working with kdb:

$ echo ttymxc3 > /sys/module/kgdboc/parameters/kgdboc
$ echo g >/proc/sysrq-trigger
[0]kdb> help
...
<hang>

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/tty/serial/imx.c |   29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7b0ef85..9d59354 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -80,6 +80,7 @@
 #define URXD_FRMERR	(1<<12)
 #define URXD_BRK	(1<<11)
 #define URXD_PRERR	(1<<10)
+#define URXD_RX_DATA	(0xFF<<0)
 #define UCR1_ADEN	(1<<15) /* Auto detect interrupt */
 #define UCR1_ADBR	(1<<14) /* Auto detect baud rate */
 #define UCR1_TRDYEN	(1<<13) /* Transmitter ready interrupt enable */
@@ -1502,32 +1503,10 @@ imx_verify_port(struct uart_port *port, struct serial_struct *ser)
 #if defined(CONFIG_CONSOLE_POLL)
 static int imx_poll_get_char(struct uart_port *port)
 {
-	struct imx_port_ucrs old_ucr;
-	unsigned int status;
-	unsigned char c;
-
-	/* save control registers */
-	imx_port_ucrs_save(port, &old_ucr);
-
-	/* disable interrupts */
-	writel(UCR1_UARTEN, port->membase + UCR1);
-	writel(old_ucr.ucr2 & ~(UCR2_ATEN | UCR2_RTSEN | UCR2_ESCI),
-	       port->membase + UCR2);
-	writel(old_ucr.ucr3 & ~(UCR3_DCD | UCR3_RI | UCR3_DTREN),
-	       port->membase + UCR3);
-
-	/* poll */
-	do {
-		status = readl(port->membase + USR2);
-	} while (~status & USR2_RDR);
-
-	/* read */
-	c = readl(port->membase + URXD0);
-
-	/* restore control registers */
-	imx_port_ucrs_restore(port, &old_ucr);
+	if (!(readl(port->membase + USR2) & USR2_RDR))
+		return NO_POLL_CHAR;
 
-	return c;
+	return readl(port->membase + URXD0) & URXD_RX_DATA;
 }
 
 static void imx_poll_put_char(struct uart_port *port, unsigned char c)
-- 
1.7.9.5
