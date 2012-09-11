From: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: [PATCH 05/12] tty/serial/amba-pl011: Implement poll_init callback
Date: Tue, 11 Sep 2012 02:34:59 -0700
Message-ID: <1347356106-25368-5-git-send-email-anton.vorontsov@linaro.org>
References: <20120911093042.GA12471@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120911093042.GA12471@lizard>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, John Stultz <john.stultz@linaro.org>, linux-serial@vger.kernel.org, Colin Cross <ccross@android.com>, kgdb-bugreport@lists.sourceforge.net, kernel-team@android.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The callback is used to initialize the hardware, nothing else should be
done, i.e. we should not request interrupts (but we can and do unmask
some of them, as they might be useful for NMI entry).

As a side-effect, the patch also fixes a division by zero[1] when booting
with kgdboc options specified (e.g. kgdboc=ttyAMA0,115200n8). The issue
happens because serial core calls set_termios callback, but the driver
doesn't know clock frequency, and thus cannot calculate proper baud rate
values.

[1]
WARNING: at drivers/tty/serial/serial_core.c:400 uart_get_baud_rate+0xe8/0x14c()
Modules linked in:
[<c0018e50>] (unwind_backtrace+0x0/0xf0) from [<c0020ae8>] (warn_slowpath_common+0x4c/0x64)
[<c0020ae8>] (warn_slowpath_common+0x4c/0x64) from [<c0020b1c>] (warn_slowpath_null+0x1c/0x24)
[<c0020b1c>] (warn_slowpath_null+0x1c/0x24) from [<c0185ed8>] (uart_get_baud_rate+0xe8/0x14c)
[<c0185ed8>] (uart_get_baud_rate+0xe8/0x14c) from [<c0187078>] (pl011_set_termios+0x48/0x278)
[<c0187078>] (pl011_set_termios+0x48/0x278) from [<c01850b0>] (uart_set_options+0xe8/0x114)
[<c01850b0>] (uart_set_options+0xe8/0x114) from [<c0185de4>] (uart_poll_init+0xd4/0xe0)
[<c0185de4>] (uart_poll_init+0xd4/0xe0) from [<c016da8c>] (tty_find_polling_driver+0x100/0x17c)
[<c016da8c>] (tty_find_polling_driver+0x100/0x17c) from [<c0188538>] (configure_kgdboc+0xc8/0x1b8)
[<c0188538>] (configure_kgdboc+0xc8/0x1b8) from [<c00088a4>] (do_one_initcall+0x30/0x168)
[<c00088a4>] (do_one_initcall+0x30/0x168) from [<c033784c>] (do_basic_setup+0x94/0xc8)
[<c033784c>] (do_basic_setup+0x94/0xc8) from [<c03378e0>] (kernel_init+0x60/0xf4)
[<c03378e0>] (kernel_init+0x60/0xf4) from [<c00144a0>] (kernel_thread_exit+0x0/0x8)
---[ end trace 7d41c9186f342c40 ]---
Division by zero in kernel.
[<c0018e50>] (unwind_backtrace+0x0/0xf0) from [<c014546c>] (Ldiv0+0x8/0x10)
[<c014546c>] (Ldiv0+0x8/0x10) from [<c0187098>] (pl011_set_termios+0x68/0x278)
[<c0187098>] (pl011_set_termios+0x68/0x278) from [<c01850b0>] (uart_set_options+0xe8/0x114)
[<c01850b0>] (uart_set_options+0xe8/0x114) from [<c0185de4>] (uart_poll_init+0xd4/0xe0)
[<c0185de4>] (uart_poll_init+0xd4/0xe0) from [<c016da8c>] (tty_find_polling_driver+0x100/0x17c)
[<c016da8c>] (tty_find_polling_driver+0x100/0x17c) from [<c0188538>] (configure_kgdboc+0xc8/0x1b8)
[<c0188538>] (configure_kgdboc+0xc8/0x1b8) from [<c00088a4>] (do_one_initcall+0x30/0x168)
[<c00088a4>] (do_one_initcall+0x30/0x168) from [<c033784c>] (do_basic_setup+0x94/0xc8)
[<c033784c>] (do_basic_setup+0x94/0xc8) from [<c03378e0>] (kernel_init+0x60/0xf4)
[<c03378e0>] (kernel_init+0x60/0xf4) from [<c00144a0>] (kernel_thread_exit+0x0/0x8)
Division by zero in kernel.
[<c0018e50>] (unwind_backtrace+0x0/0xf0) from [<c014546c>] (Ldiv0+0x8/0x10)
[<c014546c>] (Ldiv0+0x8/0x10) from [<c0183a98>] (uart_update_timeout+0x4c/0x5c)
[<c0183a98>] (uart_update_timeout+0x4c/0x5c) from [<c01870f8>] (pl011_set_termios+0xc8/0x278)
[<c01870f8>] (pl011_set_termios+0xc8/0x278) from [<c01850b0>] (uart_set_options+0xe8/0x114)
[<c01850b0>] (uart_set_options+0xe8/0x114) from [<c0185de4>] (uart_poll_init+0xd4/0xe0)
[<c0185de4>] (uart_poll_init+0xd4/0xe0) from [<c016da8c>] (tty_find_polling_driver+0x100/0x17c)
[<c016da8c>] (tty_find_polling_driver+0x100/0x17c) from [<c0188538>] (configure_kgdboc+0xc8/0x1b8)
[<c0188538>] (configure_kgdboc+0xc8/0x1b8) from [<c00088a4>] (do_one_initcall+0x30/0x168)
[<c00088a4>] (do_one_initcall+0x30/0x168) from [<c033784c>] (do_basic_setup+0x94/0xc8)
[<c033784c>] (do_basic_setup+0x94/0xc8) from [<c03378e0>] (kernel_init+0x60/0xf4)
[<c03378e0>] (kernel_init+0x60/0xf4) from [<c00144a0>] (kernel_thread_exit+0x0/0x8)

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 44 ++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index cede938..45137e4 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1309,10 +1309,9 @@ static void pl011_put_poll_char(struct uart_port *port,
 
 #endif /* CONFIG_CONSOLE_POLL */
 
-static int pl011_startup(struct uart_port *port)
+static int pl011_hwinit(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
-	unsigned int cr;
 	int retval;
 
 	/* Optionaly enable pins to be muxed in and configured */
@@ -1337,6 +1336,37 @@ static int pl011_startup(struct uart_port *port)
 	       UART011_RTIS | UART011_RXIS, uap->port.membase + UART011_ICR);
 
 	/*
+	 * Save interrupts enable mask, and enable RX interrupts in case if
+	 * the interrupt is used for NMI entry.
+	 */
+	uap->im = readw(uap->port.membase + UART011_IMSC);
+	writew(UART011_RTIM | UART011_RXIM, uap->port.membase + UART011_IMSC);
+
+	if (uap->port.dev->platform_data) {
+		struct amba_pl011_data *plat;
+
+		plat = uap->port.dev->platform_data;
+		if (plat->init)
+			plat->init();
+	}
+	return 0;
+ out:
+	return retval;
+}
+
+static int pl011_startup(struct uart_port *port)
+{
+	struct uart_amba_port *uap = (struct uart_amba_port *)port;
+	unsigned int cr;
+	int retval;
+
+	retval = pl011_hwinit(port);
+	if (retval)
+		goto clk_dis;
+
+	writew(uap->im, uap->port.membase + UART011_IMSC);
+
+	/*
 	 * Allocate the IRQ
 	 */
 	retval = request_irq(uap->port.irq, pl011_int, 0, "uart-pl011", uap);
@@ -1395,19 +1425,10 @@ static int pl011_startup(struct uart_port *port)
 	writew(uap->im, uap->port.membase + UART011_IMSC);
 	spin_unlock_irq(&uap->port.lock);
 
-	if (uap->port.dev->platform_data) {
-		struct amba_pl011_data *plat;
-
-		plat = uap->port.dev->platform_data;
-		if (plat->init)
-			plat->init();
-	}
-
 	return 0;
 
  clk_dis:
 	clk_disable_unprepare(uap->clk);
- out:
 	return retval;
 }
 
@@ -1688,6 +1709,7 @@ static struct uart_ops amba_pl011_pops = {
 	.config_port	= pl011_config_port,
 	.verify_port	= pl011_verify_port,
 #ifdef CONFIG_CONSOLE_POLL
+	.poll_init     = pl011_hwinit,
 	.poll_get_char = pl011_get_poll_char,
 	.poll_put_char = pl011_put_poll_char,
 #endif
-- 
1.7.11.5
