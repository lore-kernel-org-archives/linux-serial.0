From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/8] serial: tegra: Correct delay after TX flush
Date: Tue, 5 May 2015 15:17:52 +0100
Message-ID: <1430835479-6613-2-git-send-email-jonathanh@nvidia.com>
References: <1430835479-6613-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430835479-6613-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

For all tegra devices (up to t210), there is a hardware issue that
requires software to wait for 32 UART clock periods for the flush
to propagate otherwise TX data could be post. Add a helper function
to wait for N UART clock periods and update delay following FIFO
flush to be 32 UART clock cycles.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/tty/serial/serial-tegra.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 1d5ea3964ee5..9e08d3f07509 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -234,6 +234,22 @@ static void tegra_uart_break_ctl(struct uart_port *u, int break_ctl)
 	tup->lcr_shadow = lcr;
 }
 
+/**
+ * tegra_uart_wait_cycle_time: Wait for N UART clock periods
+ *
+ * @tup:	Tegra serial port data structure.
+ * @cycles:	Number of clock periods to wait.
+ *
+ * Tegra UARTs are clocked at 16X the baud/bit rate and hence the UART
+ * clock speed is 16X the current baud rate.
+ */
+static void tegra_uart_wait_cycle_time(struct tegra_uart_port *tup,
+				       unsigned int cycles)
+{
+	if (tup->current_baud)
+		udelay(DIV_ROUND_UP(cycles * 1000000, tup->current_baud * 16));
+}
+
 /* Wait for a symbol-time. */
 static void tegra_uart_wait_sym_time(struct tegra_uart_port *tup,
 		unsigned int syms)
@@ -263,8 +279,12 @@ static void tegra_uart_fifo_reset(struct tegra_uart_port *tup, u8 fcr_bits)
 	/* Dummy read to ensure the write is posted */
 	tegra_uart_read(tup, UART_SCR);
 
-	/* Wait for the flush to propagate. */
-	tegra_uart_wait_sym_time(tup, 1);
+	/*
+	 * For all tegra devices (up to t210), there is a hardware issue that
+	 * requires software to wait for 32 UART clock periods for the flush
+	 * to propagate, otherwise data could be lost.
+	 */
+	tegra_uart_wait_cycle_time(tup, 32);
 }
 
 static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
-- 
1.9.1
