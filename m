Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49971C32772
	for <linux-serial@archiver.kernel.org>; Tue, 23 Aug 2022 16:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245498AbiHWQvh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245569AbiHWQvB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Aug 2022 12:51:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0EAC6532;
        Tue, 23 Aug 2022 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661264351; x=1692800351;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bBcVzFadHIYWxzP3mYG1Uq4WgLVm5QO4dD0QlnCoTWI=;
  b=gjX6/dlwBlYvoaZ8OgFeGw14LBWLxFucT10ZgUrFWdCZHP9r/6f3838G
   mocqzEIer5wnhqlYj2GHilz9PFYTKuQ8m/iSKK4Is7FwAk67MWCGlyFGl
   rEdCc8DWKZs5o9VSDjC+F3Olxh7fIMlxS1SNipvS/VbaIb7x9feet0dnq
   ptZ4uXbd4wDy5avQL3JYbcI/U60giSDB6DBOQ8/Bpjyl5uUUGLRLxDbXW
   1soKjMQJknrFqxX/EcwZ97e0V9mq/5uCOU+0HxKkVU+LVPvfpy5PYFiqX
   d96u0ut1Gm1bf26g/TpZs0n+bJDC3UTX1q6q5zjVnSxzV69DPmZrWKP3d
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="276723925"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="276723925"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:18:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="638671421"
Received: from kimtingt-mobl.gar.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.42.4])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:18:48 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/3] serial: sh-sci: CIRC_CNT_TO_END() is enough
Date:   Tue, 23 Aug 2022 17:18:37 +0300
Message-Id: <20220823141839.165244-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Testing also CIRC_CNT() with CIRC_CNT_TO_END() is unnecessary because
to latter alone covers all necessary cases.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/sh-sci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 0075a1420005..6d2f5a08ff1f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1408,9 +1408,7 @@ static void sci_dma_tx_work_fn(struct work_struct *work)
 	head = xmit->head;
 	tail = xmit->tail;
 	buf = s->tx_dma_addr + (tail & (UART_XMIT_SIZE - 1));
-	s->tx_dma_len = min_t(unsigned int,
-		CIRC_CNT(head, tail, UART_XMIT_SIZE),
-		CIRC_CNT_TO_END(head, tail, UART_XMIT_SIZE));
+	s->tx_dma_len = CIRC_CNT_TO_END(head, tail, UART_XMIT_SIZE);
 	if (!s->tx_dma_len) {
 		/* Transmit buffer has been flushed */
 		spin_unlock_irq(&port->lock);
-- 
2.30.2

