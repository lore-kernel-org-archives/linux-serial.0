From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 27/79] jsm: remove remaining flip buffer code
Date: Wed, 26 Oct 2011 14:12:32 +0200
Message-ID: <1319631204-23262-27-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60980 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932875Ab1JZMNk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:40 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>

The flip buffer is not used anymore. Remove its allocation and
declaration in the board structure.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/jsm/jsm.h        |    3 ---
 drivers/tty/serial/jsm/jsm_driver.c |   18 ------------------
 2 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm.h b/drivers/tty/serial/jsm/jsm.h
index b704c8c..cd53bdd 100644
--- a/drivers/tty/serial/jsm/jsm.h
+++ b/drivers/tty/serial/jsm/jsm.h
@@ -88,7 +88,6 @@ enum {
 
 /* 4 extra for alignment play space */
 #define WRITEBUFLEN	((4096) + 4)
-#define MYFLIPLEN	N_TTY_BUF_SIZE
 
 #define JSM_VERSION	"jsm: 1.2-1-INKERNEL"
 #define JSM_PARTNUM	"40002438_A-INKERNEL"
@@ -150,7 +149,6 @@ struct jsm_board
 	u32		bd_uart_offset;	/* Space between each UART */
 
 	struct jsm_channel *channels[MAXPORTS]; /* array of pointers to our channels. */
-	char		*flipbuf;	/* Our flip buffer, alloced if board is found */
 
 	u32		bd_dividend;	/* Board/UARTs specific dividend */
 
@@ -177,7 +175,6 @@ struct jsm_board
 #define CH_TX_FIFO_LWM	0x0800		/* TX Fifo is below Low Water	*/
 #define CH_BREAK_SENDING 0x1000		/* Break is being sent		*/
 #define CH_LOOPBACK 0x2000		/* Channel is in lookback mode	*/
-#define CH_FLIPBUF_IN_USE 0x4000	/* Channel's flipbuf is in use	*/
 #define CH_BAUD0	0x08000		/* Used for checking B0 transitions */
 
 /* Our Read/Error/Write queue sizes */
diff --git a/drivers/tty/serial/jsm/jsm_driver.c b/drivers/tty/serial/jsm/jsm_driver.c
index 96da178..1cc8cf6 100644
--- a/drivers/tty/serial/jsm/jsm_driver.c
+++ b/drivers/tty/serial/jsm/jsm_driver.c
@@ -160,27 +160,10 @@ static int __devinit jsm_probe_one(struct pci_dev *pdev, const struct pci_device
 	dev_info(&pdev->dev, "board %d: Digi Neo (rev %d), irq %d\n",
 			adapter_count, brd->rev, brd->irq);
 
-	/*
-	 * allocate flip buffer for board.
-	 *
-	 * Okay to malloc with GFP_KERNEL, we are not at interrupt
-	 * context, and there are no locks held.
-	 */
-	brd->flipbuf = kzalloc(MYFLIPLEN, GFP_KERNEL);
-	if (!brd->flipbuf) {
-		/* XXX: leaking all resources from jsm_tty_init and
-		 	jsm_uart_port_init here! */
-		dev_err(&pdev->dev, "memory allocation for flipbuf failed\n");
-		rc = -ENOMEM;
-		goto out_free_uart;
-	}
-
 	pci_set_drvdata(pdev, brd);
 	pci_save_state(pdev);
 
 	return 0;
- out_free_uart:
-	jsm_remove_uart_port(brd);
  out_free_irq:
 	jsm_remove_uart_port(brd);
 	free_irq(brd->irq, brd);
@@ -218,7 +201,6 @@ static void __devexit jsm_remove_one(struct pci_dev *pdev)
 
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-	kfree(brd->flipbuf);
 	kfree(brd);
 }
 
-- 
1.7.7

