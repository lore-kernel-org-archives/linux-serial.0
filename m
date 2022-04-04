Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E58C433EF
	for <linux-serial@archiver.kernel.org>; Mon,  4 Apr 2022 08:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237817AbiDDIcJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Apr 2022 04:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbiDDIcE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Apr 2022 04:32:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411A820F57
        for <linux-serial@vger.kernel.org>; Mon,  4 Apr 2022 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649061009; x=1680597009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jjjQqIuN0yiQ90X0T0tHHZtNLdFkRX4uHBf0A3DdG+8=;
  b=G1iugGTe0mHF9GIcQM7TuVFIb+YxmIrueMXD75ZKtzlrX5etHG8Iauyw
   N3zYFiALDA74PHJU+PrbbH6ZKdhXaba1CeszppG3us2+mZ4k6TSxfCK+S
   HNaxydu+DvQzF8gFykmK08f7f+4iMELIxkBIB1cXa1gv2QCGVyP1eSusC
   GW9vxh/0Uo2rzKY2+pVPQAghxmWfiHTyo+4ahGrDm9mCtdnmhkk1j4wB+
   VVF/lC0EIjlmzEo4WavOc/zQifg46hvFDkA9b5TZnx1KFAN+2bZqkwM3C
   stxFNag0/W4JFtZC7reR+uHzL2Y5xfXVfC8lud+caURL2MOSnv/2pth20
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="258046471"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="258046471"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 01:30:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="569293485"
Received: from rhamza-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.211.126])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 01:30:05 -0700
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
Subject: [PATCH v2 06/12] ACPI / property: Document RS485 _DSD properties
Date:   Mon,  4 Apr 2022 11:29:06 +0300
Message-Id: <20220404082912.6885-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404082912.6885-1-ilpo.jarvinen@linux.intel.com>
References: <20220404082912.6885-1-ilpo.jarvinen@linux.intel.com>
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

