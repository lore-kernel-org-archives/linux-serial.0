From: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Subject: [PATCH] serial: sprd: clear timeout interrupt only rather than all interrupts
Date: Tue, 18 Jul 2017 17:58:13 +0800
Message-ID: <20170718095813.32116-1-chunyan.zhang@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Lanqing Liu <lanqing.liu@spreadtrum.com>, Chunyan Zhang <chunyan.zhang@spreadtrum.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Orson Zhai <orson.zhai@spreadtrum.com>
List-Id: linux-serial@vger.kernel.org

From: Lanqing Liu <lanqing.liu@spreadtrum.com>

On Spreadtrum's serial device, nearly all of interrupts would be cleared
by hardware except timeout interrupt.  This patch removed the operation
of clearing all interrupt in irq handler, instead added an if statement
to check if the timeout interrupt is supposed to be cleared.

Wrongly clearing timeout interrupt would lead to uart data stay in rx
fifo, that means the driver cannot read them out anymore.

Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/tty/serial/sprd_serial.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 90996ad..f758fe6 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -63,6 +63,7 @@
 
 /* interrupt clear register */
 #define SPRD_ICLR		0x0014
+#define SPRD_ICLR_TIMEOUT	BIT(13)
 
 /* line control register */
 #define SPRD_LCR		0x0018
@@ -298,7 +299,8 @@ static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	serial_out(port, SPRD_ICLR, ~0);
+	if (ims & SPRD_IMSR_TIMEOUT)
+		serial_out(port, SPRD_ICLR, SPRD_ICLR_TIMEOUT);
 
 	if (ims & (SPRD_IMSR_RX_FIFO_FULL |
 		SPRD_IMSR_BREAK_DETECT | SPRD_IMSR_TIMEOUT))
-- 
2.7.4
