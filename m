Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8C7C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jun 2022 21:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiF1VpK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jun 2022 17:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiF1VpK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jun 2022 17:45:10 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974861F2C7;
        Tue, 28 Jun 2022 14:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656452709; x=1687988709;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oci42jBjowKb2PtIPS0q3kH3KK7UDnCP2KqGOPaNJL0=;
  b=fVMjOSgXeO8tQIOaJ9t8WGIXjeaq8XwCAKv33athvDOgYP8flgpA26X9
   rARveAt8oEkKoZR7Q5ioyCqICPbLC4HrFoh5kZbFK3skSFr58qlSorZfW
   6BpiRtDCKhIf4juIG5n3/x656L6dT5AluLmc6NtkjPgSagfIoFINCDUHz
   SjgzZWjYzTP2o/kxlP8s7X2JUYiOvDYaw2CGf8A7KtMlHil36xqU+shrI
   VmKadoPWHK5z024Rlky7fLGrzoc/y4bZK9Rbag1pYVe80Y2RuMsZRLJoX
   FAz9vaeagGCGSiMFC5fNTyGrNu3KofRRhJ5+88mAkci/BJsuNaJQctCMt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="345849910"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="345849910"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 14:45:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="732914865"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jun 2022 14:45:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 589A6CE; Wed, 29 Jun 2022 00:45:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_dw: Drop PM ifdeffery
Date:   Wed, 29 Jun 2022 00:45:11 +0300
Message-Id: <20220628214511.37373-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Drop CONFIG_PM and CONFIG_PM_SLEEP ifdeffery while converting dw8250_pm_ops
to use new PM macros.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f71428c85562..adcc869352b1 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -691,7 +691,6 @@ static int dw8250_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int dw8250_suspend(struct device *dev)
 {
 	struct dw8250_data *data = dev_get_drvdata(dev);
@@ -709,9 +708,7 @@ static int dw8250_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PM
 static int dw8250_runtime_suspend(struct device *dev)
 {
 	struct dw8250_data *data = dev_get_drvdata(dev);
@@ -733,11 +730,10 @@ static int dw8250_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops dw8250_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dw8250_suspend, dw8250_resume)
-	SET_RUNTIME_PM_OPS(dw8250_runtime_suspend, dw8250_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(dw8250_suspend, dw8250_resume)
+	RUNTIME_PM_OPS(dw8250_runtime_suspend, dw8250_runtime_resume, NULL)
 };
 
 static const struct dw8250_platform_data dw8250_dw_apb = {
-- 
2.35.1

