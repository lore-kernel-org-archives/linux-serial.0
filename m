From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 4/4] serial: fix wakup races in the mrst_max3110 driver
Date: Thu, 17 Jun 2010 11:02:15 +0100
Message-ID: <20100617100213.4379.16616.stgit@localhost.localdomain>
References: <20100617100012.4379.92949.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30637 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757135Ab0FQKZU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Jun 2010 06:25:20 -0400
In-Reply-To: <20100617100012.4379.92949.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>

The mrst_max3110 driver had a set of unsafe wakeup sequences
along the following line:

if (!atomic_read(&foo)) {
  atomic_set(&foo, 1);
  wake_up(worker_thread);
}
and the worker thread would do

if (atomic_read(&foo)) {
  do_work();
  atomic_set(&foo, 0);
}

which can result in various missed wakups due to test-then-set races,
as well as due to clear-after-work instead of clear-before-work.

This patch fixes these races by using the proper bit test-and-set operations,
and by doing clear-before-work.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/serial/mrst_max3110.c |   46 ++++++++++++++++-------------------------
 1 files changed, 18 insertions(+), 28 deletions(-)


diff --git a/drivers/serial/mrst_max3110.c b/drivers/serial/mrst_max3110.c
index 0341853..f6ad1ec 100644
--- a/drivers/serial/mrst_max3110.c
+++ b/drivers/serial/mrst_max3110.c
@@ -48,6 +48,10 @@
 
 #define PR_FMT	"mrst_max3110: "
 
+#define UART_TX_NEEDED 1
+#define CON_TX_NEEDED  2
+#define BIT_IRQ_PENDING    3
+
 struct uart_max3110 {
 	struct uart_port port;
 	struct spi_device *spi;
@@ -63,15 +67,13 @@ struct uart_max3110 {
 	u8 clock;
 	u8 parity, word_7bits;
 
-	atomic_t uart_tx_need;
+	unsigned long uart_flags;
 
 	/* console related */
 	struct circ_buf con_xmit;
-	atomic_t con_tx_need;
 
 	/* irq related */
 	u16 irq;
-	atomic_t irq_pending;
 };
 
 /* global data structure, may need be removed */
@@ -176,10 +178,9 @@ static void serial_m3110_con_putchar(struct uart_port *port, int ch)
 		xmit->head = (xmit->head + 1) & (PAGE_SIZE - 1);
 	}
 
-	if (!atomic_read(&max->con_tx_need)) {
-		atomic_set(&max->con_tx_need, 1);
+
+	if (!test_and_set_bit(CON_TX_NEEDED, &max->uart_flags))
 		wake_up_process(max->main_thread);
-	}
 }
 
 /*
@@ -318,10 +319,8 @@ static void serial_m3110_start_tx(struct uart_port *port)
 	struct uart_max3110 *max =
 		container_of(port, struct uart_max3110, port);
 
-	if (!atomic_read(&max->uart_tx_need)) {
-		atomic_set(&max->uart_tx_need, 1);
+	if (!test_and_set_bit(UART_TX_NEEDED, &max->uart_flags))
 		wake_up_process(max->main_thread);
-	}
 }
 
 static void receive_chars(struct uart_max3110 *max, unsigned char *str, int len)
@@ -392,32 +391,23 @@ static int max3110_main_thread(void *_max)
 	pr_info(PR_FMT "start main thread\n");
 
 	do {
-		wait_event_interruptible(*wq, (atomic_read(&max->irq_pending) ||
-					       atomic_read(&max->con_tx_need) ||
-					     atomic_read(&max->uart_tx_need)) ||
-					     kthread_should_stop());
+		wait_event_interruptible(*wq, max->uart_flags || kthread_should_stop());
 
 		mutex_lock(&max->thread_mutex);
 
-#ifdef CONFIG_MRST_MAX3110_IRQ
-		if (atomic_read(&max->irq_pending)) {
+		if (test_and_clear_bit(BIT_IRQ_PENDING, &max->uart_flags))
 			max3110_console_receive(max);
-			atomic_set(&max->irq_pending, 0);
-		}
-#endif
 
 		/* first handle console output */
-		if (atomic_read(&max->con_tx_need)) {
+		if (test_and_clear_bit(CON_TX_NEEDED, &max->uart_flags))
 			send_circ_buf(max, xmit);
-			atomic_set(&max->con_tx_need, 0);
-		}
 
 		/* handle uart output */
-		if (atomic_read(&max->uart_tx_need)) {
+		if (test_and_clear_bit(UART_TX_NEEDED, &max->uart_flags))
 			transmit_char(max);
-			atomic_set(&max->uart_tx_need, 0);
-		}
+
 		mutex_unlock(&max->thread_mutex);
+
 	} while (!kthread_should_stop());
 
 	return ret;
@@ -430,10 +420,9 @@ static irqreturn_t serial_m3110_irq(int irq, void *dev_id)
 
 	/* max3110's irq is a falling edge, not level triggered,
 	 * so no need to disable the irq */
-	if (!atomic_read(&max->irq_pending)) {
-		atomic_inc(&max->irq_pending);
+	if (!test_and_set_bit(BIT_IRQ_PENDING, &max->uart_flags))
 		wake_up_process(max->main_thread);
-	}
+
 	return IRQ_HANDLED;
 }
 #else
@@ -753,7 +742,8 @@ static int serial_m3110_probe(struct spi_device *spi)
 	max->baud = 0;
 
 	max->cur_conf = 0;
-	atomic_set(&max->irq_pending, 0);
+	max->uart_flags = 0;
+
 	/* Check if reading configuration register returns something sane */
 
 	res = RC_TAG;

