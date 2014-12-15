From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 3/5] watchdog: at91sam9: request the irq with IRQF_NO_SUSPEND
Date: Mon, 15 Dec 2014 17:15:50 +0100
Message-ID: <1418660152-17185-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1418660152-17185-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418660152-17185-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Mike Turquette <mturquette@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

The watchdog interrupt (only used when activating software watchdog)
shouldn't be suspended when entering suspend mode, because it is shared
with a timer device (which request the line with IRQF_NO_SUSPEND) and once
the watchdog "Mode Register" has been written, it cannot be changed (which
means we cannot disable the watchdog interrupt when entering suspend).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/watchdog/at91sam9_wdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 6df9405..1443b3c 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -208,7 +208,8 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
 
 	if ((tmp & AT91_WDT_WDFIEN) && wdt->irq) {
 		err = request_irq(wdt->irq, wdt_interrupt,
-				  IRQF_SHARED | IRQF_IRQPOLL,
+				  IRQF_SHARED | IRQF_IRQPOLL |
+				  IRQF_NO_SUSPEND,
 				  pdev->name, wdt);
 		if (err)
 			return err;
-- 
1.9.1
