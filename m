Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480DDC433F5
	for <linux-serial@archiver.kernel.org>; Tue, 26 Apr 2022 12:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349939AbiDZMam (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Apr 2022 08:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349851AbiDZMa3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Apr 2022 08:30:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ADF6971E
        for <linux-serial@vger.kernel.org>; Tue, 26 Apr 2022 05:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650976036; x=1682512036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FgehQVSXIsNlug+rF8M1RReYLj5RamKuwUI1clH3zTg=;
  b=V1+yQgYDusbC80bLkKuq8TOx5woZLaeKpq1udiCS+O3YC/8d3Jw9rVGB
   dlLi0bDayZvO13M3mjzhcJk3dhSys2o/MjyHx/GC+vOXJzu0agcHYUQgD
   u5++YvS16um2+QdkT7Rd/xR1i7szmqSp7WttNGVCwRiyy1jeRJagVmeER
   mW8qqXEoMC2ukHBuPnuuYsqM9R291TIPp6ZOs+HFqcJ0cjb83ry5xFCKO
   9M2HPIalT062MB8P0yLU+FpSO2xdaTSnfV+ahiVnbK/Ep7j8U9xaZsGL8
   c0XPijctQ9rrTdc8DEboJNStEoTmkBqV7P+nTbG9mLaDjcqeekxLPbk19
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265724746"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="265724746"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 05:27:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579864875"
Received: from mmilkovx-mobl.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.47.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 05:27:13 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vicente Bergas <vicencb@gmail.com>,
        Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 04/10] ACPI / property: Document RS485 _DSD properties
Date:   Tue, 26 Apr 2022 15:24:42 +0300
Message-Id: <20220426122448.38997-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com>
References: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com>
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
index 47fb4d6d4557..f584a6a0c5e3 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -390,6 +390,31 @@ descriptors once the device is released.
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

