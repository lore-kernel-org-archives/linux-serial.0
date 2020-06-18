Return-Path: <SRS0=rTT/=77=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6C3C433E2
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA486208C7
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbgFRQsC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:48:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:18729 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732051AbgFRQr5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Jun 2020 12:47:57 -0400
IronPort-SDR: NihOJyzJSSWwQqE9pfhYyto+VpsAtx91s0MPpC0ZrWVF/L3UOAlRrbsWo54dn3Ik2gzkNjrzyG
 Gcj0V1O17AxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="142595285"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="142595285"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 09:47:56 -0700
IronPort-SDR: VM/QjTvVaS2DLSxAyQC9xNUoyUYCBTMBcMUQIxWhKTtiWnep2jQqcvBz2s63NB+v/1TmNISxFg
 eCkoN0itapMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="309171307"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2020 09:47:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C029915C; Thu, 18 Jun 2020 19:47:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v1 2/6] serial: sunsab: Return proper error code from console ->setup() hook
Date:   Thu, 18 Jun 2020 19:47:47 +0300
Message-Id: <20200618164751.56828-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
References: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

For unifying console ->setup() handling, which is pure documented,
return error code, rather than non-zero arbitrary number.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 drivers/tty/serial/sunsab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 1eb703c980e0..bab551f46963 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -886,7 +886,7 @@ static int sunsab_console_setup(struct console *con, char *options)
 	 * though...
 	 */
 	if (up->port.type != PORT_SUNSAB)
-		return -1;
+		return -EINVAL;
 
 	printk("Console: ttyS%d (SAB82532)\n",
 	       (sunsab_reg.minor - 64) + con->index);
-- 
2.27.0

