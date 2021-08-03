Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1F0C43216
	for <linux-serial@archiver.kernel.org>; Tue,  3 Aug 2021 19:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2AA60F94
	for <linux-serial@archiver.kernel.org>; Tue,  3 Aug 2021 19:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239927AbhHCT3N (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:29:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:8486 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239917AbhHCT3M (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Aug 2021 15:29:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="193356374"
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="193356374"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 12:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="670622357"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2021 12:28:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 429751C8; Tue,  3 Aug 2021 22:29:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 2/5] platform/surface: aggregator: Use serdev_acpi_get_uart_resource() helper
Date:   Tue,  3 Aug 2021 22:29:02 +0300
Message-Id: <20210803192905.72246-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210803192905.72246-1-andriy.shevchenko@linux.intel.com>
References: <20210803192905.72246-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

serdev provides a generic helper to get UART Serial Bus resources.
Use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/surface/aggregator/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 279d9df19c01..c61bbeeec2df 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -301,20 +301,13 @@ static acpi_status ssam_serdev_setup_via_acpi_crs(struct acpi_resource *rsc,
 						  void *ctx)
 {
 	struct serdev_device *serdev = ctx;
-	struct acpi_resource_common_serialbus *serial;
 	struct acpi_resource_uart_serialbus *uart;
 	bool flow_control;
 	int status = 0;
 
-	if (rsc->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+	if (!serdev_acpi_get_uart_resource(rsc, &uart))
 		return AE_OK;
 
-	serial = &rsc->data.common_serial_bus;
-	if (serial->type != ACPI_RESOURCE_SERIAL_TYPE_UART)
-		return AE_OK;
-
-	uart = &rsc->data.uart_serial_bus;
-
 	/* Set up serdev device. */
 	serdev_device_set_baudrate(serdev, uart->default_baud_rate);
 
-- 
2.30.2

