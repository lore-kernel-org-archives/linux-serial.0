From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3] serial: 8250_dw: fix wrong logic in dw8250_check_lcr()
Date: Tue, 5 Apr 2016 11:32:46 +0800
Message-ID: <1459827166-13861-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com, xuwei5@hisilicon.com, Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

Commit cdcea058e510 ("serial: 8250_dw: Avoid serial_outx code duplicate
with new dw8250_check_lcr()") introduce a wrong logic when write val to
LCR reg. When CONFIG_64BIT enabled, __raw_writeq is used unconditionally.

The __raw_readq/__raw_writeq is introduced by commit bca2092d7897 ("serial:
8250_dw: Use 64-bit access for OCTEON.") for OCTEON, so for !PORT_OCTEON,
we better to use coincident write func.

Fixes: cdcea058e510("serial: 8250_dw: Avoid serial_outx code duplicate with new dw8250_check_lcr()")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
Keep #ifdef CONFIG_64BIT to ensure it built under arch lacking readq/writeq.

 drivers/tty/serial/8250/8250_dw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a3fb95d..47d1f3e 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -104,15 +104,16 @@ static void dw8250_check_lcr(struct uart_port *p, int value)
 		dw8250_force_idle(p);
 
 #ifdef CONFIG_64BIT
-		__raw_writeq(value & 0xff, offset);
-#else
+		if (p->type == PORT_OCTEON)
+			__raw_writeq(value & 0xff, offset);
+		else
+#endif
 		if (p->iotype == UPIO_MEM32)
 			writel(value, offset);
 		else if (p->iotype == UPIO_MEM32BE)
 			iowrite32be(value, offset);
 		else
 			writeb(value, offset);
-#endif
 	}
 	/*
 	 * FIXME: this deadlocks if port->lock is already held
-- 
2.6.0.GIT
