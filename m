From: Arnd Bergmann <arnd@arndb.de>
Subject: [BACKPORT 4.4.y 23/25] serial: sprd: clear timeout interrupt only rather than all interrupts
Date: Fri, 22 Mar 2019 16:44:14 +0100
Message-ID: <20190322154425.3852517-24-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Lanqing Liu <lanqing.liu@spreadtrum.com>, Chunyan Zhang <chunyan.zhang@spreadtrum.com>, Arnd Bergmann <arnd@arndb.de>, Lanqing Liu <lanqing.liu@unisoc.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 4350782570b919f254c1e083261a21c19fcaee90)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/sprd_serial.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 176f0a2bf9d9..c894eca57e73 100644
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
2.20.0
