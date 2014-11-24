From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 4/4] serial: samsung: use port->fifosize instead of hardcoded
 values
Date: Mon, 24 Nov 2014 07:56:24 +0100
Message-ID: <1416812184-4496-5-git-send-email-r.baldyga@samsung.com>
References: <1416812184-4496-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1416812184-4496-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

Hardcoded FIFO size can cause hardware performance limitation.
Using real size value provides better FIFO usage.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/tty/serial/samsung.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 8808490..c622cf1 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -239,7 +239,7 @@ s3c24xx_serial_rx_chars(int irq, void *dev_id)
 	struct uart_port *port = &ourport->port;
 	unsigned int ufcon, ch, flag, ufstat, uerstat;
 	unsigned long flags;
-	int max_count = 64;
+	int max_count = port->fifosize;
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -330,7 +330,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 	struct uart_port *port = &ourport->port;
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned long flags;
-	int count = 256;
+	int count = port->fifosize;
 
 	spin_lock_irqsave(&port->lock, flags);
 
-- 
1.9.1
