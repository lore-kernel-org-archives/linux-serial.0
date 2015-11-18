From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 7/9] ARM: meson: serial: disable rx/tx irqs during console
 write
Date: Wed, 18 Nov 2015 14:41:17 +0000
Message-ID: <1447857679-30158-8-git-send-email-ben.dooks@codethink.co.uk>
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

As an attempt to stop issues with bad console output, ensure that both the
rx and tx interrupts are disabled during the console write to avoid any
problems with console and non-console being called together.

This should help with the SMP case as it should stop other cores being
signalled during the console write.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/tty/serial/meson_uart.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index d3f2c96..12436cc 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -472,7 +472,7 @@ static void meson_serial_console_write(struct console *co, const char *s,
 	struct uart_port *port;
 	unsigned long flags;
 	int locked;
-	u32 val;
+	u32 val, tmp;
 
 	port = meson_ports[co->index];
 	if (!port)
@@ -489,9 +489,12 @@ static void meson_serial_console_write(struct console *co, const char *s,
 	}
 
 	val = readl(port->membase + AML_UART_CONTROL);
-	writel(val | AML_UART_TX_EN, port->membase + AML_UART_CONTROL);
+	val |= AML_UART_TX_EN;
+	tmp = val & ~(AML_UART_TX_INT_EN | AML_UART_RX_INT_EN);
+	writel(tmp, port->membase + AML_UART_CONTROL);
 
 	uart_console_write(port, s, count, meson_console_putchar);
+	writel(val, port->membase + AML_UART_CONTROL);
 
 	if (locked)
 		spin_unlock(&port->lock);
-- 
2.6.2
