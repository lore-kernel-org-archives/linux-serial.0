Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F802C4338F
	for <linux-serial@archiver.kernel.org>; Tue,  3 Aug 2021 19:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E7A60ED6
	for <linux-serial@archiver.kernel.org>; Tue,  3 Aug 2021 19:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239915AbhHCT3M (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:29:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:8486 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231978AbhHCT3L (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Aug 2021 15:29:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="193356375"
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="193356375"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 12:28:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="670622359"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2021 12:28:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 05ECE1CB; Tue,  3 Aug 2021 22:29:24 +0300 (EEST)
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
Subject: [PATCH v1 3/5] Bluetooth: hci_bcm: Use serdev_acpi_get_uart_resource() helper
Date:   Tue,  3 Aug 2021 22:29:03 +0300
Message-Id: <20210803192905.72246-3-andriy.shevchenko@linux.intel.com>
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
 drivers/bluetooth/hci_bcm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 3cd57fc56ade..16f854ac19b6 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -899,9 +899,9 @@ static const struct acpi_gpio_mapping acpi_bcm_int_first_gpios[] = {
 static int bcm_resource(struct acpi_resource *ares, void *data)
 {
 	struct bcm_device *dev = data;
+	struct acpi_resource_uart_serialbus *uart;
 	struct acpi_resource_extended_irq *irq;
 	struct acpi_resource_gpio *gpio;
-	struct acpi_resource_uart_serialbus *sb;
 
 	switch (ares->type) {
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
@@ -920,18 +920,15 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
 		dev->gpio_count++;
 		break;
 
-	case ACPI_RESOURCE_TYPE_SERIAL_BUS:
-		sb = &ares->data.uart_serial_bus;
-		if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_UART) {
-			dev->init_speed = sb->default_baud_rate;
-			dev->oper_speed = 4000000;
-		}
-		break;
-
 	default:
 		break;
 	}
 
+	if (serdev_acpi_get_uart_resource(ares, &uart)) {
+		dev->init_speed = uart->default_baud_rate;
+		dev->oper_speed = 4000000;
+	}
+
 	return 0;
 }
 
-- 
2.30.2

