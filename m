From: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 15/17] serial, rtc/ds1374: irq handler cleanups
Date: Sun, 21 Oct 2007 03:52:50 -0400 (EDT)
Message-ID: <20071021075250.C6DD919041B@havoc.gtf.org>
References: <lkjvxcz09835mnsdfv0983q4m1234m@havoc.gtf.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753533AbXJUH5H@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: a.zummo@towertech.it, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

commit 9f306bb4ff39adbd2ce83491c202f5fb87baaa45
Author: Jeff Garzik <jeff@garzik.org>
Date:   Fri Oct 19 19:35:26 2007 -0400

    serial, rtc/ds1374: irq handler cleanups
    
    * no need to use 'irq' function argument
    
    Signed-off-by: Jeff Garzik <jgarzik@redhat.com>

 drivers/rtc/rtc-ds1374.c |    4 ++--
 drivers/serial/8250.c    |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

9f306bb4ff39adbd2ce83491c202f5fb87baaa45
diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 45bda18..06017e1 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -257,12 +257,12 @@ out:
 	return ret;
 }
 
-static irqreturn_t ds1374_irq(int irq, void *dev_id)
+static irqreturn_t ds1374_irq(int dummy, void *dev_id)
 {
 	struct i2c_client *client = dev_id;
 	struct ds1374 *ds1374 = i2c_get_clientdata(client);
 
-	disable_irq_nosync(irq);
+	disable_irq_nosync(client->irq);
 	schedule_work(&ds1374->work);
 	return IRQ_HANDLED;
 }
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 0d661ba..9c0f82e 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1458,7 +1458,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 	struct list_head *l, *end = NULL;
 	int pass_counter = 0, handled = 0;
 
-	DEBUG_INTR("serial8250_interrupt(%d)...", irq);
+	DEBUG_INTR("serial8250_interrupt...");
 
 	spin_lock(&i->lock);
 
@@ -1497,7 +1497,7 @@ static irqreturn_t serial8250_interrupt(int irq, void *dev_id)
 		if (l == i->head && pass_counter++ > PASS_LIMIT) {
 			/* If we hit this, we're dead. */
 			printk(KERN_ERR "serial8250: too much work for "
-				"irq%d\n", irq);
+				"irq%d\n", up->port.irq);
 			break;
 		}
 	} while (l != end);
