Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D016EC76195
	for <linux-serial@archiver.kernel.org>; Mon, 20 Mar 2023 13:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjCTNut (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Mar 2023 09:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjCTNut (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Mar 2023 09:50:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904B36A4C;
        Mon, 20 Mar 2023 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679320232; x=1710856232;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n6T2JVYJbSsy1HsnBbxLghmE7GwndGUVZ+b4A2IrnVM=;
  b=XR1i4Mno3aPTrqtzIDKJDTzTawIZw3hmP+gkWsy5DmIWxLOHM8G2dLXQ
   sxaYjnWKLw5cUvJVgAuiBQwrYl61+yQMqkzBm9cBTASZJ+dkiy85DYhFR
   OHT0zrlQMjdze49785VxPu3ky7M26gYdZvmLyoRUXfVQqBw3eXOyy6VCq
   Ejuh3venC+xBCWcdC9THJecsHCNrsKiQJy1mxQKnGkiXaFWuBpgw8kzc6
   CHumJH0MLYDJy172Po4wJD+aJmW/p9x16p2QHaRZgVSx0ibDpfeJpbBqU
   YS+MiHW8/xavv6L6EHYnrQKx2C3YH5ZvF/VXxJ4ff5qv9AFi4inD5COfa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="336171324"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="336171324"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 06:50:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="674391698"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="674391698"
Received: from mbouhaou-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.61.151])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 06:50:15 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Timur Tabi <timur@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/2] serial: ucc_uart: Use uart_circ_empty()
Date:   Mon, 20 Mar 2023 15:50:08 +0200
Message-Id: <20230320135009.47170-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use uart_circ_empty() rather than open coding it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/ucc_uart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 32c7a5b43f8e..e6bd1256a4e7 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -366,15 +366,14 @@ static int qe_uart_tx_pump(struct uart_qe_port *qe_port)
 	/* Pick next descriptor and fill from buffer */
 	bdp = qe_port->tx_cur;
 
-	while (!(ioread16be(&bdp->status) & BD_SC_READY) &&
-	       (xmit->tail != xmit->head)) {
+	while (!(ioread16be(&bdp->status) & BD_SC_READY) && !uart_circ_empty(xmit)) {
 		count = 0;
 		p = qe2cpu_addr(be32_to_cpu(bdp->buf), qe_port);
 		while (count < qe_port->tx_fifosize) {
 			*p++ = xmit->buf[xmit->tail];
 			uart_xmit_advance(port, 1);
 			count++;
-			if (xmit->head == xmit->tail)
+			if (uart_circ_empty(xmit))
 				break;
 		}
 
-- 
2.30.2

