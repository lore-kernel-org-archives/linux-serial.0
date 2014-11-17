From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 3/5] usb: gadget: pxa25x_udc: prepare/unprepare clocks in pxa-ssp
Date: Mon, 17 Nov 2014 18:07:41 +0300
Message-ID: <1416236863-20898-3-git-send-email-dbaryshkov@gmail.com>
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416236863-20898-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Change clk_enable/disable() calls to clk_prepare_enable() and
clk_disable_unprepare().

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/usb/gadget/udc/pxa25x_udc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index 42f7eeb..e4964ee 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -103,8 +103,8 @@ static const char ep0name [] = "ep0";
 
 /* IXP doesn't yet support <linux/clk.h> */
 #define clk_get(dev,name)	NULL
-#define clk_enable(clk)		do { } while (0)
-#define clk_disable(clk)	do { } while (0)
+#define clk_prepare_enable(clk)	do { } while (0)
+#define clk_disable_unprepare(clk)	do { } while (0)
 #define clk_put(clk)		do { } while (0)
 
 #endif
@@ -932,7 +932,7 @@ static int pullup(struct pxa25x_udc *udc)
 		if (!udc->active) {
 			udc->active = 1;
 			/* Enable clock for USB device */
-			clk_enable(udc->clk);
+			clk_prepare_enable(udc->clk);
 			udc_enable(udc);
 		}
 	} else {
@@ -945,7 +945,7 @@ static int pullup(struct pxa25x_udc *udc)
 			}
 			udc_disable(udc);
 			/* Disable clock for USB device */
-			clk_disable(udc->clk);
+			clk_disable_unprepare(udc->clk);
 			udc->active = 0;
 		}
 
-- 
2.1.1
