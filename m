From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 38/79] max3110: wake up fixes
Date: Wed, 26 Oct 2011 14:12:43 +0200
Message-ID: <1319631204-23262-38-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32771 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932863Ab1JZMNp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:45 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Dirk Brandewie <dirk.brandewie@gmail.com>

The main thread is waiting on on a wait_queue but wake_up_process() is
used to wake the thread. This reads weirdly. Change wake_up_process() to
wake_up().

Tested on the Moorestown tablet build

Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/mrst_max3110.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mrst_max3110.c b/drivers/tty/serial/mrst_max3110.c
index a764bf9..c8f9868 100644
--- a/drivers/tty/serial/mrst_max3110.c
+++ b/drivers/tty/serial/mrst_max3110.c
@@ -207,7 +207,7 @@ static void serial_m3110_con_write(struct console *co,
 	uart_console_write(&pmax->port, s, count, serial_m3110_con_putchar);
 
 	if (!test_and_set_bit(CON_TX_NEEDED, &pmax->uart_flags))
-		wake_up_process(pmax->main_thread);
+		wake_up(&pmax->wq);
 }
 
 static int __init
@@ -301,6 +301,7 @@ static void send_circ_buf(struct uart_max3110 *max,
 			}
 
 			/* Fail to send msg to console is not very critical */
+
 			ret = max3110_write_then_read(max, obuf, ibuf, blen, 0);
 			if (ret)
 				pr_warning(PR_FMT "%s(): get err msg %d\n",
@@ -349,7 +350,7 @@ static void serial_m3110_start_tx(struct uart_port *port)
 		container_of(port, struct uart_max3110, port);
 
 	if (!test_and_set_bit(UART_TX_NEEDED, &max->uart_flags))
-		wake_up_process(max->main_thread);
+		wake_up(&max->wq);
 }
 
 static void receive_chars(struct uart_max3110 *max, unsigned char *str, int len)
@@ -424,7 +425,8 @@ static int max3110_main_thread(void *_max)
 	pr_info(PR_FMT "start main thread\n");
 
 	do {
-		wait_event_interruptible(*wq, max->uart_flags || kthread_should_stop());
+		wait_event_interruptible(*wq,
+				max->uart_flags || kthread_should_stop());
 
 		mutex_lock(&max->thread_mutex);
 
@@ -452,8 +454,9 @@ static irqreturn_t serial_m3110_irq(int irq, void *dev_id)
 
 	/* max3110's irq is a falling edge, not level triggered,
 	 * so no need to disable the irq */
+
 	if (!test_and_set_bit(BIT_IRQ_PENDING, &max->uart_flags))
-		wake_up_process(max->main_thread);
+		wake_up(&max->wq);
 
 	return IRQ_HANDLED;
 }
-- 
1.7.7

