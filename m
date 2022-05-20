Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FBDC433F5
	for <linux-serial@archiver.kernel.org>; Fri, 20 May 2022 10:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344563AbiETKgF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 May 2022 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347431AbiETKfz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 May 2022 06:35:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951DF140BB
        for <linux-serial@vger.kernel.org>; Fri, 20 May 2022 03:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653042950; x=1684578950;
  h=date:from:to:subject:message-id:mime-version;
  bh=bPe9sGHqNAnrctGPDc2vHYf5sYS7m/kLHG+XhN4/9hI=;
  b=nLy5+p5SRIcO01jbfrlOFQSyB1trY9CaEqR6KeRSKiWbChT0jFl/b+tl
   13wFjSdoFhiL+k7ObOOrta4O7oIK0p2a4s7ilfxbWzvoAdK319ECcBuS0
   i0uruu/sMXDUKXHDwk9wi1J4TABQjHZudF+wY+OW5KzX1DoZsT4JBbQt8
   VKSX9rPPuxBNihFjTyrDLxpMIX2T8WHxOe2pBc6RfuJfRcUZ+KjuX029F
   7EC2cAJj9IHWuzm+17lyB6iEztb14AQxAVKFpQNRePgK6f7F2iAqa/pjz
   JaOOYnTW3E53yewjOvIq6qaijaHvLDhq+uGFnnPftdJdN73kF82XtPxaP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="297876306"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="297876306"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 03:35:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="570743769"
Received: from tklimek-mobl2.ger.corp.intel.com ([10.249.35.252])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 03:35:47 -0700
Date:   Fri, 20 May 2022 13:35:41 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] serial: 8250: Store to lsr_save_flags after lsr read
Message-ID: <f4d774be-1437-a550-8334-19d8722ab98c@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1504817008-1653042949=:1605"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1504817008-1653042949=:1605
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Not all LSR register flags are preserved across reads. Therefore, LSR
readers must store the non-preserved bits into lsr_save_flags.

This fix was initially mixed into feature commit f6f586102add ("serial:
8250: Handle UART without interrupt on TEMT using em485"). However,
that feature change had a flaw and it was reverted to make room for
simpler approach providing the same feature. The embedded fix got
reverted with the feature change.

Re-add the lsr_save_flags fix and properly mark it's a fix.

Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250")
Link: https://lore.kernel.org/all/1d6c31d-d194-9e6a-ddf9-5f29af829f3@linux.intel.com/T/#m1737eef986bd20cf19593e344cebd7b0244945fc
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
Since Uwe didn't follow up with this fix in an isolated patch, I'm sending 
it now so that it doesn't end up falling through cracks.

 drivers/tty/serial/8250/8250_port.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5591f18f2ea9..25f3dff9fe25 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1517,6 +1517,8 @@ static inline void __stop_tx(struct uart_8250_port *p)
 		unsigned char lsr = serial_in(p, UART_LSR);
 		u64 stop_delay = 0;
 
+		p->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+
 		if (!(lsr & UART_LSR_THRE))
 			return;
 		/*

-- 
tg: (4419da5d5d4b..) fix/lsr-save-flags (depends on: tty-next)
--8323329-1504817008-1653042949=:1605--
