Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EDEC433EF
	for <linux-serial@archiver.kernel.org>; Mon, 11 Apr 2022 08:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343867AbiDKIg1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Apr 2022 04:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343863AbiDKIgQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Apr 2022 04:36:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D650313D05
        for <linux-serial@vger.kernel.org>; Mon, 11 Apr 2022 01:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649666041; x=1681202041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jjjQqIuN0yiQ90X0T0tHHZtNLdFkRX4uHBf0A3DdG+8=;
  b=m5Oj74hF4af1fQ96xcK0Jj5adExFlElIfKqYv9cJTHzz3owt0UhnA/jl
   75H9yCE730nUCjfAKXi5byBWMNm3Il6XxQvKbj2YIXSizR6Na0r1zb2bu
   QCi8YyPG6WBJ7Il1gKKBx1nR0XYdKyS9dK9T6Ynjq8aW9cR9RsWw/yHRW
   8wv074Wa2mDGFmJUetGeQM43tlCMGumyBWsInBgCeTdq0rJ2akpU4LGyq
   j6YPslV7AHLs5MSA+IOYMVBWar6HDOE5fV3hihHQkp2rMsnOhO1Jpg3py
   4lsA+KsbEvVckl2GB+WiqIF2J1KJrizDZQEBhQxt+kPDSxvSQniM4xB96
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="322511587"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="322511587"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:34:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572028702"
Received: from azahoner-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:33:57 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 06/12] ACPI / property: Document RS485 _DSD properties
Date:   Mon, 11 Apr 2022 11:33:15 +0300
Message-Id: <20220411083321.9131-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Document RS485 related properties returned from ACPI _DSD
as device properties.

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

