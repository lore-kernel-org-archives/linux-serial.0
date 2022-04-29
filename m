Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C874BC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 29 Apr 2022 11:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243200AbiD2MAj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Apr 2022 08:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbiD2MAi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Apr 2022 08:00:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667264924C
        for <linux-serial@vger.kernel.org>; Fri, 29 Apr 2022 04:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651233440; x=1682769440;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=o6fkhwf9Yg2gZlxJcA5PCB2TsqUBJ+ce9M0pFhtTTC8=;
  b=PWc9yJYYznMXT52XEPPxGAqjrBuDCTM4JAdHkApHi92MoWgd4UgBlAwd
   kYC1Qce14J/z8Dsbr/HctrrvUeQOS7bf5gX77jdWqHHvnW4pmBRyiY1hy
   FzjA1L8bG59d+ecv5xvyotRV4FtLkhUBxN4mF3vUGvdigUOPINIj6Yvrv
   u5aCGeCZ7119KiG9bnWJmgCagQxr03J1Mnzc86AClCG5+66fUsaZGMMDV
   ux8NFv/3g9PmZnkuBpKj/aVN1kaMtD9nJ2DRPgkvBQiIX6YJXcPpdC4aE
   0uh4sLSrH5QVD3ThUvRWbDuehFQIrh5X6H7TgS18FMJ2s6/D1hMSj38FR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="247183533"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="247183533"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 04:57:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="582088152"
Received: from iboscu-mobl2.ger.corp.intel.com ([10.249.33.26])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 04:57:18 -0700
Date:   Fri, 29 Apr 2022 14:57:16 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Nuno_Gon=E7alves?= <nunojpg@gmail.com>
cc:     Tomasz Mon <tomasz.mon@camlingroup.com>,
        Lukas Wunner <lukas@wunner.de>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: [PATCH v2] serial: pl011: UPSTAT_AUTORTS requires
 .throttle/unthrottle
Message-ID: <d4f254ec-b73-786c-dc47-629aab8a49df@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-549011745-1651233439=:1616"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-549011745-1651233439=:1616
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

The driver must provide throttle and unthrottle in uart_ops when it
sets UPSTAT_AUTORTS. Add them using existing stop_rx &
enable_interrupts functions.

Compile tested (w/o linking).

Reported-by: Nuno Gonçalves <nunojpg@gmail.com>
Fixes: 2a76fa283098 (serial: pl011: Adopt generic flag to store auto
		     RTS status)
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
v2:
- Fix dbl locking in pl011_unthrottle_rx calling pl011_enable_interrupts

 drivers/tty/serial/amba-pl011.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4d11a3e547f9..8f9bf32e278a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1339,6 +1339,15 @@ static void pl011_stop_rx(struct uart_port *port)
 	pl011_dma_rx_stop(uap);
 }
 
+static void pl011_throttle_rx(struct uart_port *port)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	pl011_stop_rx(port);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
 static void pl011_enable_ms(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
@@ -1760,9 +1769,10 @@ static int pl011_allocate_irq(struct uart_amba_port *uap)
  */
 static void pl011_enable_interrupts(struct uart_amba_port *uap)
 {
+	unsigned long flags;
 	unsigned int i;
 
-	spin_lock_irq(&uap->port.lock);
+	spin_lock_irqsave(&uap->port.lock, flags);
 
 	/* Clear out any spuriously appearing RX interrupts */
 	pl011_write(UART011_RTIS | UART011_RXIS, uap, REG_ICR);
@@ -1784,7 +1794,14 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
 	if (!pl011_dma_rx_running(uap))
 		uap->im |= UART011_RXIM;
 	pl011_write(uap->im, uap, REG_IMSC);
-	spin_unlock_irq(&uap->port.lock);
+	spin_unlock_irqrestore(&uap->port.lock, flags);
+}
+
+static void pl011_unthrottle_rx(struct uart_port *port)
+{
+	struct uart_amba_port *uap = container_of(port, struct uart_amba_port, port);
+
+	pl011_enable_interrupts(uap);
 }
 
 static int pl011_startup(struct uart_port *port)
@@ -2243,6 +2260,8 @@ static const struct uart_ops sbsa_uart_pops = {
 	.stop_tx	= pl011_stop_tx,
 	.start_tx	= pl011_start_tx,
 	.stop_rx	= pl011_stop_rx,
+	.throttle	= pl011_throttle_rx,
+	.unthrottle	= pl011_unthrottle_rx,
 	.startup	= sbsa_uart_startup,
 	.shutdown	= sbsa_uart_shutdown,
 	.set_termios	= sbsa_uart_set_termios,

-- 
tg: (19317433057d..) pl011/add-throttle (depends on: tty-linus)
--8323329-549011745-1651233439=:1616--
