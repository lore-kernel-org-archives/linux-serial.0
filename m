Return-Path: <SRS0=YMt1=X2=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F685FA373E
	for <linux-serial@archiver.kernel.org>; Tue,  1 Oct 2019 08:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6659121783
	for <linux-serial@archiver.kernel.org>; Tue,  1 Oct 2019 08:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfJAIQU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:16:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:34083 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfJAIQU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Oct 2019 04:16:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 01:16:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="scan'208";a="205022266"
Received: from pipin.fi.intel.com ([10.237.72.175])
  by fmsmga001.fm.intel.com with ESMTP; 01 Oct 2019 01:16:19 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH] serial: 8250_lpss: Switch over to MSI interrupts
Date:   Tue,  1 Oct 2019 11:16:17 +0300
Message-Id: <20191001081617.766084-1-felipe.balbi@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some devices support MSI interrupts. Let's at least try to use them in
platforms that provide MSI capability.

Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 5f72ef3ea574..f0f7a2777557 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -293,16 +293,22 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		return ret;
 
+	pci_set_master(pdev);
+
 	lpss = devm_kzalloc(&pdev->dev, sizeof(*lpss), GFP_KERNEL);
 	if (!lpss)
 		return -ENOMEM;
 
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0)
+		return ret;
+
 	lpss->board = (struct lpss8250_board *)id->driver_data;
 
 	memset(&uart, 0, sizeof(struct uart_8250_port));
 
 	uart.port.dev = &pdev->dev;
-	uart.port.irq = pdev->irq;
+	uart.port.irq = pci_irq_vector(pdev, 0);
 	uart.port.private_data = &lpss->data;
 	uart.port.type = PORT_16550A;
 	uart.port.iotype = UPIO_MEM;
@@ -337,6 +343,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_exit:
 	if (lpss->board->exit)
 		lpss->board->exit(lpss);
+	pci_free_irq_vectors(pdev);
 	return ret;
 }
 
@@ -348,6 +355,7 @@ static void lpss8250_remove(struct pci_dev *pdev)
 
 	if (lpss->board->exit)
 		lpss->board->exit(lpss);
+	pci_free_irq_vectors(pdev);
 }
 
 static const struct lpss8250_board byt_board = {
-- 
2.23.0

