Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6885C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 28 Apr 2022 17:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiD1RPT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Apr 2022 13:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiD1RPR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Apr 2022 13:15:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEFF5B3E7
        for <linux-serial@vger.kernel.org>; Thu, 28 Apr 2022 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651165922; x=1682701922;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wpZbnPV9abKfccwHx3DMNFeHZWjU6LxMajzwZ/GZAP0=;
  b=d/DkA0Cf+bbEXhZ9K6vo+LGgL3SZyXzMyMvwaWAIBVgyuAB7d3oGd3Ye
   p6GfBkXdUBU+CVb4iQ5xZEfLAMEK8Gh95S8ptaWd3INqy51kwzRuPCojE
   Z5JGIWVqi1oeVdLaIBiiVwr2FrFIuvwVuaydTuyaM5+5a2caNXVmwbwpC
   HX7rf0gzqdclXs5RVvKouSibrUjyhBC3tOpOza+UAy732IhLqmr0lfKgi
   2mLC33CyoWfB4n69Nl6tDhHCw5mWxuTtP+XnjkH9DIWJfV0sNDfGuno1+
   sSHh5lXzGEqjQ7VtGrxr9ww18ZLYR128F7XOtVkjm2dhVPaaik2V2j7vt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="248289228"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="248289228"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 10:12:02 -0700
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="581489676"
Received: from yawentax-mobl.ger.corp.intel.com ([10.249.32.101])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 10:12:00 -0700
Date:   Thu, 28 Apr 2022 20:11:56 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Nuno_Gon=E7alves?= <nunojpg@gmail.com>
cc:     linux-serial <linux-serial@vger.kernel.org>
Subject: [RFC PATCH] serial: Don't assume uart_ops .throttle is always set
Message-ID: <62859dbd-7ced-34f-55c-ce1b5f6625d@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-625256346-1651165921=:1945"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-625256346-1651165921=:1945
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

uart_throttle() assumes that a driver provides a throttle function in
uart_ops. But not all drivers do and there seems to nothing in
serial_core that would set it either. Thus, check it before calling.

Reported-by: Nuno Gonçalves <nunojpg@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
 drivers/tty/serial/serial_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6a8963caf954..18c9d46e0b85 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -697,7 +697,8 @@ static void uart_throttle(struct tty_struct *tty)
 		mask |= UPSTAT_AUTORTS;
 
 	if (port->status & mask) {
-		port->ops->throttle(port);
+		if (port->ops->throttle)
+			port->ops->throttle(port);
 		mask &= ~port->status;
 	}
 

-- 
tg: (19317433057d..) serial/fix-uart_throttle (depends on: tty-linus)
--8323329-625256346-1651165921=:1945--
