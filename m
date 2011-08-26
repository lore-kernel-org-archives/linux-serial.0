From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/4] max3110: wake up fixes
Date: Fri, 26 Aug 2011 11:24:49 +0100
Message-ID: <20110826102414.17010.71484.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60893 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab1HZLVE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 07:21:04 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie@gmail.com>

The main thread is waiting on on a wait_queue but wake_up_process() is
used to wake the thread. This reads weirdly. Change wake_up_process() to
wake_up().

Tested on the Moorestown tablet build

Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/mrst_max3110.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/mrst_max3110.c b/drivers/tty/serial/mrst_max3110.c
index 23bc743..9c2cd8c 100644
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

