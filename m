Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C082FC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 25 Apr 2022 14:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242462AbiDYOiv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Apr 2022 10:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242546AbiDYOis (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Apr 2022 10:38:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869D339177
        for <linux-serial@vger.kernel.org>; Mon, 25 Apr 2022 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650897335; x=1682433335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M20JHKJiXZAMJNMAVPefCnaIxwHFCR/rpkPdlb+OK2c=;
  b=RBlWGGcUT1RUKCgj+OVtWQKy2GTrRBZGHPLNjKBsKKYF7qHhTDAq55gy
   eFGayMEEdyzNW1bDeinLln/N+r9htAW9urM+NN5Zgqx9QeaRJ/GU4AClI
   3jCGTBKUfCfrhrezLmbxi9zGlpINryOWI20parv1g1yN2QZZBdErvWDCa
   8YN6NDtln+k25azuO9XJ59HmzVT9LwpCyTl9ZkZbzRv8CU5Aq7wl6V2k4
   wGoIY5OD544YSAr6Q9qgLB8Nz8w5BGGEE4XxUL19aHlDFeU9AcnXDqy73
   4ouoq8Il72Ae4KcGYrt0BkLcmXPT8/BkatiwaINbLLRW4rLWwXO2iGg/o
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="247191930"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="247191930"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:35:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="579315954"
Received: from lpuglia-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.217.93])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:35:29 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vicente Bergas <vicencb@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 07/13] ACPI / property: Document RS485 _DSD properties
Date:   Mon, 25 Apr 2022 17:34:04 +0300
Message-Id: <20220425143410.12703-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
References: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Document RS485 related properties returned from ACPI _DSD as device
properties.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 .../firmware-guide/acpi/enumeration.rst       | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index 74b830b2fd59..b42017bf789e 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -374,6 +374,31 @@ descriptors once the device is released.
 See Documentation/firmware-guide/acpi/gpio-properties.rst for more information
 about the _DSD binding related to GPIOs.
 
+RS-485 support
+==============
+
+ACPI _DSD (Device Specific Data) can be used to describe RS-485 capability
+of UART.
+
+For example::
+
+	Device (DEV)
+	{
+		...
+
+		// ACPI 5.1 _DSD used for RS-485 capabilities
+		Name (_DSD, Package ()
+		{
+			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+			Package ()
+			{
+				Package () {"rs485-rts-active-low", Zero},
+				Package () {"rs485-rx-active-high", Zero},
+				Package () {"rs485-rx-during-tx", Zero},
+			}
+		})
+		...
+
 MFD devices
 ===========
 
-- 
2.30.2

