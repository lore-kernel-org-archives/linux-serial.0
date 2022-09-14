Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819BDC6FA82
	for <linux-serial@archiver.kernel.org>; Wed, 14 Sep 2022 16:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiINQgn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Sep 2022 12:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiINQgl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Sep 2022 12:36:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C0C5AA37;
        Wed, 14 Sep 2022 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663173400; x=1694709400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4U1YjzC+0xLrJidlsZUbIKBB4tLP05miuKWoZOpNP18=;
  b=aOAUxVo34n3xwKoCnCTZjAoNRn+/ul8p/h3orC4a3O/RCOmbZOmcx3/0
   spiCg5flG0sdKYlChxvOSQ0Pgk9mKGuA9lVu5gw0aIn+Q90nfZI8VR1s9
   NRJRLgtvDRvVOcoiQZTtkPG/WytNFK00lTINrnSrn/Wl8ZdEutjVpbxOO
   FE6zmhZa4K6T5xZnuxtwCVUF09iOBcYjhsoEV+hFb+XjLaemBx5/4MMki
   5NUoN0SE7OAod9Ti8RKcj1J4AcyKAWh1100BZvOYuF+K+Ueq5d1iuCjgf
   OgBXIsNDvUQy15ju9lxj8gKGYoDh6GQuoa96eRZhwPFXTya02qrR9amMK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="278865135"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="278865135"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 09:36:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="568074886"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 14 Sep 2022 09:36:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D5871F7; Wed, 14 Sep 2022 19:36:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <damm+renesas@opensource.se>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] TODO: serdev: Replace poll loop by readx_poll_timeout() macro
Date:   Wed, 14 Sep 2022 19:36:40 +0300
Message-Id: <20220914163640.38003-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The readx_poll_timeout() consolidates the necessary code under
macro. Replace current code with it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/serdev.h | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/linux/serdev.h b/include/linux/serdev.h
index 66f624fc618c..69d9c3188065 100644
--- a/include/linux/serdev.h
+++ b/include/linux/serdev.h
@@ -7,9 +7,11 @@
 
 #include <linux/types.h>
 #include <linux/device.h>
+#include <linux/iopoll.h>
 #include <linux/uaccess.h>
 #include <linux/termios.h>
 #include <linux/delay.h>
+#include <vdso/time64.h>
 
 struct serdev_controller;
 struct serdev_device;
@@ -279,18 +281,10 @@ static inline bool serdev_device_get_cts(struct serdev_device *serdev)
 
 static inline int serdev_device_wait_for_cts(struct serdev_device *serdev, bool state, int timeout_ms)
 {
-	unsigned long timeout;
 	bool signal;
 
-	timeout = jiffies + msecs_to_jiffies(timeout_ms);
-	while (time_is_after_jiffies(timeout)) {
-		signal = serdev_device_get_cts(serdev);
-		if (signal == state)
-			return 0;
-		usleep_range(1000, 2000);
-	}
-
-	return -ETIMEDOUT;
+	return readx_poll_timeout(serdev_device_get_cts, serdev, signal, signal == state,
+				  2000, timeout_ms * USEC_PER_MSEC);
 }
 
 static inline int serdev_device_set_rts(struct serdev_device *serdev, bool enable)
-- 
2.35.1

