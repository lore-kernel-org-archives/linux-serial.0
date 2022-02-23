Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB4BC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 23 Feb 2022 15:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240906AbiBWPM4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Feb 2022 10:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiBWPMz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Feb 2022 10:12:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ABCB0C59;
        Wed, 23 Feb 2022 07:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645629147; x=1677165147;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qMarhxCBuuIazWT4M/7uzoNqED1lkqXiUG/trfcuqVE=;
  b=PE2FJpbnD6Xu2K+83Sdc0GouKEG6toPvpwvx+FdskF8B6hJLX1PC4ZhT
   oGsBtPJKPQ3MTo+aSKzlgEuVdhoC/Z11QzuIvz/yscuAWn3auANfaDvaw
   x/dc1FbD7bl0wBLwqVCvHo7d1Pq8zg3riWOKaKm25LGisOSmoL3SFRnWh
   dqMbCzMD3LOy0KxYXQErkSF/5Iai7yvs+Sd5OYalIoe0U5RjpwHNl26R8
   TUs6nAO+WPgV6MA6No8QLIDzoNVZ9hHWoZRcDte/cVuhgxEdAEo35cAD0
   HgPUXYTIcbOSCSge/mQ9Gz9854GVGUHNn3eyoYmdsfWc7cqaH8oD3Hg8e
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="338421166"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="338421166"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 07:12:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="628112855"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Feb 2022 07:12:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3B30194; Wed, 23 Feb 2022 17:12:41 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Qing Wang <wangqing@vivo.com>
Subject: [PATCH v3 1/1] serial: 8250_lpss: Balance reference count for PCI DMA device
Date:   Wed, 23 Feb 2022 17:12:40 +0200
Message-Id: <20220223151240.70248-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The pci_get_slot() increases its reference count, the caller
must decrement the reference count by calling pci_dev_put().

Fixes: 9a1870ce812e ("serial: 8250: don't use slave_id of dma_slave_config")
Depends-on: a13e19cf3dc1 ("serial: 8250_lpss: split LPSS driver to separate module")
Reported-by: Qing Wang <wangqing@vivo.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: split out as independent patch from the series (the rest is under discussion)
 drivers/tty/serial/8250/8250_lpss.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index d3bafec7619d..0f5af061e0b4 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -117,8 +117,7 @@ static int byt_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 {
 	struct dw_dma_slave *param = &lpss->dma_param;
 	struct pci_dev *pdev = to_pci_dev(port->dev);
-	unsigned int dma_devfn = PCI_DEVFN(PCI_SLOT(pdev->devfn), 0);
-	struct pci_dev *dma_dev = pci_get_slot(pdev->bus, dma_devfn);
+	struct pci_dev *dma_dev;
 
 	switch (pdev->device) {
 	case PCI_DEVICE_ID_INTEL_BYT_UART1:
@@ -137,6 +136,8 @@ static int byt_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 		return -EINVAL;
 	}
 
+	dma_dev = pci_get_slot(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), 0));
+
 	param->dma_dev = &dma_dev->dev;
 	param->m_master = 0;
 	param->p_master = 1;
@@ -152,6 +153,14 @@ static int byt_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 	return 0;
 }
 
+static void byt_serial_exit(struct lpss8250 *lpss)
+{
+	struct dw_dma_slave *param = &lpss->dma_param;
+
+	/* Paired with pci_get_slot() in the byt_serial_setup() above */
+	put_device(param->dma_dev);
+}
+
 static int ehl_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 {
 	struct uart_8250_dma *dma = &lpss->data.dma;
@@ -170,6 +179,13 @@ static int ehl_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 	return 0;
 }
 
+static void ehl_serial_exit(struct lpss8250 *lpss)
+{
+	struct uart_8250_port *up = serial8250_get_port(lpss->data.line);
+
+	up->dma = NULL;
+}
+
 #ifdef CONFIG_SERIAL_8250_DMA
 static const struct dw_dma_platform_data qrk_serial_dma_pdata = {
 	.nr_channels = 2,
@@ -344,8 +360,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_exit:
-	if (lpss->board->exit)
-		lpss->board->exit(lpss);
+	lpss->board->exit(lpss);
 	pci_free_irq_vectors(pdev);
 	return ret;
 }
@@ -356,8 +371,7 @@ static void lpss8250_remove(struct pci_dev *pdev)
 
 	serial8250_unregister_port(lpss->data.line);
 
-	if (lpss->board->exit)
-		lpss->board->exit(lpss);
+	lpss->board->exit(lpss);
 	pci_free_irq_vectors(pdev);
 }
 
@@ -365,12 +379,14 @@ static const struct lpss8250_board byt_board = {
 	.freq = 100000000,
 	.base_baud = 2764800,
 	.setup = byt_serial_setup,
+	.exit = byt_serial_exit,
 };
 
 static const struct lpss8250_board ehl_board = {
 	.freq = 200000000,
 	.base_baud = 12500000,
 	.setup = ehl_serial_setup,
+	.exit = ehl_serial_exit,
 };
 
 static const struct lpss8250_board qrk_board = {
-- 
2.34.1

