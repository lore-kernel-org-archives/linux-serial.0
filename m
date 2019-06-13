From: Charles <18oliveira.charles@gmail.com>
Subject: [PATCH] serial: sh-sci: fix uninitialized variable warning
Date: Thu, 13 Jun 2019 15:08:24 -0300
Message-ID: <20190613180824.6ajwjelzr5fmjnie@debie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, rodrigosiqueiramelo@gmail.com
List-Id: linux-serial@vger.kernel.org

Avoid following compiler warning on uninitialized variable

In file included from ./include/linux/rwsem.h:16:0,
                 from ./include/linux/notifier.h:15,
                 from ./include/linux/clk.h:17,
                 from drivers/tty/serial/sh-sci.c:24:
drivers/tty/serial/sh-sci.c: In function ‘sci_dma_rx_submit’:
./include/linux/spinlock.h:288:3: warning: ‘flags’ may be used
uninitialized in this function [-Wmaybe-uninitialized]
   _raw_spin_unlock_irqrestore(lock, flags); \
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/tty/serial/sh-sci.c:1353:16: note: ‘flags’ was declared here
  unsigned long flags;
                ^~~~~

Signed-off-by: Charles Oliveira <18oliveira.charles@gmail.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index abc705716aa0..a6af73eaec11 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1350,7 +1350,7 @@ static int sci_dma_rx_submit(struct sci_port *s, bool port_lock_held)
 {
 	struct dma_chan *chan = s->chan_rx;
 	struct uart_port *port = &s->port;
-	unsigned long flags;
+	unsigned long uninitialized_var(flags);
 	int i;
 
 	for (i = 0; i < 2; i++) {
-- 
2.11.0
