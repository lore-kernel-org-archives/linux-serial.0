From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 3/6] serial: uartps: Fix multiple line dereference
Date: Wed, 12 Jun 2019 13:14:40 +0200
Message-ID: <3a5b27987c5b4fc5ec7dc7f58485db63057edbfe.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1560338079.git.michal.simek@xilinx.com>
References: <cover.1560338079.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: johan@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com
Cc: Nava kishore Manne <nava.manne@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

Trivial patch which fixes this checkpatch warning:
WARNING: Avoid multiple line dereference - prefer 'port->state->xmit.tail'
+				port->state->xmit.buf[port->state->xmit.
+				tail], port->membase + CDNS_UART_FIFO);

Fixes: c8dbdc842d30 ("serial: xuartps: Rewrite the interrupt handling logic")
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Split patch from v1
- Add Fixes tag

 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index c84db82bdaab..4cd20c036750 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -319,8 +319,8 @@ static void cdns_uart_handle_tx(void *dev_id)
 			 * register.
 			 */
 			writel(
-				port->state->xmit.buf[port->state->xmit.
-				tail], port->membase + CDNS_UART_FIFO);
+				port->state->xmit.buf[port->state->xmit.tail],
+					port->membase + CDNS_UART_FIFO);
 
 			port->icount.tx++;
 
-- 
2.17.1
