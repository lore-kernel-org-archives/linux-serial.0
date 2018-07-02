From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH 1/2] serial: 8250: introduce get_divisor() and set_divisor()
 hook
Date: Mon, 2 Jul 2018 18:05:45 +0800
Message-ID: <20180702180545.7570b40b@xhacker.debian>
References: <20180702180428.331b36c5@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702180428.331b36c5@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
valid divisor latch fraction register. The fractional divisor width is
4bits ~ 6bits. Add get_divisor() and set_divisor() hook to prepare
supporting this feature in next commit.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/tty/serial/8250/8250_core.c | 4 ++++
 drivers/tty/serial/8250/8250_port.c | 8 ++++++++
 include/linux/serial_8250.h         | 7 +++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 9342fc2ee7df..da0f3849bfce 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1035,6 +1035,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 			uart->dl_read = up->dl_read;
 		if (up->dl_write)
 			uart->dl_write = up->dl_write;
+		if (up->get_divisor)
+			uart->get_divisor = up->get_divisor;
+		if (up->set_divisor)
+			uart->set_divisor = up->set_divisor;
 
 		if (uart->port.type != PORT_8250_CIR) {
 			if (serial8250_isa_config != NULL)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index cf541aab2bd0..0060ec54a522 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2505,6 +2505,9 @@ static unsigned int serial8250_get_divisor(struct uart_8250_port *up,
 	struct uart_port *port = &up->port;
 	unsigned int quot;
 
+	if (up->get_divisor)
+		return up->get_divisor(up, baud, frac);
+
 	/*
 	 * Handle magic divisors for baud rates above baud_base on
 	 * SMSC SuperIO chips.
@@ -2575,6 +2578,11 @@ static void serial8250_set_divisor(struct uart_port *port, unsigned int baud,
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
+	if (up->set_divisor) {
+		up->set_divisor(up, baud, quot, quot_frac);
+		return;
+	}
+
 	/* Workaround to enable 115200 baud on OMAP1510 internal ports */
 	if (is_omap1510_8250(up)) {
 		if (baud == 115200) {
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 76b9db71e489..5093c9ca0980 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -132,6 +132,13 @@ struct uart_8250_port {
 	/* 8250 specific callbacks */
 	int			(*dl_read)(struct uart_8250_port *);
 	void			(*dl_write)(struct uart_8250_port *, int);
+	unsigned int		(*get_divisor)(struct uart_8250_port *up,
+					       unsigned int baud,
+					       unsigned int *frac);
+	void			(*set_divisor)(struct uart_8250_port *up,
+					       unsigned int baud,
+					       unsigned int quot,
+					       unsigned int quot_frac);
 
 	struct uart_8250_em485 *em485;
 };
-- 
2.18.0
