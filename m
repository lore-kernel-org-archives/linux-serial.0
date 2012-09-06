From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v4 11/21] serial: omap: don't save IRQ flags on hardirq
Date: Thu,  6 Sep 2012 15:45:30 +0300
Message-ID: <1346935540-1792-12-git-send-email-balbi@ti.com>
References: <20120906122948.GC29202@arwen.pp.htv.fi>
 <1346935540-1792-1-git-send-email-balbi@ti.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:44681 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755485Ab2IFMun (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Sep 2012 08:50:43 -0400
Received: by lagy9 with SMTP id y9so1063326lag.19
        for <linux-serial@vger.kernel.org>; Thu, 06 Sep 2012 05:50:40 -0700 (PDT)
In-Reply-To: <1346935540-1792-1-git-send-email-balbi@ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alan@linux.intel.com, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Felipe Balbi <balbi@ti.com>

When we're running our hardirq handler, there's
not need to disable IRQs with spin_lock_irqsave()
because IRQs are already disabled. It also makes
no difference if we save or not IRQ flags.

Switch over to simple spin_lock/spin_unlock and
drop the "flags" variable.

Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 0ceca44..99042b0 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -351,11 +351,10 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 	struct tty_struct *tty = up->port.state->port.tty;
 	unsigned int iir, lsr;
 	unsigned int type;
-	unsigned long flags;
 	irqreturn_t ret = IRQ_NONE;
 	int max_count = 256;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	spin_lock(&up->port.lock);
 	pm_runtime_get_sync(up->dev);
 
 	do {
@@ -394,7 +393,7 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 		}
 	} while (!(iir & UART_IIR_NO_INT) && max_count--);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	spin_unlock(&up->port.lock);
 
 	tty_flip_buffer_push(tty);
 
-- 
1.7.12.rc3

