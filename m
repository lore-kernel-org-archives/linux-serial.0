From: Jakub Kicinski <moorray3-5tc4TXWwyLM@public.gmane.org>
Subject: [PATCH 1/4] sc16is7xx: remove ports on probe error path
Date: Tue, 17 Mar 2015 00:28:46 +0100
Message-ID: <1426548529-21738-2-git-send-email-moorray3@wp.pl>
References: <1426548529-21738-1-git-send-email-moorray3@wp.pl>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426548529-21738-1-git-send-email-moorray3-5tc4TXWwyLM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Karol=20D=C4=99bog=C3=B3rski?= <k.debogorski-XA5MxPtj9CQ@public.gmane.org>, Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

From: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>

If ports are not explicitly removed on the error path
the device will not get properly unregistered leaving
/dev/ttySC* nodes in the filesystem.

Signed-off-by: Jakub Kicinski <kubakici-5tc4TXWwyLM@public.gmane.org>
---
 drivers/tty/serial/sc16is7xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index df9a384dfbda..11bb44039a57 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1120,6 +1120,9 @@ static int sc16is7xx_probe(struct device *dev,
 	if (!ret)
 		return 0;
 
+	for (i = 0; i < s->uart.nr; i++)
+		uart_remove_one_port(&s->uart, &s->p[i].port);
+
 	mutex_destroy(&s->mutex);
 
 #ifdef CONFIG_GPIOLIB
-- 
2.1.0
