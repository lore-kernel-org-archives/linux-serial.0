From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] tty: serial: men_z135_uart.c: Fix race between IRQ and set_termios()
Date: Mon,  3 Aug 2015 15:58:05 +0200
Message-ID: <1438610285-1441-1-git-send-email-jthumshirn@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>, Andreas Werner <andreas.werner@men.de>
List-Id: linux-serial@vger.kernel.org

Fix panic caused by a race between men_z135_intr() and men_z135_set_termios().

men_z135_intr() and men_z135_set_termios() both hold the struct uart_port::lock
spinlock, but men_z135_intr() does a spin_lock_irqsave() and
men_z135_set_termios() does a normal spin_lock(), which can lead to a deadlock
when an interrupt is called while the lock is being helt by
men_z135_set_termios().

This was discovered using a insmod, hardware looppback send/receive, rmmod
stress test.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Andreas Werner <andreas.werner@men.de>
---
 drivers/tty/serial/men_z135_uart.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index 35c5550..d020435 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -656,6 +656,7 @@ static void men_z135_set_termios(struct uart_port *port,
 				struct ktermios *old)
 {
 	struct men_z135_port *uart = to_men_z135(port);
+	unsigned long flags;
 	unsigned int baud;
 	u32 conf_reg;
 	u32 bd_reg;
@@ -717,7 +718,7 @@ static void men_z135_set_termios(struct uart_port *port,
 
 	baud = uart_get_baud_rate(port, termios, old, 0, uart_freq / 16);
 
-	spin_lock(&port->lock);
+	spin_lock_irqsave(&port->lock, flags);
 	if (tty_termios_baud_rate(termios))
 		tty_termios_encode_baud_rate(termios, baud, baud);
 
@@ -725,7 +726,7 @@ static void men_z135_set_termios(struct uart_port *port,
 	iowrite32(bd_reg, port->membase + MEN_Z135_BAUD_REG);
 
 	uart_update_timeout(port, termios->c_cflag, baud);
-	spin_unlock(&port->lock);
+	spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static const char *men_z135_type(struct uart_port *port)
-- 
2.4.3
