Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54695C47082
	for <linux-serial@archiver.kernel.org>; Tue,  8 Jun 2021 14:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF576100B
	for <linux-serial@archiver.kernel.org>; Tue,  8 Jun 2021 14:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhFHOoX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Jun 2021 10:44:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:25794 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233522AbhFHOoX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Jun 2021 10:44:23 -0400
IronPort-SDR: wiDVHVWxZBYVIrzHALL9R9t044snO4oy0bT6/O0K1ODGCD2ijdDfr9nB+0skGvOhOFx1tMzuty
 hmU5X0qH/X2A==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="268711247"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="268711247"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 07:42:29 -0700
IronPort-SDR: VCnNFP8BBODtfPtm78jniAJaKDUPJRgW77UHB+uAtM3W5LH/LgTlpSgcEQ6fJC1HDu+LVB09ym
 e83vEWeEI9eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="413400427"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2021 07:42:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DB327142; Tue,  8 Jun 2021 17:42:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v1 2/3] serial: 8250_exar: Extract exar_get_platform() helper
Date:   Tue,  8 Jun 2021 17:42:38 +0300
Message-Id: <20210608144239.12697-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210608144239.12697-1-andriy.shevchenko@linux.intel.com>
References: <20210608144239.12697-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We would like to use DMI matching in other functions as well.
Hence, extract it as exar_get_platform() helper function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index bd4e9f6ac29c..3ffeedc29c83 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -501,23 +501,27 @@ static const struct dmi_system_id exar_platforms[] = {
 	{}
 };
 
+static const struct exar8250_platform *exar_get_platform(void)
+{
+	const struct dmi_system_id *dmi_match;
+
+	dmi_match = dmi_first_match(exar_platforms);
+	if (dmi_match)
+		return dmi_match->driver_data;
+
+	return &exar8250_default_platform;
+}
+
 static int
 pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
 		   struct uart_8250_port *port, int idx)
 {
-	const struct exar8250_platform *platform;
-	const struct dmi_system_id *dmi_match;
+	const struct exar8250_platform *platform = exar_get_platform();
 	unsigned int offset = idx * 0x400;
 	unsigned int baud = 7812500;
 	u8 __iomem *p;
 	int ret;
 
-	dmi_match = dmi_first_match(exar_platforms);
-	if (dmi_match)
-		platform = dmi_match->driver_data;
-	else
-		platform = &exar8250_default_platform;
-
 	port->port.uartclk = baud * 16;
 	port->port.rs485_config = platform->rs485_config;
 
-- 
2.30.2

