From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 2/9] ARM: meson: serial: don't reset port on uart startup
Date: Wed, 18 Nov 2015 14:41:12 +0000
Message-ID: <1447857679-30158-3-git-send-email-ben.dooks@codethink.co.uk>
References: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: edward.cragg@codethink.co.uk
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-meson@googlegroups.com, linux-kernel@codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, carlo@caione.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

When the uart startup entry is called, do not reset the port as this
could cause issues with anything left in the FIFO from a previous operation
such as a console write. Move the hardware reset to probe time and simply
clear the errors before enabling the port.

This fixes the issue where the console could become corrupted as there
where characters left in the output or output fifo when a user process
such as systemd would open/close the uart to transmit characters.

For example, you get:
    [    3.252263] systemd[1]: Dete

instead of:
    [    3.338801] systemd[1]: Detected architecture arm.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/tty/serial/meson_uart.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index b9f0829..b87eb97 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -241,10 +241,9 @@ static const char *meson_uart_type(struct uart_port *port)
 	return (port->type == PORT_MESON) ? "meson_uart" : NULL;
 }
 
-static int meson_uart_startup(struct uart_port *port)
+static void meson_uart_reset(struct uart_port *port)
 {
 	u32 val;
-	int ret = 0;
 
 	val = readl(port->membase + AML_UART_CONTROL);
 	val |= (AML_UART_RX_RST | AML_UART_TX_RST | AML_UART_CLR_ERR);
@@ -252,6 +251,18 @@ static int meson_uart_startup(struct uart_port *port)
 
 	val &= ~(AML_UART_RX_RST | AML_UART_TX_RST | AML_UART_CLR_ERR);
 	writel(val, port->membase + AML_UART_CONTROL);
+}
+
+static int meson_uart_startup(struct uart_port *port)
+{
+	u32 val;
+	int ret = 0;
+
+	val = readl(port->membase + AML_UART_CONTROL);
+	val |= AML_UART_CLR_ERR;
+	writel(val, port->membase + AML_UART_CONTROL);
+	val &= ~AML_UART_CLR_ERR;
+	writel(val, port->membase + AML_UART_CONTROL);
 
 	val |= (AML_UART_RX_EN | AML_UART_TX_EN);
 	writel(val, port->membase + AML_UART_CONTROL);
@@ -581,6 +592,12 @@ static int meson_uart_probe(struct platform_device *pdev)
 	meson_ports[pdev->id] = port;
 	platform_set_drvdata(pdev, port);
 
+	/* reset port before registering (and possibly registering console) */
+	if (meson_uart_request_port(port) >= 0) {
+		meson_uart_reset(port);
+		meson_uart_release_port(port);
+	}
+
 	ret = uart_add_one_port(&meson_uart_driver, port);
 	if (ret)
 		meson_ports[pdev->id] = NULL;
-- 
2.6.2
