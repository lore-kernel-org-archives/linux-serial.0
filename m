From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 06/38] tty: serial: lpc32xx_hs: fix handling platform_get_irq
 result
Date: Mon, 21 Sep 2015 15:33:38 +0200
Message-ID: <1442842450-29769-7-git-send-email-a.hajda@samsung.com>
References: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The function can return negative values.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2038576

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/tty/serial/lpc32xx_hs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index e92d7eb..7eb04ae 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -691,12 +691,13 @@ static int serial_hs_lpc32xx_probe(struct platform_device *pdev)
 	p->port.mapbase = res->start;
 	p->port.membase = NULL;
 
-	p->port.irq = platform_get_irq(pdev, 0);
-	if (p->port.irq < 0) {
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
 		dev_err(&pdev->dev, "Error getting irq for HS UART port %d\n",
 			uarts_registered);
-		return p->port.irq;
+		return ret;
 	}
+	p->port.irq = ret;
 
 	p->port.iotype = UPIO_MEM32;
 	p->port.uartclk = LPC32XX_MAIN_OSC_FREQ;
-- 
1.9.1
