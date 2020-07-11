Return-Path: <SRS0=puAX=AW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B71C433E1
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jul 2020 13:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C1FC2075F
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jul 2020 13:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgGKNxt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Jul 2020 09:53:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:36441 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgGKNxt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Jul 2020 09:53:49 -0400
IronPort-SDR: GnawwcHtC1TgJWDq5PVvVl17SpGyIcLD3SG5qb/SIBwfWDEUqtLkhmWH2D5heNeYMWL+wojSmj
 lQb4az+ZU6hw==
X-IronPort-AV: E=McAfee;i="6000,8403,9679"; a="166464613"
X-IronPort-AV: E=Sophos;i="5.75,339,1589266800"; 
   d="scan'208";a="166464613"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2020 06:53:49 -0700
IronPort-SDR: SCwpVn5r9IY/e75TDaU+i3pX06jDxRqlcKZie+P0Hn4csAZLPncwSFvE9DcVrc9YpJ4UiKmJ3j
 6zUMG3neIYMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,339,1589266800"; 
   d="scan'208";a="316886510"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2020 06:53:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 99AAC18E; Sat, 11 Jul 2020 16:53:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/5] Revert "tty: serial: add missing spin_lock_init for SiFive serial console"
Date:   Sat, 11 Jul 2020 16:53:44 +0300
Message-Id: <20200711135346.71171-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200711135346.71171-1-andriy.shevchenko@linux.intel.com>
References: <20200711135346.71171-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 17b4efdf4e4867079012a48ca10d965fe9d68822.

There has been a quick fix against uninitialised lock revealed by
the commit f743061a85f5 ("serial: core: Initialise spin lock before use
in uart_configure_port()"). Since we have now better fix in serial core,
this may be safely reverted.

Fixes: 17b4efdf4e48 ("tty: serial: add missing spin_lock_init for SiFive serial console")
Depends-on: f743061a85f5 ("serial: core: Initialise spin lock before use in uart_configure_port()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/sifive.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 0b5110dad051..13eadcb8aec4 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -883,7 +883,6 @@ console_initcall(sifive_console_init);
 
 static void __ssp_add_console_port(struct sifive_serial_port *ssp)
 {
-	spin_lock_init(&ssp->port.lock);
 	sifive_serial_console_ports[ssp->port.line] = ssp;
 }
 
-- 
2.27.0

