From: Jakub Kicinski <moorray3-5tc4TXWwyLM@public.gmane.org>
Subject: [PATCH 4/4] sc16is7xx: enable the clock
Date: Tue, 17 Mar 2015 00:28:49 +0100
Message-ID: <1426548529-21738-5-git-send-email-moorray3@wp.pl>
References: <1426548529-21738-1-git-send-email-moorray3@wp.pl>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426548529-21738-1-git-send-email-moorray3-5tc4TXWwyLM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Karol=20D=C4=99bog=C3=B3rski?= <k.debogorski-XA5MxPtj9CQ@public.gmane.org>, Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>

Although clk_disable_unprepare() is called both on .remove()
and in .probe() error path, the clock is never actually enabled.

Signed-off-by: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
---
 drivers/tty/serial/sc16is7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 24902d589b07..20573d72715d 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1064,6 +1064,7 @@ static int sc16is7xx_probe(struct device *dev,
 		else
 			return PTR_ERR(s->clk);
 	} else {
+		clk_prepare_enable(s->clk);
 		freq = clk_get_rate(s->clk);
 	}
 
-- 
2.1.0
