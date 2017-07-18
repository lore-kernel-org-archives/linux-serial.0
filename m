From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RFC PATCH 3/5] serial: xuartps: Remove __init marking from early write
Date: Tue, 18 Jul 2017 12:30:01 +0800
Message-ID: <1500352203-21513-4-git-send-email-jeffy.chen@rock-chips.com>
References: <1500352203-21513-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500352203-21513-1-git-send-email-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, briannorris@chromium.org, dianders@chromium.org, peter@hurleysoftware.com, Jeffy Chen <jeffy.chen@rock-chips.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The earlycon would be alive outside the init code in these cases:
1/ we have keep_bootcon in cmdline.
2/ we don't have a real console to switch to.

So remove the __init marking to avoid invalid memory access.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index fde55dc..31a630a 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1163,7 +1163,7 @@ static void cdns_uart_console_putchar(struct uart_port *port, int ch)
 	writel(ch, port->membase + CDNS_UART_FIFO);
 }
 
-static void __init cdns_early_write(struct console *con, const char *s,
+static void cdns_early_write(struct console *con, const char *s,
 				    unsigned n)
 {
 	struct earlycon_device *dev = con->data;
-- 
2.1.4
