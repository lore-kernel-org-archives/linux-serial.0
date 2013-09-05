From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 1/3] serial: 8250: don't change the fifo trigger level when using dma
Date: Thu,  5 Sep 2013 17:34:52 +0300
Message-ID: <1378391694-28725-2-git-send-email-heikki.krogerus@linux.intel.com>
References: <1378391694-28725-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59118 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227Ab3IEOe5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 5 Sep 2013 10:34:57 -0400
In-Reply-To: <1378391694-28725-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

DMA engines usually expect the fifo trigger level to be
aligned with the burst size. It should not be changed even
with small baud rates. This will fix an issue with
Designware DMA engine where the data can not be transferred
over UART with lower baud rates then 2400.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 570df9d..e33d38c 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2322,7 +2322,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	if (up->capabilities & UART_CAP_FIFO && port->fifosize > 1) {
 		fcr = uart_config[port->type].fcr;
-		if (baud < 2400 || fifo_bug) {
+		if ((baud < 2400 && !up->dma) || fifo_bug) {
 			fcr &= ~UART_FCR_TRIGGER_MASK;
 			fcr |= UART_FCR_TRIGGER_1;
 		}
-- 
1.8.4.rc3

