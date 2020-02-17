Return-Path: <SRS0=lWnk=4F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024DFC35254
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 11:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E2120836
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 11:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgBQLkV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:40:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:11231 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728504AbgBQLkU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Feb 2020 06:40:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 03:40:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; 
   d="scan'208";a="407753477"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 17 Feb 2020 03:40:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C55115AD; Mon, 17 Feb 2020 13:40:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/6] serial: 8250_port: Use dev_*() instead of pr_*()
Date:   Mon, 17 Feb 2020 13:40:14 +0200
Message-Id: <20200217114016.49856-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
References: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert pr_*() calls to dev_*() ones. We have a port, we should use it.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 4f5d4cce4c8e..f398f162a1fd 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1318,8 +1318,8 @@ static void autoconfig(struct uart_8250_port *up)
 		fintek_8250_probe(up);
 
 	if (up->capabilities != old_capabilities) {
-		pr_warn("%s: detected caps %08x should be %08x\n",
-			port->name, old_capabilities, up->capabilities);
+		dev_warn(port->dev, "detected caps %08x should be %08x\n",
+			 old_capabilities, up->capabilities);
 	}
 out:
 	DEBUG_AUTOCONF("iir=%d ", scratch);
@@ -1683,7 +1683,7 @@ void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr)
 		lsr &= port->read_status_mask;
 
 		if (lsr & UART_LSR_BI) {
-			pr_debug("%s: handling break\n", __func__);
+			dev_dbg(port->dev, "handling break\n");
 			flag = TTY_BREAK;
 		} else if (lsr & UART_LSR_PE)
 			flag = TTY_PARITY;
@@ -2134,7 +2134,7 @@ int serial8250_do_startup(struct uart_port *port)
 	 */
 	if (!(port->flags & UPF_BUGGY_UART) &&
 	    (serial_port_in(port, UART_LSR) == 0xff)) {
-		pr_info_ratelimited("%s: LSR safety check engaged!\n", port->name);
+		dev_info_ratelimited(port->dev, "LSR safety check engaged!\n");
 		retval = -ENODEV;
 		goto out;
 	}
@@ -2166,8 +2166,7 @@ int serial8250_do_startup(struct uart_port *port)
 	     (port->type == PORT_ALTR_16550_F128)) && (port->fifosize > 1)) {
 		/* Bounds checking of TX threshold (valid 0 to fifosize-2) */
 		if ((up->tx_loadsz < 2) || (up->tx_loadsz > port->fifosize)) {
-			pr_err("%s TX FIFO Threshold errors, skipping\n",
-			       port->name);
+			dev_err(port->dev, "TX FIFO Threshold errors, skipping\n");
 		} else {
 			serial_port_out(port, UART_ALTR_AFR,
 					UART_ALTR_EN_TXFIFO_LW);
@@ -2268,8 +2267,7 @@ int serial8250_do_startup(struct uart_port *port)
 	if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
 		if (!(up->bugs & UART_BUG_TXEN)) {
 			up->bugs |= UART_BUG_TXEN;
-			pr_debug("%s - enabling bad tx status workarounds\n",
-				 port->name);
+			dev_dbg(port->dev, "enabling bad tx status workarounds\n");
 		}
 	} else {
 		up->bugs &= ~UART_BUG_TXEN;
@@ -2296,8 +2294,7 @@ int serial8250_do_startup(struct uart_port *port)
 	if (up->dma) {
 		retval = serial8250_request_dma(up);
 		if (retval) {
-			pr_warn_ratelimited("%s - failed to request DMA\n",
-					    port->name);
+			dev_warn_ratelimited(port->dev, "failed to request DMA\n");
 			up->dma = NULL;
 		}
 	}
-- 
2.25.0

