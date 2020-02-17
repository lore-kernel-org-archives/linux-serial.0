Return-Path: <SRS0=lWnk=4F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D377AC761A5
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 11:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7AA20836
	for <linux-serial@archiver.kernel.org>; Mon, 17 Feb 2020 11:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgBQLkW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:40:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:23322 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbgBQLkW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 Feb 2020 06:40:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 03:40:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; 
   d="scan'208";a="433769193"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 17 Feb 2020 03:40:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D3A23646; Mon, 17 Feb 2020 13:40:16 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 6/6] serial: 8250_port: Disable DMA operations for kernel console
Date:   Mon, 17 Feb 2020 13:40:16 +0200
Message-Id: <20200217114016.49856-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
References: <20200217114016.49856-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It would be too tricky and error prone to allow DMA operations on
kernel console.

One of the concern is when DMA is a separate device, for example on
Intel CherryTrail platforms, and might need special work around to be
functional, see the commit

  eebb3e8d8aaf ("ACPI / LPSS: override power state for LPSS DMA device")

for more information.

Another one is that kernel console is used in atomic context, e.g.
when printing crucial information to the user (Oops or crash),
and DMA may not serve due to power management complications
including non-atomic ACPI calls but not limited to it (see above).

Besides that, other concerns are described in the commit

  84b40e3b57ee ("serial: 8250: omap: Disable DMA for console UART")

done for OMAP UART and may be repeated here.

Disable any kind of DMA operations on kernel console due to above concerns.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index f8a85244a6f1..c1a49d671cdd 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2292,9 +2292,14 @@ int serial8250_do_startup(struct uart_port *port)
 	 * Request DMA channels for both RX and TX.
 	 */
 	if (up->dma) {
-		retval = serial8250_request_dma(up);
-		if (retval) {
-			dev_warn_ratelimited(port->dev, "failed to request DMA\n");
+		const char *msg = NULL;
+
+		if (uart_console(port))
+			msg = "forbid DMA for kernel console";
+		else if (serial8250_request_dma(up))
+			msg = "failed to request DMA";
+		if (msg) {
+			dev_warn_ratelimited(port->dev, "%s\n", msg);
 			up->dma = NULL;
 		}
 	}
-- 
2.25.0

