From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 5/7] serial: clps711x: fix IS_ERR_VALUE usage
Date: Mon, 15 Feb 2016 15:35:23 +0100
Message-ID: <1455546925-22119-6-git-send-email-a.hajda@samsung.com>
References: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

IS_ERR_VALUE macro should be used only with unsigned long type.
For signed types comparison 'ret < 0' should be used.

The patch follows conclusion from discussion on LKML [1][2].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2120927
[2]: http://permalink.gmane.org/gmane.linux.kernel/2150581

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/tty/serial/clps711x.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index b3a4e0c..0096ebe 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -467,13 +467,15 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 	if (IS_ERR(s->port.membase))
 		return PTR_ERR(s->port.membase);
 
-	s->port.irq = platform_get_irq(pdev, 0);
-	if (IS_ERR_VALUE(s->port.irq))
-		return s->port.irq;
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+	s->port.irq = ret;
 
-	s->rx_irq = platform_get_irq(pdev, 1);
-	if (IS_ERR_VALUE(s->rx_irq))
-		return s->rx_irq;
+	ret = platform_get_irq(pdev, 1);
+	if (ret < 0)
+		return ret;
+	s->rx_irq = ret;
 
 	if (!np) {
 		char syscon_name[9];
-- 
1.9.1
