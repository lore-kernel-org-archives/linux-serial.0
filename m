From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 1/6] PM / wakeup: export pm_system_wakeup symbol
Date: Mon,  2 Mar 2015 10:18:13 +0100
Message-ID: <1425287898-15093-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

Export pm_system_wakeup function to allow irq handlers to deal with system
wakeup.
This is needed for shared IRQ lines where one of the handler is registered
with IRQF_NO_SUSPEND, while the other ones want to configure it as a wakeup
source.
In this specific case, irq core does not handle the wakeup process and
leave the decision to each irq handler.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/base/power/wakeup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index c2744b3..aab7158 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -730,6 +730,7 @@ void pm_system_wakeup(void)
 	pm_abort_suspend = true;
 	freeze_wake();
 }
+EXPORT_SYMBOL_GPL(pm_system_wakeup);
 
 void pm_wakeup_clear(void)
 {
-- 
1.9.1

