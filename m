From: David Singleton <davsingl@cisco.com>
Subject: [PATCH] tty: serial: 8250: 8250_core: NXP SC16C2552 workaround
Date: Mon, 17 Oct 2016 09:51:05 -0700
Message-ID: <20161017165108.29718-2-davsingl@cisco.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Steve Shih <sshih@cisco.com>, xe-kernel@external.cisco.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Steve Shih <sshih@cisco.com>

NXP SC16C2552 requires that we always write a reset to the RX FIFO and
TX FIFO whenever we enable the FIFOs

Cc: xe-kernel@external.cisco.com
Signed-off-by: Steve Shih <sshih@cisco.com>
Signed-off-by: David Singleton <davsingl@cisco.com>
---
 drivers/tty/serial/8250/8250_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1bfb6fd..1731b98 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -83,7 +83,8 @@ static const struct serial8250_config uart_config[] = {
 		.name		= "16550A",
 		.fifo_size	= 16,
 		.tx_loadsz	= 16,
-		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
+				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
 		.rxtrig_bytes	= {1, 4, 8, 14},
 		.flags		= UART_CAP_FIFO,
 	},
-- 
2.9.3
