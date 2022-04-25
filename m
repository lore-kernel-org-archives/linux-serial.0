Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75ACC4332F
	for <linux-serial@archiver.kernel.org>; Mon, 25 Apr 2022 14:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbiDYOhw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Apr 2022 10:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242554AbiDYOhr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Apr 2022 10:37:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2593C119EC2
        for <linux-serial@vger.kernel.org>; Mon, 25 Apr 2022 07:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650897284; x=1682433284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ahf6luvamXfjWySFVgd1FO4nQOJsxLim3rn4ggOMvVA=;
  b=g2UMjzUke58ekocNJG8UiMEI5weEqOJvHN0siltU4BF8Ro59ShJdpv5J
   A7+3ALVitjXVA37NZqPjVkwtTAbT6JwNtlZs2xKyMZoo6ZHbC6hftnnaH
   KDVOkvvjp0FPur6Q2GzuKOyhe4y56bv37vYk3TARjFqCaC0wlblHomfwl
   JKUvkfm4ME/sypHRgIesgFCsnIH81A1GYj2QkpeHOu7yANO5dpIat/wsq
   Fqdcqlj26vtM7IFV/Vg0CC7n8GL6S0bxDLobRfyS/cveOrjflyTvkgVrP
   Fyj2Jx81IFved16sV6LxIxRt1X1OEb9fCgm9w9KGlaKLzB+KLpiIPnMsL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="325752059"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="325752059"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:34:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="579315628"
Received: from lpuglia-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.217.93])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:34:38 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vicente Bergas <vicencb@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 02/13] serial: 8250: use THRE & __stop_tx also with DMA
Date:   Mon, 25 Apr 2022 17:33:59 +0300
Message-Id: <20220425143410.12703-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
References: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

8250 DMA tx complete path lacks calls to normal 8250 stop handling. It
does not use THRE to detect true completion of the tx and also doesn't
call __stop_tx. This leads to problems with em485 that needs to handle
RTS timing.

Instead of handling tx stop internally within 8250 dma code, enable
THRE when tx'able data runs out and tweak serial8250_handle_irq to call
only __stop_tx when uart is using DMA.

It also seems bit early to call serial8250_rpm_put_tx from there while
tx is still underway(?).

Tested-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dma.c  | 3 +--
 drivers/tty/serial/8250/8250_port.c | 9 ++++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 890fa7ddaa7f..e1625a73ce57 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -34,7 +34,7 @@ static void __dma_tx_complete(void *param)
 		uart_write_wakeup(&p->port);
 
 	ret = serial8250_tx_dma(p);
-	if (ret)
+	if (ret || !dma->tx_running)
 		serial8250_set_THRI(p);
 
 	spin_unlock_irqrestore(&p->port.lock, flags);
@@ -71,7 +71,6 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 
 	if (uart_tx_stopped(&p->port) || uart_circ_empty(xmit)) {
 		/* We have been called from __dma_tx_complete() */
-		serial8250_rpm_put_tx(p);
 		return 0;
 	}
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d30a6c1c4c20..40b62126c1ca 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1950,9 +1950,12 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 			status = serial8250_rx_chars(up, status);
 	}
 	serial8250_modem_status(up);
-	if ((!up->dma || up->dma->tx_err) && (status & UART_LSR_THRE) &&
-		(up->ier & UART_IER_THRI))
-		serial8250_tx_chars(up);
+	if ((status & UART_LSR_THRE) && (up->ier & UART_IER_THRI)) {
+		if (!up->dma || up->dma->tx_err)
+			serial8250_tx_chars(up);
+		else
+			__stop_tx(up);
+	}
 
 	uart_unlock_and_check_sysrq_irqrestore(port, flags);
 
-- 
2.30.2

