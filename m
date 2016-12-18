From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] serial: pic32_uart: Fix 'request_irq' and 'free_irq' inconsistancy
Date: Sun, 18 Dec 2016 07:38:11 +0100
Message-ID: <20161218063811.17307-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-serial@vger.kernel.org

'request_irq' and 'free_irq' should have the same 'dev_id'.
Here one uses 'port', and the other one uses 'sport'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/tty/serial/pic32_uart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 7f8e99bbcb73..00a33eb859d3 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -495,13 +495,13 @@ static int pic32_uart_startup(struct uart_port *port)
 
 out_t:
 	kfree(sport->irq_tx_name);
-	free_irq(sport->irq_tx, sport);
+	free_irq(sport->irq_tx, port);
 out_r:
 	kfree(sport->irq_rx_name);
-	free_irq(sport->irq_rx, sport);
+	free_irq(sport->irq_rx, port);
 out_f:
 	kfree(sport->irq_fault_name);
-	free_irq(sport->irq_fault, sport);
+	free_irq(sport->irq_fault, port);
 out_done:
 	return ret;
 }
-- 
2.9.3
