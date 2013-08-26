From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] serial: icom: move array overflow checks earlier
Date: Mon, 26 Aug 2013 18:10:01 +0300
Message-ID: <20130826151001.GC12428@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This code does an annoying thing where it writes to the array and then
checks later for array overflows.  I don't know if it's actually
possible to overflow but let's check before using the array index.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 06555dd..c5ed86a 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -297,25 +297,25 @@ static void stop_processor(struct icom_port *icom_port)
 	spin_lock_irqsave(&icom_lock, flags);
 
 	port = icom_port->port;
+	if (port >= ARRAY_SIZE(stop_proc)) {
+		dev_err(&icom_port->adapter->pci_dev->dev,
+			"Invalid port assignment\n");
+		goto unlock;
+	}
+
 	if (port == 0 || port == 1)
 		stop_proc[port].global_control_reg = &icom_port->global_reg->control;
 	else
 		stop_proc[port].global_control_reg = &icom_port->global_reg->control_2;
 
+	temp = readl(stop_proc[port].global_control_reg);
+	temp = (temp & ~start_proc[port].processor_id) | stop_proc[port].processor_id;
+	writel(temp, stop_proc[port].global_control_reg);
 
-	if (port < 4) {
-		temp = readl(stop_proc[port].global_control_reg);
-		temp =
-			(temp & ~start_proc[port].processor_id) | stop_proc[port].processor_id;
-		writel(temp, stop_proc[port].global_control_reg);
-
-		/* write flush */
-		readl(stop_proc[port].global_control_reg);
-	} else {
-		dev_err(&icom_port->adapter->pci_dev->dev,
-                        "Invalid port assignment\n");
-	}
+	/* write flush */
+	readl(stop_proc[port].global_control_reg);
 
+unlock:
 	spin_unlock_irqrestore(&icom_lock, flags);
 }
 
@@ -328,23 +328,25 @@ static void start_processor(struct icom_port *icom_port)
 	spin_lock_irqsave(&icom_lock, flags);
 
 	port = icom_port->port;
+	if (port >= ARRAY_SIZE(start_proc)) {
+		dev_err(&icom_port->adapter->pci_dev->dev,
+			"Invalid port assignment\n");
+		goto unlock;
+	}
+
 	if (port == 0 || port == 1)
 		start_proc[port].global_control_reg = &icom_port->global_reg->control;
 	else
 		start_proc[port].global_control_reg = &icom_port->global_reg->control_2;
-	if (port < 4) {
-		temp = readl(start_proc[port].global_control_reg);
-		temp =
-			(temp & ~stop_proc[port].processor_id) | start_proc[port].processor_id;
-		writel(temp, start_proc[port].global_control_reg);
 
-		/* write flush */
-		readl(start_proc[port].global_control_reg);
-	} else {
-		dev_err(&icom_port->adapter->pci_dev->dev,
-                        "Invalid port assignment\n");
-	}
+	temp = readl(start_proc[port].global_control_reg);
+	temp = (temp & ~stop_proc[port].processor_id) | start_proc[port].processor_id;
+	writel(temp, start_proc[port].global_control_reg);
+
+	/* write flush */
+	readl(start_proc[port].global_control_reg);
 
+unlock:
 	spin_unlock_irqrestore(&icom_lock, flags);
 }
 
@@ -557,6 +559,12 @@ static int startup(struct icom_port *icom_port)
 	 */
 	spin_lock_irqsave(&icom_lock, flags);
 	port = icom_port->port;
+	if (port >= ARRAY_SIZE(int_mask_tbl)) {
+		dev_err(&icom_port->adapter->pci_dev->dev,
+			"Invalid port assignment\n");
+		goto unlock;
+	}
+
 	if (port == 0 || port == 1)
 		int_mask_tbl[port].global_int_mask = &icom_port->global_reg->int_mask;
 	else
@@ -566,17 +574,14 @@ static int startup(struct icom_port *icom_port)
 		writew(0x00FF, icom_port->int_reg);
 	else
 		writew(0x3F00, icom_port->int_reg);
-	if (port < 4) {
-		temp = readl(int_mask_tbl[port].global_int_mask);
-		writel(temp & ~int_mask_tbl[port].processor_id, int_mask_tbl[port].global_int_mask);
 
-		/* write flush */
-		readl(int_mask_tbl[port].global_int_mask);
-	} else {
-		dev_err(&icom_port->adapter->pci_dev->dev,
-                        "Invalid port assignment\n");
-	}
+	temp = readl(int_mask_tbl[port].global_int_mask);
+	writel(temp & ~int_mask_tbl[port].processor_id, int_mask_tbl[port].global_int_mask);
+
+	/* write flush */
+	readl(int_mask_tbl[port].global_int_mask);
 
+unlock:
 	spin_unlock_irqrestore(&icom_lock, flags);
 	return 0;
 }
@@ -595,21 +600,23 @@ static void shutdown(struct icom_port *icom_port)
 	 * disable all interrupts
 	 */
 	port = icom_port->port;
+	if (port >= ARRAY_SIZE(int_mask_tbl)) {
+		dev_err(&icom_port->adapter->pci_dev->dev,
+			"Invalid port assignment\n");
+		goto unlock;
+	}
 	if (port == 0 || port == 1)
 		int_mask_tbl[port].global_int_mask = &icom_port->global_reg->int_mask;
 	else
 		int_mask_tbl[port].global_int_mask = &icom_port->global_reg->int_mask_2;
 
-	if (port < 4) {
-		temp = readl(int_mask_tbl[port].global_int_mask);
-		writel(temp | int_mask_tbl[port].processor_id, int_mask_tbl[port].global_int_mask);
+	temp = readl(int_mask_tbl[port].global_int_mask);
+	writel(temp | int_mask_tbl[port].processor_id, int_mask_tbl[port].global_int_mask);
 
-		/* write flush */
-		readl(int_mask_tbl[port].global_int_mask);
-	} else {
-		dev_err(&icom_port->adapter->pci_dev->dev,
-                        "Invalid port assignment\n");
-	}
+	/* write flush */
+	readl(int_mask_tbl[port].global_int_mask);
+
+unlock:
 	spin_unlock_irqrestore(&icom_lock, flags);
 
 	/*
