From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH] serial: samsung: fix the inconsistency in spinlock
Date: Thu, 18 Feb 2016 23:10:02 +0530
Message-ID: <1455817202-3005-1-git-send-email-linux.amoon@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Anand Moon <linux.amoon@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Anand Moon <linux.amoon@gmail.com>

changes fix the correct order of the spin_lock_irqrestore/save.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/tty/serial/samsung.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index d72cd73..96fe14d 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -759,9 +759,9 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
-		spin_unlock(&port->lock);
+		spin_unlock_irqrestore(&port->lock, flags);
 		uart_write_wakeup(port);
-		spin_lock(&port->lock);
+		spin_lock_irqsave(&port->lock, flags);
 	}
 
 	if (uart_circ_empty(xmit))
-- 
1.9.1
