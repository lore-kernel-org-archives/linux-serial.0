From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 4/6] serial: uartps: Fix long line over 80 chars
Date: Wed, 12 Jun 2019 13:14:41 +0200
Message-ID: <a7eb75d2900d354b3b2ba4355f4c9b9cb00f1456.1560338079.git.michal.simek@xilinx.com>
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

Trivial patch which fixes one checkpatch warning:
WARNING: line over 80 characters
+		       !(readl(port->membase + CDNS_UART_SR)
			& CDNS_UART_SR_TXFULL)) {

Fixes: c8dbdc842d30 ("serial: xuartps: Rewrite the interrupt handling logic")
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Split patch from v1
- Add Fixes tag

 drivers/tty/serial/xilinx_uartps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 4cd20c036750..c3949a323815 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -312,7 +312,8 @@ static void cdns_uart_handle_tx(void *dev_id)
 	} else {
 		numbytes = port->fifosize;
 		while (numbytes && !uart_circ_empty(&port->state->xmit) &&
-		       !(readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)) {
+		       !(readl(port->membase + CDNS_UART_SR) &
+						CDNS_UART_SR_TXFULL)) {
 			/*
 			 * Get the data from the UART circular buffer
 			 * and write it to the cdns_uart's TX_FIFO
-- 
2.17.1
