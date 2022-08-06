Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E5FC19F2D
	for <linux-serial@archiver.kernel.org>; Sat,  6 Aug 2022 22:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiHFW4k (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Aug 2022 18:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiHFW4j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Aug 2022 18:56:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48035DEB3;
        Sat,  6 Aug 2022 15:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659826597; x=1691362597;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eCpy/jCmexSjXdy925umbUAk4zxD4Zs5zd4Pp6Gcah4=;
  b=fr8HMpe1TyWiTibpNxoZDvydDehf9ZlE1gd2ommf0KijZ1Zd+x1IluJR
   KsNdyWkRVb8//sgXl2X5B1Sj6PqiYHD9JVNOY48IMWF0fwjjUloBHiuWX
   BidR3U5R8iDZQSNhjFzY1dGFZbCTvR9Sj1gGcRFC9Gp1v9yK1sggL3tx1
   zOo7h3Y8Ex96AeX8ftQueDe+LgEW8qtCgGMAUVBYDvl8Mrx/xe3oZWXl6
   zW2nApq8G15/J8k/SJECiNvIajrrVuEOp2J15GeXxufCsacazOfqQ4T/C
   bI50yhpkvr8M0TRW6Gd6biidYwGSVoHkdphtkxroLZ48ZZwDIkLk9/p5h
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="289153204"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="289153204"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 15:56:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="746224817"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Aug 2022 15:56:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B6266F7; Sun,  7 Aug 2022 01:56:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] serial: pic32_uart: Utilize uart_console_enabled()
Date:   Sun,  7 Aug 2022 01:56:42 +0300
Message-Id: <20220806225643.40897-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The serial core already provides a helper to check if the given port
is an enabled console. Utilize it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/pic32_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index f418f1de66b3..1562c2a48467 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -943,7 +943,7 @@ static int pic32_uart_probe(struct platform_device *pdev)
 	}
 
 #ifdef CONFIG_SERIAL_PIC32_CONSOLE
-	if (uart_console(port) && (pic32_console.flags & CON_ENABLED)) {
+	if (uart_console_enabled(port)) {
 		/* The peripheral clock has been enabled by console_setup,
 		 * so disable it till the port is used.
 		 */
-- 
2.35.1

