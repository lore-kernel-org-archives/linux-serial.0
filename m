From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 04/30] jsm: Fix the return variable and removing the unused
	retval.
Date: Tue, 24 Mar 2009 14:02:23 +0000
Message-ID: <20090324140217.12735.2780.stgit@localhost.localdomain>
References: <20090324135930.12735.7827.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48930 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757590AbZCXOCB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Mar 2009 10:02:01 -0400
In-Reply-To: <20090324135930.12735.7827.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, torvalds@linux-foundation.org

From: Breno Leitao <leitao@linux.vnet.ibm.com>

As it was, the retval was never returned, so its assignments were silly.
Just consolidate everything to rc, and remove the unused retval variable.

Signed-off-by: Breno Leitao <leitao@linux.vnet.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Alan Cox <alan@etchedpixels.co.uk>
---

 drivers/serial/jsm/jsm_driver.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)


diff --git a/drivers/serial/jsm/jsm_driver.c b/drivers/serial/jsm/jsm_driver.c
index ac79cbe..e8da2f9 100644
--- a/drivers/serial/jsm/jsm_driver.c
+++ b/drivers/serial/jsm/jsm_driver.c
@@ -57,7 +57,6 @@ static int jsm_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	int rc = 0;
 	struct jsm_board *brd;
 	static int adapter_count = 0;
-	int retval;
 
 	rc = pci_enable_device(pdev);
 	if (rc) {
@@ -134,7 +133,7 @@ static int jsm_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	rc = jsm_tty_init(brd);
 	if (rc < 0) {
 		dev_err(&pdev->dev, "Can't init tty devices (%d)\n", rc);
-		retval = -ENXIO;
+		rc = -ENXIO;
 		goto out_free_irq;
 	}
 
@@ -142,7 +141,7 @@ static int jsm_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc < 0) {
 		/* XXX: leaking all resources from jsm_tty_init here! */
 		dev_err(&pdev->dev, "Can't init uart port (%d)\n", rc);
-		retval = -ENXIO;
+		rc = -ENXIO;
 		goto out_free_irq;
 	}
 
@@ -161,7 +160,7 @@ static int jsm_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		/* XXX: leaking all resources from jsm_tty_init and
 		 	jsm_uart_port_init here! */
 		dev_err(&pdev->dev, "memory allocation for flipbuf failed\n");
-		retval = -ENOMEM;
+		rc = -ENOMEM;
 		goto out_free_irq;
 	}
 

