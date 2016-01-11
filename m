From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 7/8] serial: core: Unfold < 80 char lines
Date: Sun, 10 Jan 2016 20:24:01 -0800
Message-ID: <1452486242-7297-8-git-send-email-peter@hurleysoftware.com>
References: <1452486242-7297-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452486242-7297-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 530b892..3031982 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1686,17 +1686,13 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
 		seq_printf(m, " tx:%d rx:%d",
 				uport->icount.tx, uport->icount.rx);
 		if (uport->icount.frame)
-			seq_printf(m, " fe:%d",
-				uport->icount.frame);
+			seq_printf(m, " fe:%d",	uport->icount.frame);
 		if (uport->icount.parity)
-			seq_printf(m, " pe:%d",
-				uport->icount.parity);
+			seq_printf(m, " pe:%d",	uport->icount.parity);
 		if (uport->icount.brk)
-			seq_printf(m, " brk:%d",
-				uport->icount.brk);
+			seq_printf(m, " brk:%d", uport->icount.brk);
 		if (uport->icount.overrun)
-			seq_printf(m, " oe:%d",
-				uport->icount.overrun);
+			seq_printf(m, " oe:%d", uport->icount.overrun);
 
 #define INFOBIT(bit, str) \
 	if (uport->mctrl & (bit)) \
@@ -1731,8 +1727,7 @@ static int uart_proc_show(struct seq_file *m, void *v)
 	struct uart_driver *drv = ttydrv->driver_state;
 	int i;
 
-	seq_printf(m, "serinfo:1.0 driver%s%s revision:%s\n",
-			"", "", "");
+	seq_printf(m, "serinfo:1.0 driver%s%s revision:%s\n", "", "", "");
 	for (i = 0; i < drv->nr; i++)
 		uart_line_info(m, drv, i);
 	return 0;
-- 
2.7.0
