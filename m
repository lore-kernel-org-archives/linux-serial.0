From: Manfred Schlaegl <manfred.schlaegl@gmx.at>
Subject: [PATCH] serial: imx: reduce irq-latency after rx overflow
Date: Sat, 20 Jun 2015 19:25:52 +0200
Message-ID: <5585A220.5000405@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
List-Id: linux-serial@vger.kernel.org

To prevent problems with interrupt latency, and due to the fact, that
the error will be counted anyway (icount.overrun), the dev_err is simply
removed.

Background:
If an rx-fifo overflow occurs a dev_err message was called in interrupt
context. Since dev_err messages are written to console in a synchronous way
(unbuffered), and console may be a serial terminal, this leads to a
highly increased interrupt-latency (several milliseconds).
As a result of the high latency more rx-fifo overflows will happen, and
therefore a feedback loop of errors is created.

Signed-off-by: Manfred Schlaegl <manfred.schlaegl@gmx.at>
---
 drivers/tty/serial/imx.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 384cf1d..40fd32c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -767,7 +767,6 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 		writel(USR1_AWAKE, sport->port.membase + USR1);
 
 	if (sts2 & USR2_ORE) {
-		dev_err(sport->port.dev, "Rx FIFO overrun\n");
 		sport->port.icount.overrun++;
 		writel(USR2_ORE, sport->port.membase + USR2);
 	}
-- 
1.7.10.4
