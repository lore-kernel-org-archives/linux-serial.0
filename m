From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 4/9] ARM: meson: serial: ensure console port uart enabled
Date: Wed, 18 Nov 2015 14:41:14 +0000
Message-ID: <1447857679-30158-5-git-send-email-ben.dooks@codethink.co.uk>
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

Ensure the UART's transmitter is enabled when meson_console_putchar is
called. If not, then the console output is corrupt (the hardware seems
to try and send /something/ even if the TX is disabled).

This fixes corrupt console output on events such as trying to reboot the
system since the console tx may be called after drivers shutdown method has
been called.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reported-by: Edward Cragg <edward.cragg@codethink.co.uk>
--
---
 drivers/tty/serial/meson_uart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 54d1b95..c7bad2b 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -472,6 +472,7 @@ static void meson_serial_console_write(struct console *co, const char *s,
 	struct uart_port *port;
 	unsigned long flags;
 	int locked;
+	u32 val;
 
 	port = meson_ports[co->index];
 	if (!port)
@@ -487,6 +488,9 @@ static void meson_serial_console_write(struct console *co, const char *s,
 		locked = 1;
 	}
 
+	val = readl(port->membase + AML_UART_CONTROL);
+	writel(val | AML_UART_TX_EN, port->membase + AML_UART_CONTROL);
+
 	uart_console_write(port, s, count, meson_console_putchar);
 
 	if (locked)
-- 
2.6.2
