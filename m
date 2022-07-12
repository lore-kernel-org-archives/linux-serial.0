Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596C7C43334
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jul 2022 13:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiGLNPf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGLNPe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jul 2022 09:15:34 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE24E5C959
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 06:15:30 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k18-20020a170902c41200b0016c40543af4so4192925plk.0
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Jj15qoURj3emWvHLxBH2nPwiIzzLvd3mSNd7M20V7kc=;
        b=VrvPmlW1Mw9Qie6nuTLyJIEdvtB1q9qnbj5yZHc5WAz2gmilCGbHrAqHW+nbHnr1Yt
         QYCVTeIud8NWMDpleRg/psfMwA6QarcShJmRgGOPwCri+9+7X2GBA4+Tj+c4G58JlOR2
         AAnOp9AzxbNQ7LsrvFRsrxgHUqqbYI38rxnkXJYQf4VtAcxDHSqE1u2CVWElkavoprVq
         MLPLZF4KKZ2n+NFw/z5bjZirvOBQtqzV8bEJ7ZcxpbnMBWkTdx+DSdszCF38jbVzKw1N
         v+nA8OfSDnRpifHP6YFfv5eLm0pP+A8Sl89jwczzX/VKEppia8uaYMmSmotBlTP99use
         TmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Jj15qoURj3emWvHLxBH2nPwiIzzLvd3mSNd7M20V7kc=;
        b=uiQgMj3Vc8djiE/exqNCEB4OWw1KQyH0zUYxM0zjCmV1YSMlYd7b7xizSv+xDQYrLT
         h+QRbYaboh87nB0KRaFQ4rgGvGKC9+wyI9Uaq+d3Pgcew/ud+QZ87V9Q1VuMYu+G6YAz
         EfX8SSCAh5hG1mIr53YCcYl+G8zETeq9hMeLgldR3vo7znwNepLQ/42Ir5221wH2VYiA
         H09e2bWvx/ya1RukHgUwpwn4zzJFg6XPx2dXwWC4biXs1OFKRFAIvnEbsWu+0369YVKw
         6AaSE+++lbtKUtU9fDqDl9oO9aruKkaXUWT0dRh9mGWsDD+r/t/39ytJA+x1RDf/zvoF
         2Aeg==
X-Gm-Message-State: AJIora90gvpDZH6V/GFL+3qEymEE/tlZHftGogHg88sFnYnelN8NmoHs
        ISqFxDH5cYw2o8OQfaOi1vnQVwYvhVJ8S+JYin04
X-Google-Smtp-Source: AGRyM1tiLhmBsSG07iMVccKmTqJMgw+sCcWHJFKw/dCojeh685N00bAiC1pMr5tl2AGmpOHdStzVwHzb7OqZJcAwSsTV
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a17:90b:247:b0:1f0:1192:7c22 with
 SMTP id fz7-20020a17090b024700b001f011927c22mr4471560pjb.232.1657631730301;
 Tue, 12 Jul 2022 06:15:30 -0700 (PDT)
Date:   Tue, 12 Jul 2022 18:45:23 +0530
Message-Id: <20220712131523.1874428-1-vamshigajjela@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH] serial: 8250_dw: Avoid pslverr on reading empty receiver fifo
From:   Vamshi Gajjela <vamshigajjela@google.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        VAMSHI GAJJELA <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: VAMSHI GAJJELA <vamshigajjela@google.com>

With PSLVERR_RESP_EN parameter set to 1, device generates an error
response when an attempt to read empty RBR with FIFO enabled.

This happens when LCR writes are ignored when UART is busy.
dw8250_check_lcr() in retries to updateLCR, invokes dw8250_force_idle()
to clear and reset fifo and eventually reads UART_RX causing pslverr.

Avoid this by not reading RBR/UART_RX when no data is available.

Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
---
 drivers/tty/serial/8250/8250_dw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f57bbd32ef11..a83222839884 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -81,9 +81,19 @@ static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
 
 static void dw8250_force_idle(struct uart_port *p)
 {
+	unsigned int lsr;
 	struct uart_8250_port *up = up_to_u8250p(p);
 
 	serial8250_clear_and_reinit_fifos(up);
+
+	/*
+	 * With PSLVERR_RESP_EN parameter set to 1, device generates pslverr
+	 * error response when an attempt to read empty RBR with FIFO enabled
+	 */
+	lsr = p->serial_in(p, UART_LSR);
+	if ((up->fcr & UART_FCR_ENABLE_FIFO) && !(lsr & UART_LSR_DR))
+		return;
+
 	(void)p->serial_in(p, UART_RX);
 }
 
-- 
2.37.0.144.g8ac04bfd2-goog

