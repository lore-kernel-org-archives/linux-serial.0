Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DAFC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 29 Apr 2022 11:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358276AbiD2L2S (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Apr 2022 07:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345528AbiD2L2R (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Apr 2022 07:28:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ED132ECF
        for <linux-serial@vger.kernel.org>; Fri, 29 Apr 2022 04:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651231499; x=1682767499;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J+r4hPGGFO77L9OYFsRgkSCelDLO9280pDvRuvg40Ak=;
  b=Z/TxdJejxYhsX02KBKthmisAblEzkf7SVUNWHraehkR9Oss+JqbRwNIB
   OhrxRboi2VUDV50gpih6wuIoQ5npg2o463BFdeEcYAKcJKC5fooCtZ5E+
   hftIVZPAaw4vvvf8skWfj+FV6YpDLT63s5E8kys7Tl0CsRVtanej+GALP
   YhrGbyyht6reVTLhwubf9vh/pu49Yri1+/WiRK73/7BBZzF8yrkrmnMV0
   TxGNq+PwkVC3b9tkcKsvSgE3HInhXh0G4NhJbZUXinjOfip+jdQ2Zgrhp
   mptB46+smhsiWya1+iO4UAQmdVYYcF4WavpBjfcb/q74Gw4NAJ8C7mYZs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="254001275"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="254001275"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 04:24:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="582073367"
Received: from iboscu-mobl2.ger.corp.intel.com ([10.249.33.26])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 04:24:53 -0700
Date:   Fri, 29 Apr 2022 14:24:50 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Tomasz Mon <tomasz.mon@camlingroup.com>,
        =?ISO-8859-15?Q?Nuno_Gon=E7alves?= <nunojpg@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
cc:     linux-serial <linux-serial@vger.kernel.org>
Subject: [PATCH] serial: pl011: UPSTAT_AUTORTS requires
 .throttle/unthrottle
Message-ID: <45e1eac1-1818-1f8c-6168-cff6be6427af@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-19093855-1651231494=:1616"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-19093855-1651231494=:1616
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

Maybe this one is the correct solution (I'm not able to test on the real 
hw though)?

It seems that max310x suffers from the same issue but it doesn't have 
an easy to use stop_rx available so it requires a bit more effort to 
figure out how to actually do the throttle state.

 drivers/tty/serial/amba-pl011.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4d11a3e547f9..3f15205a47c5 100644
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
@@ -1787,6 +1796,16 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
 	spin_unlock_irq(&uap->port.lock);
 }
 
+static void pl011_unthrottle_rx(struct uart_port *port)
+{
+	struct uart_amba_port *uap = container_of(port, struct uart_amba_port, port);
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	pl011_enable_interrupts(uap);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
 static int pl011_startup(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
@@ -2243,6 +2262,8 @@ static const struct uart_ops sbsa_uart_pops = {
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
--8323329-19093855-1651231494=:1616--
