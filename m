From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] serial: 8250_dw: fix wrong logic in dw8250_check_lcr()
Date: Fri, 1 Apr 2016 17:06:58 +0800
Message-ID: <1459501618-21021-1-git-send-email-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com, xuwei5@hisilicon.com, Kefeng Wang <wangkefeng.wang@huawei.com>
List-Id: linux-serial@vger.kernel.org

Commit cdcea058e510("serial: 8250_dw: Avoid serial_outx code duplicate
with new dw8250_check_lcr()") introduce a wrong logic when write val to
LCR reg. When CONFIG_64BIT enabled, __raw_writeq is used unconditionally.

But for !PORT_OCTEON, we better to use coincident write func.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---

We met following calltrace twice, if the change is not necessary, correct me,
and any advice will be appreciated, thanks.

80300000.uart: ttyS0 at MMIO 0x80300000 (irq = 7, base_baud = 12500000) is a 16550A
Unable to handle kernel paging request at virtual address ffffff8008e8000c
pgd = ffffff8008c14000
[ffffff8008e8000c] *pgd=00000013ffffe003,*pud=00000013ffffe003, *pmd=00000013ee043003, *pte=00e8000080300707
Internal error: Oops: 96000061 [#1] PREEMPT SMP
Modules linked in:
CPU: 13 PID: 1 Comm: swapper/0 Not tainted 4.6.0-rc1+ #51
Hardware name: Huawei Technologies Co., Ltd. D02/D02, BIOS Bios Version 01/01/1900
task: ffffffd3ee358000 ti: ffffffd3ee360000 task.ti:ffffffd3ee360000
PC is at dw8250_check_lcr+0x54/0x98
LR is at dw8250_check_lcr+0x54/0x98
pc : [<ffffff800842f2c4>] lr : [<ffffff800842f2c4>]pstate: 800000c5
sp : ffffffd3ee363740
x29: ffffffd3ee363740 x28: 0000000000000000
x27: ffffff800897d668 x26: ffffffd3ed434100
x25: ffffff80089e89b0 x24: 000000000000006d
x23: 0000000000000093 x22: 0000000000000093
x21: ffffff8008e8000c x20: 00000000000003e8
x19: ffffff8008bfde28 x18: 0000000000000006
x17: 0000000000000000 x16: 0000000000000001
x15: 000000000001c200 x14: 0000000000000011
x13: 0000000000000c80 x12: 0000000000000011
x11: ffffff800881c050 x10: 000000000001cb00
x9 : 000000000001cb00 x8 : ffffff800881c050
x7 : 000000000001b900 x6 : 0000000000000020
x5 : ffffffd3ec8d9a18 x4 : ffffff8008e80000
x3 : ffffff8008bfde28 x2 : 000000000000000d
x1 : 0000000000000000 x0 : 000000000000000d

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
1.7.12.4
