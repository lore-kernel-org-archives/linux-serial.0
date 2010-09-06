From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 5/5] mrst_max3110: Make the IRQ option runtime
Date: Mon, 06 Sep 2010 13:40:34 +0100
Message-ID: <20100906124011.1328.62220.stgit@localhost.localdomain>
References: <20100906123843.1328.3930.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21987 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693Ab0IFNXW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Sep 2010 09:23:22 -0400
In-Reply-To: <20100906123843.1328.3930.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, greg@kroah.com

And while we are at it allow it to fail to find one. Without this the IRQ
option will cause the 3110 driver to fail on 0.7 SFI firmware.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/serial/Kconfig        |    7 -----
 drivers/serial/mrst_max3110.c |   55 +++++++++++++++++++++--------------------
 2 files changed, 28 insertions(+), 34 deletions(-)


diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 12900f7..ba4b390 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -717,13 +717,6 @@ config SERIAL_MRST_MAX3110
 	  the Intel Moorestown platform. On other systems use the max3100
 	  driver.
 
-config MRST_MAX3110_IRQ
-	boolean "Enable GPIO IRQ for Max3110 over Moorestown"
-	default n
-	depends on SERIAL_MRST_MAX3110 && GPIO_LANGWELL
-	help
-	  This has to be enabled after Moorestown GPIO driver is loaded
-
 config SERIAL_MFD_HSU
 	tristate "Medfield High Speed UART support"
 	depends on PCI
diff --git a/drivers/serial/mrst_max3110.c b/drivers/serial/mrst_max3110.c
index 880dce3..bae2697 100644
--- a/drivers/serial/mrst_max3110.c
+++ b/drivers/serial/mrst_max3110.c
@@ -446,7 +446,6 @@ static int max3110_main_thread(void *_max)
 	return ret;
 }
 
-#ifdef CONFIG_MRST_MAX3110_IRQ
 static irqreturn_t serial_m3110_irq(int irq, void *dev_id)
 {
 	struct uart_max3110 *max = dev_id;
@@ -458,7 +457,7 @@ static irqreturn_t serial_m3110_irq(int irq, void *dev_id)
 
 	return IRQ_HANDLED;
 }
-#else
+
 /* if don't use RX IRQ, then need a thread to polling read */
 static int max3110_read_thread(void *_max)
 {
@@ -481,7 +480,6 @@ static int max3110_read_thread(void *_max)
 
 	return 0;
 }
-#endif
 
 static int serial_m3110_startup(struct uart_port *port)
 {
@@ -504,34 +502,38 @@ static int serial_m3110_startup(struct uart_port *port)
 	/* as we use thread to handle tx/rx, need set low latency */
 	port->state->port.tty->low_latency = 1;
 
-#ifdef CONFIG_MRST_MAX3110_IRQ
-	ret = request_irq(max->irq, serial_m3110_irq,
+	if (max->irq) {
+		max->read_thread = NULL;
+		ret = request_irq(max->irq, serial_m3110_irq,
 				IRQ_TYPE_EDGE_FALLING, "max3110", max);
-	if (ret)
-		return ret;
+		if (ret) {
+			max->irq = 0;
+			pr_err(PR_FMT "unable to allocate IRQ, polling\n");
+		}  else {
+			/* Enable RX IRQ only */
+			config |= WC_RXA_IRQ_ENABLE;
+		}
+	}
 
-	/* Enable RX IRQ only */
-	config |= WC_RXA_IRQ_ENABLE;
-#else
-	/* If IRQ is disabled, start a read thread for input data */
-	max->read_thread =
-		kthread_run(max3110_read_thread, max, "max3110_read");
-	if (IS_ERR(max->read_thread)) {
-		ret = PTR_ERR(max->read_thread);
-		max->read_thread = NULL;
-		pr_err(PR_FMT "Can't create read thread!");
-		return ret;
+	if (max->irq == 0) {
+		/* If IRQ is disabled, start a read thread for input data */
+		max->read_thread =
+			kthread_run(max3110_read_thread, max, "max3110_read");
+		if (IS_ERR(max->read_thread)) {
+			ret = PTR_ERR(max->read_thread);
+			max->read_thread = NULL;
+			pr_err(PR_FMT "Can't create read thread!\n");
+			return ret;
+		}
 	}
-#endif
 
 	ret = max3110_out(max, config);
 	if (ret) {
-#ifdef CONFIG_MRST_MAX3110_IRQ
-		free_irq(max->irq, max);
-#else
-		kthread_stop(max->read_thread);
+		if (max->irq)
+			free_irq(max->irq, max);
+		if (max->read_thread)
+			kthread_stop(max->read_thread);
 		max->read_thread = NULL;
-#endif
 		return ret;
 	}
 
@@ -550,9 +552,8 @@ static void serial_m3110_shutdown(struct uart_port *port)
 		max->read_thread = NULL;
 	}
 
-#ifdef CONFIG_MRST_MAX3110_IRQ
-	free_irq(max->irq, max);
-#endif
+	if (max->irq)
+		free_irq(max->irq, max);
 
 	/* Disable interrupts from this port */
 	config = WC_TAG | WC_SW_SHDI;

