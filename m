Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9977C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 13:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhKVNiV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 08:38:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:13752 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239142AbhKVNiU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 08:38:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="235019016"
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="235019016"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 05:35:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,254,1631602800"; 
   d="scan'208";a="589343839"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Nov 2021 05:35:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ACFBD329; Mon, 22 Nov 2021 15:35:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH v2 2/3] serial: 8250_pericom: Re-enable higher baud rates
Date:   Mon, 22 Nov 2021 15:35:11 +0200
Message-Id: <20211122133512.8947-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211122133512.8947-1-andriy.shevchenko@linux.intel.com>
References: <20211122133512.8947-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Jay Dolan <jay.dolan@accesio.com>

Add UPF_MAGIC_MULTIPLIER to the port flags since there is now
range checking in serial8250_get_baud_rate() in 8250_port.c.

Signed-off-by: Jay Dolan <jay.dolan@accesio.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pericom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pericom.c b/drivers/tty/serial/8250/8250_pericom.c
index df27f0daea7a..f0d026325f17 100644
--- a/drivers/tty/serial/8250/8250_pericom.c
+++ b/drivers/tty/serial/8250/8250_pericom.c
@@ -117,7 +117,7 @@ static int pericom8250_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	uart.port.private_data = pericom;
 	uart.port.iotype = UPIO_PORT;
 	uart.port.uartclk = 921600 * 16;
-	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ | UPF_MAGIC_MULTIPLIER;
 	uart.port.set_divisor = pericom_do_set_divisor;
 	for (i = 0; i < nr && i < maxnr; i++) {
 		unsigned int offset = (i == 3 && nr == 4) ? 0x38 : i * 0x8;
-- 
2.33.0

