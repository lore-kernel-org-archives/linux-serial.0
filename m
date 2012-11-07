From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Subject: [PATCH 02/10] Revert "sh-sci / PM: Use power.irq_safe"
Date: Wed, 07 Nov 2012 15:58:27 +0900
Message-ID: <509A0693.9030701@renesas.com>
References: <509A0658.1010503@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-reply-to: <509A0658.1010503@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: lethal@linux-sh.org, magnus.damm@gmail.com, rjw@sisk.pl, alan@linux.intel.com, gregkh@linuxfoundation.org
Cc: takashi.yoshii.zj@renesas.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This reverts commit 5a50a01bf0 (sh-sci / PM: Use power.irq_safe, from
Rafael J. Wysocki <rjw@sisk.pl>, 2011-08-24).

In order to get console PM work properly, we should implement uart_ops
->pm() operation, rather than sprinkle band-ading runtime PM calls in
the driver.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 526ad04..9abe977 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2116,7 +2116,6 @@ static int __devinit sci_init_single(struct platform_device *dev,
 
 		sci_init_gpios(sci_port);
 
-		pm_runtime_irq_safe(&dev->dev);
 		pm_runtime_enable(&dev->dev);
 	}
 
-- 
1.7.12.4

