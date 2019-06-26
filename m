From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 2/2] serial: imx: use UPF_AUTO_CTS
Date: Wed, 26 Jun 2019 12:15:57 +0200
Message-ID: <20190626101557.26299-3-s.hauer@pengutronix.de>
References: <20190626101557.26299-1-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190626101557.26299-1-s.hauer@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Sergey Organov <sorganov@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The i.MX driver doesn't set the UPF_AUTO_CTS flag which means that
uart_handle_cts_change() will stop/start the receiver on CTS changes.
This is completely unnecessary as the hardware will handle CTS
changes automatically.

With UPF_AUTO_CTS enabled uart_handle_cts_change() boils down to
increasing the CTS statistic counter. For clarity inline increasing
the counter instead of calling uart_handle_cts_change().

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0419a084c0ed..82f987dab066 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -703,13 +703,11 @@ static void imx_uart_start_tx(struct uart_port *port)
 static irqreturn_t imx_uart_rtsint(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
-	u32 usr1;
 
 	spin_lock(&sport->port.lock);
 
 	imx_uart_writel(sport, USR1_RTSD, USR1);
-	usr1 = imx_uart_readl(sport, USR1) & USR1_RTSS;
-	uart_handle_cts_change(&sport->port, !!usr1);
+	sport->port.icount.cts++;
 	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);
 
 	spin_unlock(&sport->port.lock);
@@ -1588,6 +1586,9 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	} else if (termios->c_cflag & CRTSCTS) {
 		if (ucr2 & UCR2_CTS)
 			ucr2 |= UCR2_CTSC;
+		port->status |= UPSTAT_AUTOCTS;
+	} else {
+		port->status &= ~UPSTAT_AUTOCTS;
 	}
 
 	if (termios->c_cflag & CRTSCTS)
@@ -1706,6 +1707,9 @@ static void imx_uart_config_port(struct uart_port *port, int flags)
 
 	if (flags & UART_CONFIG_TYPE)
 		sport->port.type = PORT_IMX;
+
+	if (sport->have_rtscts)
+		sport->port.flags |= UPF_AUTO_CTS;
 }
 
 /*
-- 
2.20.1
