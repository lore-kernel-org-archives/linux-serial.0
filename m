From: Colin King <colin.king@canonical.com>
Subject: [PATCH][serial-next] serial: 8250: don't dereference em485 until it has been null checked
Date: Tue, 29 Aug 2017 17:58:15 +0100
Message-ID: <20170829165815.23429-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Phil Elwell <phil@raspberrypi.org>, Jan Kiszka <jan.kiszka@siemens.com>, Eric Anholt <eric@anholt.net>, Thor Thayer <tthayer@opensource.altera.com>, Rafael Gago <rafael.gago@gmail.com>, David Lechner <david@lechnology.com>, linux-serial@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently, the pointer em485 is dereferenced to get p and then later
em485 is checked to see if it is null before calling __start_tx. In
the case where em485 is null, we get a null pointer dereference. Fix
this by moving the deference and the associated spinlock/unlocks on
p to the code block where em485 is known to be not null.

Detected by CoverityScan, CID#14555001 ("Dereference before null check")

Fixes 6e0a5de2136b ("serial: 8250: Use hrtimers for rs485 delays")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/8250/8250_port.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 4726aa276968..c20b581313f0 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1606,18 +1606,18 @@ static inline void start_tx_rs485(struct uart_port *port)
 static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t)
 {
 	struct uart_8250_em485 *em485;
-	struct uart_8250_port *p;
 	unsigned long flags;
 	em485 = container_of(t, struct uart_8250_em485, start_tx_timer);
-	p = em485->port;
 
-	spin_lock_irqsave(&p->port.lock, flags);
 	if (em485 &&
 	    em485->active_timer == &em485->start_tx_timer) {
+		struct uart_8250_port *p = em485->port;
+
+		spin_lock_irqsave(&p->port.lock, flags);
 		__start_tx(&p->port);
 		em485->active_timer = NULL;
+		spin_unlock_irqrestore(&p->port.lock, flags);
 	}
-	spin_unlock_irqrestore(&p->port.lock, flags);
 	return HRTIMER_NORESTART;
 }
 
-- 
2.14.1
