Return-Path: <SRS0=+g8y=BK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8B5C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 31 Jul 2020 12:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A0921744
	for <linux-serial@archiver.kernel.org>; Fri, 31 Jul 2020 12:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733026AbgGaMhg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:37:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:17933 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732953AbgGaMhg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 Jul 2020 08:37:36 -0400
IronPort-SDR: JRVo9lTe7x9IFLqUK5CxDKbT/LLpTw9OvX86vINWvKSSKNr+BXEpx4YjxBShjUkjwxsGf3SMBY
 TClr2ZdSpoIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="149592424"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="149592424"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 05:37:36 -0700
IronPort-SDR: s7qMr1kD8/pkgNL5ncz7iangkaXExRBKL5NbWYJyP/Ut+TEQWv4G5c+l05L1WLxtFL6BxYLG9G
 WznafSv32O9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="274496026"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jul 2020 05:37:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4716621D; Fri, 31 Jul 2020 15:37:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] serial: 8250: Let serial core initialise spin lock
Date:   Fri, 31 Jul 2020 15:37:32 +0300
Message-Id: <20200731123733.22754-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since the serial core handles spin lock initialisation,
let the driver rely on it.

Depends-on: f743061a85f5 ("serial: core: Initialise spin lock before use in uart_configure_port()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 09475695effd..b2d18189d3d9 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3194,7 +3194,6 @@ void serial8250_init_port(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
 
-	spin_lock_init(&port->lock);
 	port->ops = &serial8250_pops;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
-- 
2.27.0

