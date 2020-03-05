Return-Path: <SRS0=YkBk=4W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA602C3F2CD
	for <linux-serial@archiver.kernel.org>; Thu,  5 Mar 2020 13:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7713420848
	for <linux-serial@archiver.kernel.org>; Thu,  5 Mar 2020 13:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgCENI0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:08:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:20090 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgCENI0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Mar 2020 08:08:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 05:08:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="352358897"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2020 05:08:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 154BC107; Thu,  5 Mar 2020 15:08:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>
Subject: [PATCH v1] serial: 8250_lpss: Add ->setup() for Elkhart Lake ports
Date:   Thu,  5 Mar 2020 15:08:22 +0200
Message-Id: <20200305130822.36850-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The ->setup() callback is mandatory for the devices.
Provide it for Elkhart Lake UART ports.

Note, for time being it's empty, but in the future it might require
an additional configuration such as DMA.

Reported-by: Raymond Tan <raymond.tan@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 60eff3240c8a..4dee8a9e0c95 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -156,6 +156,11 @@ static int byt_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
 	return 0;
 }
 
+static int ehl_serial_setup(struct lpss8250 *lpss, struct uart_port *port)
+{
+	return 0;
+}
+
 #ifdef CONFIG_SERIAL_8250_DMA
 static const struct dw_dma_platform_data qrk_serial_dma_pdata = {
 	.nr_channels = 2,
@@ -356,6 +361,7 @@ static const struct lpss8250_board byt_board = {
 static const struct lpss8250_board ehl_board = {
 	.freq = 200000000,
 	.base_baud = 12500000,
+	.setup = ehl_serial_setup,
 };
 
 static const struct lpss8250_board qrk_board = {
-- 
2.25.1

