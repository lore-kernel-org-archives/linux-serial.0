From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 2/2] tty: serial: imx: don't reinit clock with enabled console
Date: Mon, 27 Aug 2012 09:36:52 +0200
Message-ID: <1346053012-25686-3-git-send-email-dirk.behme@de.bosch.com>
References: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp2-v.fe.bosch.de ([139.15.237.6]:59417 "EHLO
	smtp2-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab2H0HhE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Aug 2012 03:37:04 -0400
Received: from vsmta11.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 26265B0022D
	for <linux-serial@vger.kernel.org>; Mon, 27 Aug 2012 09:37:02 +0200 (CEST)
Received: from localhost (vsgw4.fe.internet.bosch.com [10.4.98.12])
	by vsmta11.fe.internet.bosch.com (Postfix) with SMTP id 1AC3943C0665
	for <linux-serial@vger.kernel.org>; Mon, 27 Aug 2012 09:37:02 +0200 (CEST)
In-Reply-To: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, Xinyu Chen <xinyu.chen@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>

From: Xinyu Chen <xinyu.chen@freescale.com>

Remove the imx_setup_ufcr() call on startup when CONSOLE enabled,
as this will cause clock reinit, and output garbage.

This patch is a port from Freescale's Android kernel.

Signed-off-by: Xinyu Chen <xinyu.chen@freescale.com>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
CC: Shawn Guo <shawn.guo@linaro.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 908178f..31ce414 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -695,7 +695,9 @@ static int imx_startup(struct uart_port *port)
 	int retval;
 	unsigned long flags, temp;
 
+#ifndef CONFIG_SERIAL_CORE_CONSOLE
 	imx_setup_ufcr(sport, 0);
+#endif
 
 	/* disable the DREN bit (Data Ready interrupt enable) before
 	 * requesting IRQs
-- 
1.7.0.4

