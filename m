From: Christopher Covington <cov@codeaurora.org>
Subject: [PATCH 2/2] tty: pl011: Work around QDF2400 E44 for earlycon
Date: Tue,  7 Feb 2017 19:57:36 -0500
Message-ID: <20170208005736.18724-2-cov@codeaurora.org>
References: <20170208005736.18724-1-cov@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170208005736.18724-1-cov@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, shankerd@codeaurora.org, timur@codeaurora.org, Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: Jon Masters <jcm@redhat.com>, Neil Leeder <nleeder@codeaurora.org>, Mark Langsdorf <mlangsdo@redhat.com>, Christopher Covington <cov@codeaurora.org>, Mark Salter <msalter@redhat.com>
List-Id: linux-serial@vger.kernel.org

The previous change worked around QDF2432v1 and QDF2400v1 SoC erratum 44
for the full-fledged console, when UART AMBA Port (UAP) data is available.
Additionally provide a workaround the earlycon case, again checking TXFE ==
0 instead of BUSY == 1. As earlycon is operating before UAP data is
available, the implementation is different than in the preceding patch.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 drivers/tty/serial/amba-pl011.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 41e51901d6ef..f25e7c994f8e 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2411,6 +2411,29 @@ static bool qdf2400_e44(void) {
 	    cpu_var_model == MIDR_QCOM_FALKOR_V1);
 }
 
+#ifdef CONFIG_QCOM_QDF2400_ERRATUM_44
+static void qdf2400_e44_putc(struct uart_port *port, int c)
+{
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
+		cpu_relax();
+	if (port->iotype == UPIO_MEM32)
+		writel(c, port->membase + UART01x_DR);
+	else
+		writeb(c, port->membase + UART01x_DR);
+	while (!(readl(port->membase + UART01x_FR) & UART011_FR_TXFE))
+		cpu_relax();
+}
+
+static void qdf2400_e44_early_write(struct console *con, const char *s, unsigned n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, qdf2400_e44_putc);
+}
+#else
+#define qdf2400_e44_early_write pl011_early_write
+#endif
+
 static void pl011_putc(struct uart_port *port, int c)
 {
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
@@ -2436,7 +2459,10 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->con->write = pl011_early_write;
+	if (qdf2400_e44())
+		device->con->write = qdf2400_e44_early_write;
+	else
+		device->con->write = pl011_early_write;
 	return 0;
 }
 OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project.
