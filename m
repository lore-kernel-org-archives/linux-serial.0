Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B57C32771
	for <linux-serial@archiver.kernel.org>; Fri, 19 Aug 2022 11:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348044AbiHSLAR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Aug 2022 07:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348011AbiHSLAQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Aug 2022 07:00:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E58DEF02D
        for <linux-serial@vger.kernel.org>; Fri, 19 Aug 2022 04:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660906815; x=1692442815;
  h=date:from:to:subject:message-id:mime-version;
  bh=43SZza9DYD50MUBrNa7ZqRFA+AJNeu9o9z5ocn1FjwU=;
  b=a7Odjm56jPZPPxtxFbJXEk0df8nosrwQ0VXPXjbvzbg2Elyjntk5kkZt
   /NOe0s/nFKwvvnr3tX6NVyRf8DeClwfSlZmoE1nZjs37axRZzEt7xf5XR
   X3xqe4qFEtJhGsLyL8v7v51991qtDPPbfylyLklfXWDWLcVUjWkzR+XQo
   NHamZ6USva1n5iuCSlCsVakM+iVBO2Wbwg0GzQ365Wnk3nJlNtTKLTwZ8
   tXcyMxRac2wrU+o6mLFXm60+8HbT6YzdMjVPmeRnCSY+CyQYDbcHiov43
   4JDeUbEB0nvVettWHN4SGx0jVwuFKY3UwrAxZ0ghloXroULLNkLP9wO7v
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="356974396"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="356974396"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 04:00:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="668541908"
Received: from dadamczy-mobl.ger.corp.intel.com ([10.252.50.136])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 04:00:12 -0700
Date:   Fri, 19 Aug 2022 14:00:02 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] serial: 8250: Clear dma tx_err unconditionally
Message-ID: <3b885e7f-1372-3aa9-febd-34566ba25e3d@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-908504166-1660906814=:1591"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-908504166-1660906814=:1591
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

No need to check non-zeroness first and then clear. Just set to zero
unconditionally.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
 drivers/tty/serial/8250/8250_dma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index a8dba4a0a8fb..d99020fd3427 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -107,8 +107,7 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 
 	dma_async_issue_pending(dma->txchan);
 	serial8250_clear_THRI(p);
-	if (dma->tx_err)
-		dma->tx_err = 0;
+	dma->tx_err = 0;
 
 	return 0;
 err:

-- 
tg: (568035b01cfb..) 8250dma/tx_err-clear-unconditionally (depends on: tty-next)
--8323329-908504166-1660906814=:1591--
