From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 3/4] serial: fsl_lpuart: avoid new transfer while DMA is running
Date: Fri, 28 Nov 2014 01:23:24 +0100
Message-ID: <1417134205-4400-4-git-send-email-stefan@agner.ch>
References: <1417134205-4400-1-git-send-email-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417134205-4400-1-git-send-email-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, jingchang.lu@freescale.com, shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stefan@agner.ch
List-Id: linux-serial@vger.kernel.org

When the UART is DMA receive mode (RDMAS set) and a character just
arrived, while another interrupt is handled, the RDRF (receiver data
register full flag) is set. But since the DMA will take care of it
there is no need to handle it by calling lpuart_prepare_rx. Handling
it leads in adding the RX timeout timer twice:

[   43.528029] Kernel BUG at 8004ee7c [verbose debug info unavailable]
[   43.534329] Internal error: Oops - BUG: 0 [#1] ARM
[   43.539145] Modules linked in:
[   43.542242] CPU: 0 PID: 0 Comm: swapper Not tainted 3.18.0-rc5-00014-ge956e1a-dirty #1293
[   43.550448] task: 80795630 ti: 8078a000 task.ti: 8078a000
[   43.555886] PC is at add_timer+0x24/0x28
[   43.559833] LR is at lpuart_int+0x188/0x3b0
[   43.564039] pc : [<8004ee7c>]    lr : [<802cbd3c>]    psr: a0000193
[   43.564039] sp : 8078be18  ip : 8078be28  fp : 8078be24
[   43.575560] r10: 8e80b840  r9 : 807d23ff  r8 : 20000193
[   43.580812] r7 : 00000020  r6 : 00000001  r5 : 000000a0  r4 : 8e994e10
[   43.587368] r3 : ffff9bd1  r2 : 80815360  r1 : 8e994e10  r0 : 8e994f20
[   43.593923] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[   43.601352] Control: 10c5387d  Table: 8c424059  DAC: 00000015
[   43.607125] Process swapper (pid: 0, stack limit = 0x8078a238)
...

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/tty/serial/fsl_lpuart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 629291d..be9ccdf 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -756,18 +756,18 @@ out:
 static irqreturn_t lpuart_int(int irq, void *dev_id)
 {
 	struct lpuart_port *sport = dev_id;
-	unsigned char sts;
+	unsigned char sts, crdma;
 
 	sts = readb(sport->port.membase + UARTSR1);
+	crdma = readb(sport->port.membase + UARTCR5);
 
-	if (sts & UARTSR1_RDRF) {
+	if (sts & UARTSR1_RDRF && !(crdma & UARTCR5_RDMAS)) {
 		if (sport->lpuart_dma_rx_use)
 			lpuart_prepare_rx(sport);
 		else
 			lpuart_rxint(irq, dev_id);
 	}
-	if (sts & UARTSR1_TDRE &&
-		!(readb(sport->port.membase + UARTCR5) & UARTCR5_TDMAS)) {
+	if (sts & UARTSR1_TDRE && !(crdma & UARTCR5_TDMAS)) {
 		if (sport->lpuart_dma_tx_use)
 			lpuart_pio_tx(sport);
 		else
-- 
2.1.3
