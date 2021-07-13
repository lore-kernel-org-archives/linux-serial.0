Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499C0C07E95
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 10:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 246FD61279
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 10:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbhGMKUK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Jul 2021 06:20:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:62825 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235143AbhGMKUK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Jul 2021 06:20:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="210112538"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="210112538"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 03:17:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="570327144"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jul 2021 03:17:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EC93EFF; Tue, 13 Jul 2021 13:17:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: 8250_pci: Enumerate Elkhart Lake UARTs via dedicated driver
Date:   Tue, 13 Jul 2021 13:17:39 +0300
Message-Id: <20210713101739.36962-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Elkhart Lake UARTs are PCI enumerated Synopsys DesignWare v4.0+ UART
integrated with Intel iDMA 32-bit DMA controller. There is a specific
driver to handle them, i.e. 8250_lpss. Hence, disable 8250_pci
enumeration for these UARTs.

Fixes: 1b91d97c66ef ("serial: 8250_lpss: Add ->setup() for Elkhart Lake ports")
Fixes: 4f912b898dc2 ("serial: 8250_lpss: Enable HS UART on Elkhart Lake")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 75827b608fdb..02985cf90ef2 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3836,6 +3836,12 @@ static const struct pci_device_id blacklist[] = {
 	{ PCI_VDEVICE(INTEL, 0x0f0c), },
 	{ PCI_VDEVICE(INTEL, 0x228a), },
 	{ PCI_VDEVICE(INTEL, 0x228c), },
+	{ PCI_VDEVICE(INTEL, 0x4b96), },
+	{ PCI_VDEVICE(INTEL, 0x4b97), },
+	{ PCI_VDEVICE(INTEL, 0x4b98), },
+	{ PCI_VDEVICE(INTEL, 0x4b99), },
+	{ PCI_VDEVICE(INTEL, 0x4b9a), },
+	{ PCI_VDEVICE(INTEL, 0x4b9b), },
 	{ PCI_VDEVICE(INTEL, 0x9ce3), },
 	{ PCI_VDEVICE(INTEL, 0x9ce4), },
 
-- 
2.30.2

