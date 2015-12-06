From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX v4 07/13] tty: xuartps: Keep lock for whole ISR
Date: Sat, 5 Dec 2015 20:39:23 -0800
Message-ID: <1449376769-13369-8-git-send-email-soren.brinkmann@xilinx.com>
References: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Moritz Fischer <moritz.fischer@ettus.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

The RX path in the interrupt handler released a lock unnecessarily.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/xilinx_uartps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 1e9053656610..62224a58056b 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -265,9 +265,7 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 			uart_insert_char(port, isrstatus, CDNS_UART_IXR_OVERRUN,
 					data, status);
 		}
-		spin_unlock(&port->lock);
 		tty_flip_buffer_push(&port->state->port);
-		spin_lock(&port->lock);
 	}
 
 	/* Dispatch an appropriate handler */
-- 
2.6.3.3.g9bb996a
