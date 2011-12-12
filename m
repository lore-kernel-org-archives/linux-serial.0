From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 2/2 v2] serial: bfin-uart: Remove ASYNC_CTS_FLOW flag for hardware automatic CTS.
Date: Mon, 12 Dec 2011 14:59:51 +0800
Message-ID: <1323673191-9210-2-git-send-email-sonic.adi@gmail.com>
References: <1323673191-9210-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323673191-9210-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>
List-Id: linux-serial@vger.kernel.org

From: Sonic Zhang <sonic.zhang@analog.com>

Blackfin uart supports automatic CTS trigger when hardware flow control is enabled.
No need to start and top tx in CTS interrupt. So, remote ASYNC_CTS_FLOW flag.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/tty/serial/bfin_uart.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index a6c1c08..6bb3698 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -116,11 +116,20 @@ static void bfin_serial_set_mctrl(struct uart_port *port, unsigned int mctrl)
 static irqreturn_t bfin_serial_mctrl_cts_int(int irq, void *dev_id)
 {
 	struct bfin_serial_port *uart = dev_id;
-	unsigned int status;
-
-	status = bfin_serial_get_mctrl(&uart->port);
+	unsigned int status = bfin_serial_get_mctrl(&uart->port);
 #ifdef CONFIG_SERIAL_BFIN_HARD_CTSRTS
+	struct tty_struct *tty = uart->port.state->port.tty;
+
 	UART_CLEAR_SCTS(uart);
+	if (tty->hw_stopped) {
+		if (status) {
+			tty->hw_stopped = 0;
+			uart_write_wakeup(&uart->port);
+		}
+	} else {
+		if (!status)
+			tty->hw_stopped = 1;
+	}
 #endif
 	uart_handle_cts_change(&uart->port, status & TIOCM_CTS);
 
@@ -1358,7 +1367,9 @@ static int bfin_serial_probe(struct platform_device *pdev)
 			uart->cts_pin = -1;
 		else {
 			uart->cts_pin = res->start;
+#ifdef CONFIG_SERIAL_BFIN_CTSRTS
 			uart->port.flags |= ASYNC_CTS_FLOW;
+#endif
 		}
 
 		res = platform_get_resource(pdev, IORESOURCE_IO, 1);
-- 
1.7.0.4
