Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338B3C4332F
	for <linux-serial@archiver.kernel.org>; Tue, 15 Feb 2022 10:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiBOKLJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Feb 2022 05:11:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbiBOKLI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Feb 2022 05:11:08 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE02B8878B;
        Tue, 15 Feb 2022 02:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644919858; x=1676455858;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uG08l9hBxf1bSgGr4JRqhbyWvg1cSLzKkQenbVt3/lA=;
  b=ScKpKYyhUl73fipVaSo1vsdSP0VLPNma4ny+X4gbyOhJaSyBkG1yaxbM
   f7pAzCeAGrAAOR3G2MkJbH2Vdl0/AZWIsbh4GX+H+0omfqjbbqPDYShiY
   SAhhR3jxny9grqkvwIIomVTUi0Er9tS86N5UOMEkfQm0ULEI/DLSHn225
   l+yDQ6C4NSDvloJSaAgCOP6uOz4hYsl6egoDWwBZniq7tNfTmFChEv92Z
   mNY0WT5iR/w0XVukYyCRkSgDscQcxUBlne79lzW2qJO0qDcnen0MhKEu3
   3AwjtdyVkwP/uXmLuDSnBbidxPfkHseWPgpxAd9pn8mhomcCo1TqnM6Zs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250521554"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="250521554"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 02:10:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="496988974"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2022 02:10:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8420D15B; Tue, 15 Feb 2022 12:11:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_mid: Remove unneeded test for ->setup() presence
Date:   Tue, 15 Feb 2022 12:11:11 +0200
Message-Id: <20220215101111.47250-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

All supported platforms by this driver require ->setup() and ->exit().
Remove unneeded test for ->setup() presence.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_mid.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index e6c1791609dd..5616fc0f7403 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -322,11 +322,9 @@ static int mid8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!uart.port.membase)
 		return -ENOMEM;
 
-	if (mid->board->setup) {
-		ret = mid->board->setup(mid, &uart.port);
-		if (ret)
-			return ret;
-	}
+	ret = mid->board->setup(mid, &uart.port);
+	if (ret)
+		return ret;
 
 	ret = mid8250_dma_setup(mid, &uart);
 	if (ret)
-- 
2.34.1

