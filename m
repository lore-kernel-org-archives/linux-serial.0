Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B045EC32789
	for <linux-serial@archiver.kernel.org>; Tue, 23 Aug 2022 16:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245707AbiHWQvM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242640AbiHWQuk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Aug 2022 12:50:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E95EC653A;
        Tue, 23 Aug 2022 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661264352; x=1692800352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sjw/9n6LGV7L7tg+oFNPeCQg72JcrotNAbu80wb6l8U=;
  b=Ty5qW6HCN9sErbwcbKYRVIwjjA1abxKFIilCIMmF4uv8+2dRtLKO+181
   fO+okEEYbq2g7V4Cy6kMl9QL4a47WDcwXkb51jYctCRpP7AuId97A29ny
   1uDLQzVdUu4m3hbD/+RhgQwzej7ZIhf6K7w/GpNJ2GNRD+3hxtcK6f+0A
   qk+PL2W4ywQxtmqKiK5l8yvyh0X8xCX8gdMBTQsWfi4TSU8EiP0daJFsw
   g8HpqYhZdoYRc+duDjfAY786M+q9c83WqVNSbwefTKf3cEwRtr+fPjdr0
   xubBHGbnzFFpFp3t9+w4sHvjE0fxwFn38qx8BTJ9q6wW/D13r+NOWzPgE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="276723938"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="276723938"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:18:53 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="638671433"
Received: from kimtingt-mobl.gar.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.42.4])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:18:51 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/3] serial: sh-sci: tail is already on valid range
Date:   Tue, 23 Aug 2022 17:18:38 +0300
Message-Id: <20220823141839.165244-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220823141839.165244-1-ilpo.jarvinen@linux.intel.com>
References: <20220823141839.165244-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is no need to and tail with UART_XMIT_SIZE - 1 because tail is
already on valid range.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6d2f5a08ff1f..2ddcd7eec71e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1407,7 +1407,7 @@ static void sci_dma_tx_work_fn(struct work_struct *work)
 	spin_lock_irq(&port->lock);
 	head = xmit->head;
 	tail = xmit->tail;
-	buf = s->tx_dma_addr + (tail & (UART_XMIT_SIZE - 1));
+	buf = s->tx_dma_addr + tail;
 	s->tx_dma_len = CIRC_CNT_TO_END(head, tail, UART_XMIT_SIZE);
 	if (!s->tx_dma_len) {
 		/* Transmit buffer has been flushed */
-- 
2.30.2

