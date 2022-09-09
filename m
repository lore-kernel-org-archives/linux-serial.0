Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F6DC6FA86
	for <linux-serial@archiver.kernel.org>; Fri,  9 Sep 2022 09:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiIIJK6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Sep 2022 05:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiIIJKz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Sep 2022 05:10:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007A912D548;
        Fri,  9 Sep 2022 02:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662714654; x=1694250654;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1t24DAZdaTeTQgh9a9FDeIongWZD4EJoGdOMahPOlbo=;
  b=k0TXLjzf1mOpxk2SjuNXeMj/GrHe7c2GLGTdCfizOmXWXGyh8BVlnJcZ
   4OJLBUGzt6a0XhuAHy8faEqQRArW4Amr1z1jZ2zW/5C5p/N900unNcXAh
   daFkro8tyvnqy+C1sn3ncbAsF5jegmxN65q9Dq6tsZLgb0+wUgnyfQGR/
   YdxCZXMOMr6R+2xrbL/0oq/sQobxJA1Acx7h/gG4wJPeERit3XAcSA7DX
   x46kuXksWiAGOEXqim/c7wEBsUeuVZLwM5YQ/dtOTb9CC/wPu7nNbBGMy
   bqYGHkxtyelCW9ltM4nHQtTwVC0xIRH36LfDpi4tqQFxTqM/Bif9TU99c
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="277822336"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="277822336"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 02:10:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="704338246"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Sep 2022 02:10:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 33843238; Fri,  9 Sep 2022 12:11:09 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: 8250_dma: Convert to use uart_xmit_advance()
Date:   Fri,  9 Sep 2022 12:11:02 +0300
Message-Id: <20220909091102.58941-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

uart_xmit_advance() provides a common way on how to advance
the Tx queue. Use it for the sake of unification and robustness.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index d99020fd3427..b85c82616e8c 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -26,9 +26,7 @@ static void __dma_tx_complete(void *param)
 
 	dma->tx_running = 0;
 
-	xmit->tail += dma->tx_size;
-	xmit->tail &= UART_XMIT_SIZE - 1;
-	p->port.icount.tx += dma->tx_size;
+	uart_xmit_advance(&p->port, dma->tx_size);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&p->port);
-- 
2.35.1

