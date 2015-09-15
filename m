From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH v3 2/4] serial: samsung: remove unneded 'ignore_char' label
Date: Tue, 15 Sep 2015 14:48:58 +0200
Message-ID: <1442321340-28167-3-git-send-email-r.baldyga@samsung.com>
References: <1442321340-28167-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1442321340-28167-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, k.kozlowski@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

This label does nothing special and we don't need to have it anymore.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/tty/serial/samsung.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index fee764c..dc4be54 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -676,7 +676,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
 				dbg("break!\n");
 				port->icount.brk++;
 				if (uart_handle_break(port))
-					goto ignore_char;
+					continue; /* Ignore character */
 			}
 
 			if (uerstat & S3C2410_UERSTAT_FRAME)
@@ -696,13 +696,10 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
 		}
 
 		if (uart_handle_sysrq_char(port, ch))
-			goto ignore_char;
+			continue; /* Ignore character */
 
 		uart_insert_char(port, uerstat, S3C2410_UERSTAT_OVERRUN,
 				 ch, flag);
-
-ignore_char:
-		continue;
 	}
 
 	spin_unlock_irqrestore(&port->lock, flags);
-- 
1.9.1
