From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 resend] serial: 8250_dw: fix wrong logic in dw8250_check_lcr()
Date: Tue, 5 Apr 2016 10:55:15 +0800
Message-ID: <1459824915-10550-1-git-send-email-wangkefeng.wang@huawei.com>
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
 drivers/tty/serial/8250/8250_dw.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a3fb95d..003ce60 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -103,16 +103,14 @@ static void dw8250_check_lcr(struct uart_port *p, int value)
 
 		dw8250_force_idle(p);
 
-#ifdef CONFIG_64BIT
-		__raw_writeq(value & 0xff, offset);
-#else
-		if (p->iotype == UPIO_MEM32)
+		if (IS_ENABLED(CONFIG_64BIT) && p->type == PORT_OCTEON)
+			__raw_writeq(value & 0xff, offset);
+		else if (p->iotype == UPIO_MEM32)
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
