From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH] serial: sh-sci: prevent lockup on full TTY buffers
Date: Thu, 15 Feb 2018 13:02:27 +0100
Message-ID: <1518696147-23790-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org
Cc: wsa@the-dreams.de, geert@linux-m68k.org, yoshihiro.shimoda.uh@renesas.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

When the TTY buffers fill up to the configured maximum, a system lockup
occurs:

[  598.820128] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  598.825796]  0-...!: (1 GPs behind) idle=5a6/2/0 softirq=1974/1974 fqs=1
[  598.832577]  (detected by 3, t=62517 jiffies, g=296, c=295, q=126)
[  598.838755] Task dump for CPU 0:
[  598.841977] swapper/0       R  running task        0     0      0 0x00000022
[  598.849023] Call trace:
[  598.851476]  __switch_to+0x98/0xb0
[  598.854870]            (null)

This can be prevented by doing a dummy read of the RX data register.

This issue affects both HSCIF and SCIF ports. Reported for R-Car H3 ES2.0;
reproduced and fixed on H3 ES1.1. Probably affects other R-Car platforms
as well.

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/tty/serial/sh-sci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d9f399c..db2ebec 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -885,6 +885,8 @@ static void sci_receive_chars(struct uart_port *port)
 		/* Tell the rest of the system the news. New characters! */
 		tty_flip_buffer_push(tport);
 	} else {
+		/* TTY buffers full; read from RX reg to prevent lockup */
+		serial_port_in(port, SCxRDR);
 		serial_port_in(port, SCxSR); /* dummy read */
 		sci_clear_SCxSR(port, SCxSR_RDxF_CLEAR(port));
 	}
-- 
2.7.4
