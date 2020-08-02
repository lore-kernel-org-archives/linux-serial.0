Return-Path: <SRS0=oHof=BM=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51505C433E0
	for <linux-serial@archiver.kernel.org>; Sun,  2 Aug 2020 11:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B1C5207DF
	for <linux-serial@archiver.kernel.org>; Sun,  2 Aug 2020 11:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgHBLQQ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 2 Aug 2020 07:16:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:12504 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728270AbgHBLQP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 2 Aug 2020 07:16:15 -0400
IronPort-SDR: beACZg5nxfeeWe/VVPqYq+OykIu8tHieJFdrlYRJ+tHHDqCPwdqHH5Arg9ctJ6ePqrfyaaLcPT
 vAGxaL7Fhmbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9700"; a="139947866"
X-IronPort-AV: E=Sophos;i="5.75,426,1589266800"; 
   d="scan'208";a="139947866"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 04:16:15 -0700
IronPort-SDR: MfwIlbRFlUXFxZhRFDziFgPRIdyfLTz7haxslzJnGUrAuMDyW0+VMyW2KMc/DSWY1eWeKYzK8X
 OFnp6viokavw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,426,1589266800"; 
   d="scan'208";a="466156955"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 02 Aug 2020 04:16:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 40CDA130; Sun,  2 Aug 2020 14:16:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1] Revert "serial: 8250: Let serial core initialise spin lock"
Date:   Sun,  2 Aug 2020 14:16:12 +0300
Message-Id: <20200802111612.36189-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 679193b7baf8d88e41cbeb397ca17f797654947d.

It appears that in QEmu the lock has been initialised differently
(it wasn't obvious on real hardware during testing). Let's
revert the change until the better approach will be developed.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index b2d18189d3d9..09475695effd 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3194,6 +3194,7 @@ void serial8250_init_port(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
 
+	spin_lock_init(&port->lock);
 	port->ops = &serial8250_pops;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
-- 
2.27.0

