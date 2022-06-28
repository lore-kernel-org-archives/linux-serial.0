Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F74EC43334
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jun 2022 09:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245619AbiF1JBg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jun 2022 05:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbiF1JBe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jun 2022 05:01:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9D92E685;
        Tue, 28 Jun 2022 02:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656406892; x=1687942892;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/0SUib/paXuDzkqjNC2nmpyo5DifPNvw8VW3V2FElxY=;
  b=HopgLUGyFe/2KxDlQbhHqvvKCqr5iSskDp5AtJSyeDXkpAzQmOidYhxn
   uhgFKZl3tesRRZO6zgEu4J6WdxAGuqydFkyf4+TAhi2qGCFfF5BUMT4Xa
   z2bR/WMEsRoNOJOBc+X6S2QI+k+YjdWe4J71DSA+XVDxaPeL9MI17+wH0
   M5UeT7c29DLUKnpmW1QPjqdFwcXYj91aK5enAHxxWExyvf3J4Lucdy0AZ
   37p3MkrNvzaFyUH636wOgCdi+XtOxl5BZfIN2Hmvf2e3zdFWsi2TfycVY
   cuCXKno0pRzO4BDrAQqRD5snw/wVueLRyXvaqNu4YpdGirD1hcwXvUros
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="280442169"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="280442169"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:01:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646829132"
Received: from iannetti-mobl.ger.corp.intel.com ([10.251.216.215])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:01:30 -0700
Date:   Tue, 28 Jun 2022 12:01:28 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND tty-next] serial: 8250_dw: Take port lock while
 accessing LSR
Message-ID: <c5879db7-bee9-93f-526e-872a292442@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-895458432-1656406891=:1603"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-895458432-1656406891=:1603
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Accessing LSR requires port lock because it mutates lsr_saved_flags
in serial_lsr_in().

Fixes: 197eb5c416ff ("serial: 8250_dw: Use serial_lsr_in() in dw8250_handle_irq()")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

---
I'll resend the third patch later.

 drivers/tty/serial/8250/8250_dw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 167a691c7b19..f78b13db1b1e 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -266,7 +266,10 @@ static int dw8250_handle_irq(struct uart_port *p)
 
 	/* Manually stop the Rx DMA transfer when acting as flow controller */
 	if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_running && rx_timeout) {
+		spin_lock_irqsave(&p->lock, flags);
 		status = serial_lsr_in(up);
+		spin_unlock_irqrestore(&p->lock, flags);
+
 		if (status & (UART_LSR_DR | UART_LSR_BI)) {
 			dw8250_writel_ext(p, RZN1_UART_RDMACR, 0);
 			dw8250_writel_ext(p, DW_UART_DMASA, 1);

-- 
tg: (f55d2e4b0a47..) dw/use-spinlock (depends on: 8250/fix-stop_tx-race)
--8323329-895458432-1656406891=:1603--
