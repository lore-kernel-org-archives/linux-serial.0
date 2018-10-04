From: Lance Roy <ldr709@gmail.com>
Subject: [PATCH] TTY: Replace spin_is_locked() with spin_trylock()
Date: Thu,  4 Oct 2018 00:14:04 -0700
Message-ID: <20181004071404.16407-1-ldr709@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>, Lance Roy <ldr709@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

sn_sal_console_write() used spin_is_locked() + spin_lock() to get
achieve the same thing as a spin_trylock(), so simplify it by using that
instead. This is also a step towards possibly removing spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: <linux-serial@vger.kernel.org>
---
 drivers/tty/serial/sn_console.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sn_console.c b/drivers/tty/serial/sn_console.c
index 42b9aded4eb1..fe9170731c16 100644
--- a/drivers/tty/serial/sn_console.c
+++ b/drivers/tty/serial/sn_console.c
@@ -888,7 +888,7 @@ sn_sal_console_write(struct console *co, const char *s, unsigned count)
 
 	/* somebody really wants this output, might be an
 	 * oops, kdb, panic, etc.  make sure they get it. */
-	if (spin_is_locked(&port->sc_port.lock)) {
+	if (!spin_trylock_irqsave(&port->sc_port.lock, flags)) {
 		int lhead = port->sc_port.state->xmit.head;
 		int ltail = port->sc_port.state->xmit.tail;
 		int counter, got_lock = 0;
@@ -905,13 +905,11 @@ sn_sal_console_write(struct console *co, const char *s, unsigned count)
 		 */
 
 		for (counter = 0; counter < 150; mdelay(125), counter++) {
-			if (!spin_is_locked(&port->sc_port.lock)
-			    || stole_lock) {
-				if (!stole_lock) {
-					spin_lock_irqsave(&port->sc_port.lock,
-							  flags);
-					got_lock = 1;
-				}
+			if (stole_lock)
+				break;
+
+			if (spin_trylock_irqsave(&port->sc_port.lock, flags)) {
+				got_lock = 1;
 				break;
 			} else {
 				/* still locked */
@@ -938,7 +936,6 @@ sn_sal_console_write(struct console *co, const char *s, unsigned count)
 		puts_raw_fixed(port->sc_ops->sal_puts_raw, s, count);
 	} else {
 		stole_lock = 0;
-		spin_lock_irqsave(&port->sc_port.lock, flags);
 		sn_transmit_chars(port, 1);
 		spin_unlock_irqrestore(&port->sc_port.lock, flags);
 
-- 
2.19.0
