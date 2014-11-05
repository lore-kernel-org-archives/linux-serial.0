From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 4/5] serial: Take uart port lock for direct *_enable_ms()
Date: Wed,  5 Nov 2014 13:11:44 -0500
Message-ID: <1415211105-16668-5-git-send-email-peter@hurleysoftware.com>
References: <1415211105-16668-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415211105-16668-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Three UART drivers (8250, atmel & amba-pl010) directly call their
enable_ms() method; the uart port lock must be acquired before
any h/w programming.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/8250/8250_core.c | 2 ++
 drivers/tty/serial/amba-pl010.c     | 2 ++
 drivers/tty/serial/atmel_serial.c   | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 6cfdb7b..8eb0654 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -2607,7 +2607,9 @@ serial8250_set_ldisc(struct uart_port *port, struct ktermios *termios)
 {
 	if (termios->c_line == N_PPS) {
 		port->flags |= UPF_HARDPPS_CD;
+		spin_lock_irq(&port->lock);
 		serial8250_enable_ms(port);
+		spin_unlock_irq(&port->lock);
 	} else
 		port->flags &= ~UPF_HARDPPS_CD;
 }
diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 76e40b3..04b83bf 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -472,7 +472,9 @@ static void pl010_set_ldisc(struct uart_port *port, struct ktermios *termios)
 {
 	if (termios->c_line == N_PPS) {
 		port->flags |= UPF_HARDPPS_CD;
+		spin_lock_irq(&port->lock);
 		pl010_enable_ms(port);
+		spin_unlock_irq(&port->lock);
 	} else
 		port->flags &= ~UPF_HARDPPS_CD;
 }
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index a2374d9..b68dfa5 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2046,7 +2046,9 @@ static void atmel_set_ldisc(struct uart_port *port, struct ktermios *termios)
 {
 	if (termios->c_line == N_PPS) {
 		port->flags |= UPF_HARDPPS_CD;
+		spin_lock_irq(&port->lock);
 		atmel_enable_ms(port);
+		spin_unlock_irq(&port->lock);
 	} else {
 		port->flags &= ~UPF_HARDPPS_CD;
 	}
-- 
2.1.3
