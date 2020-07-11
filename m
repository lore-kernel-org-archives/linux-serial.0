Return-Path: <SRS0=puAX=AW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7940C433E4
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jul 2020 13:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EDAE20786
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jul 2020 13:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgGKNxv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Jul 2020 09:53:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:33446 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgGKNxu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Jul 2020 09:53:50 -0400
IronPort-SDR: DZ93Gdt5nrj5ckn5LH3QPEF7TMhhPBhqlF91MKVAvxM9vKL4hBMa1STurTJ88nIfRdhXKX3dVr
 6c6ic3vnePhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9679"; a="213252866"
X-IronPort-AV: E=Sophos;i="5.75,339,1589266800"; 
   d="scan'208";a="213252866"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2020 06:53:49 -0700
IronPort-SDR: SQapNdvRdaGWjQJWp+ZzIwgtoez+KFCrTT+1w65x/ilQnADjwXvXuENzlapvdNtuYnl0vdCE/D
 wWNdhxT+RnCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,339,1589266800"; 
   d="scan'208";a="298709100"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 11 Jul 2020 06:53:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9497C8D; Sat, 11 Jul 2020 16:53:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/5] Revert "serial: amba-pl011: Make sure we initialize the port.lock spinlock"
Date:   Sat, 11 Jul 2020 16:53:43 +0300
Message-Id: <20200711135346.71171-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200711135346.71171-1-andriy.shevchenko@linux.intel.com>
References: <20200711135346.71171-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 8508f4cba308f785b2fd4b8c38849c117b407297.

There has been a quick fix against uninitialised lock revealed by
the commit f743061a85f5 ("serial: core: Initialise spin lock before use
in uart_configure_port()"). Since we have now better fix in serial core,
this may be safely reverted.

Fixes: 8508f4cba308 ("serial: amba-pl011: Make sure we initialize the port.lock spinlock")
Depends-on: f743061a85f5 ("serial: core: Initialise spin lock before use in uart_configure_port()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/amba-pl011.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8efd7c2a34fe..c010f639298d 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2607,7 +2607,6 @@ static int pl011_setup_port(struct device *dev, struct uart_amba_port *uap,
 	uap->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_AMBA_PL011_CONSOLE);
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = index;
-	spin_lock_init(&uap->port.lock);
 
 	amba_ports[index] = uap;
 
-- 
2.27.0

