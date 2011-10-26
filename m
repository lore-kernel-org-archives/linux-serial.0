From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 35/79] hsu: add runtime pm support
Date: Wed, 26 Oct 2011 14:12:40 +0200
Message-ID: <1319631204-23262-35-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60998 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932857Ab1JZMNn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:43 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Kristen Carlson Accardi <kristen@linux.intel.com>

Doesn't appear to be much to do here, however having the suspend/resume
functions will allow the d3/d0 transitions to be sent by the pci core.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/mfd.c |   47 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index cab52f4..cfa7501 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -38,6 +38,7 @@
 #include <linux/pci.h>
 #include <linux/io.h>
 #include <linux/debugfs.h>
+#include <linux/pm_runtime.h>
 
 #define HSU_DMA_BUF_SIZE	2048
 
@@ -764,6 +765,8 @@ static int serial_hsu_startup(struct uart_port *port)
 		container_of(port, struct uart_hsu_port, port);
 	unsigned long flags;
 
+	pm_runtime_get_sync(up->dev);
+
 	/*
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
@@ -871,6 +874,8 @@ static void serial_hsu_shutdown(struct uart_port *port)
 				  UART_FCR_CLEAR_RCVR |
 				  UART_FCR_CLEAR_XMIT);
 	serial_out(up, UART_FCR, 0);
+
+	pm_runtime_put(up->dev);
 }
 
 static void
@@ -1249,6 +1254,39 @@ static int serial_hsu_resume(struct pci_dev *pdev)
 #define serial_hsu_resume	NULL
 #endif
 
+#ifdef CONFIG_PM_RUNTIME
+static int serial_hsu_runtime_idle(struct device *dev)
+{
+	int err;
+
+	err = pm_schedule_suspend(dev, 500);
+	if (err)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int serial_hsu_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int serial_hsu_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+#else
+#define serial_hsu_runtime_idle		NULL
+#define serial_hsu_runtime_suspend	NULL
+#define serial_hsu_runtime_resume	NULL
+#endif
+
+static const struct dev_pm_ops serial_hsu_pm_ops = {
+	.runtime_suspend = serial_hsu_runtime_suspend,
+	.runtime_resume = serial_hsu_runtime_resume,
+	.runtime_idle = serial_hsu_runtime_idle,
+};
+
 /* temp global pointer before we settle down on using one or four PCI dev */
 static struct hsu_port *phsu;
 
@@ -1315,6 +1353,9 @@ static int serial_hsu_probe(struct pci_dev *pdev,
 		pci_set_drvdata(pdev, uport);
 	}
 
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
+
 	return 0;
 
 err_disable:
@@ -1411,6 +1452,9 @@ static void serial_hsu_remove(struct pci_dev *pdev)
 	if (!priv)
 		return;
 
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+
 	/* For port 0/1/2, priv is the address of uart_hsu_port */
 	if (pdev->device != 0x081E) {
 		up = priv;
@@ -1438,6 +1482,9 @@ static struct pci_driver hsu_pci_driver = {
 	.remove =	__devexit_p(serial_hsu_remove),
 	.suspend =	serial_hsu_suspend,
 	.resume	=	serial_hsu_resume,
+	.driver = {
+		.pm = &serial_hsu_pm_ops,
+	},
 };
 
 static int __init hsu_pci_init(void)
-- 
1.7.7

