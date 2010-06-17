From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 3/4] serial: replace open coded mutex with a real mutex in
	mrst_max3110.c
Date: Thu, 17 Jun 2010 11:02:06 +0100
Message-ID: <20100617100204.4379.5286.stgit@localhost.localdomain>
References: <20100617100012.4379.92949.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13046 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755395Ab0FQKZL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Jun 2010 06:25:11 -0400
In-Reply-To: <20100617100012.4379.92949.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>

The mrst_max3110.c driver uses an open coded, non atomic variable
to create exclusion between two of its worker threads. More than that,
while the main thread does a proper set-work-clear sequence,
the other thread only does a test, with the result that no actual
exclusion is happening.

this patch replaces this open coded variable with a proper mutex

in addition, the 'lock' spinlock is removed from the per adapter structure,
the lock was only ever initialized but never used

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/serial/mrst_max3110.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)


diff --git a/drivers/serial/mrst_max3110.c b/drivers/serial/mrst_max3110.c
index f9c01ae..0341853 100644
--- a/drivers/serial/mrst_max3110.c
+++ b/drivers/serial/mrst_max3110.c
@@ -56,8 +56,7 @@ struct uart_max3110 {
 	wait_queue_head_t wq;
 	struct task_struct *main_thread;
 	struct task_struct *read_thread;
-	int mthread_up;
-	spinlock_t lock;
+	struct mutex thread_mutex;;
 
 	u32 baud;
 	u16 cur_conf;
@@ -397,7 +396,8 @@ static int max3110_main_thread(void *_max)
 					       atomic_read(&max->con_tx_need) ||
 					     atomic_read(&max->uart_tx_need)) ||
 					     kthread_should_stop());
-		max->mthread_up = 1;
+
+		mutex_lock(&max->thread_mutex);
 
 #ifdef CONFIG_MRST_MAX3110_IRQ
 		if (atomic_read(&max->irq_pending)) {
@@ -417,7 +417,7 @@ static int max3110_main_thread(void *_max)
 			transmit_char(max);
 			atomic_set(&max->uart_tx_need, 0);
 		}
-		max->mthread_up = 0;
+		mutex_unlock(&max->thread_mutex);
 	} while (!kthread_should_stop());
 
 	return ret;
@@ -444,8 +444,9 @@ static int max3110_read_thread(void *_max)
 
 	pr_info(PR_FMT "start read thread\n");
 	do {
-		if (!max->mthread_up)
-			max3110_console_receive(max);
+		mutex_lock(&max->thread_mutex);
+		max3110_console_receive(max);
+		mutex_unlock(&max->thread_mutex);
 
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(HZ / 20);
@@ -745,7 +746,7 @@ static int serial_m3110_probe(struct spi_device *spi)
 	max->name = spi->modalias;	/* use spi name as the name */
 	max->irq = (u16)spi->irq;
 
-	spin_lock_init(&max->lock);
+	mutex_init(&max->thread_mutex);
 
 	max->word_7bits = 0;
 	max->parity = 0;

