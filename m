Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93ADC4708F
	for <linux-serial@archiver.kernel.org>; Fri,  4 Jun 2021 09:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B731E6141C
	for <linux-serial@archiver.kernel.org>; Fri,  4 Jun 2021 09:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhFDJ7B (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Jun 2021 05:59:01 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:9315 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229612AbhFDJ7B (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Jun 2021 05:59:01 -0400
X-IronPort-AV: E=Sophos;i="5.83,248,1616425200"; 
   d="scan'208";a="83253024"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Jun 2021 18:57:14 +0900
Received: from localhost.localdomain (unknown [10.166.14.185])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8EA2C41FAEDE;
        Fri,  4 Jun 2021 18:57:14 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2] serial: sh-sci: Stop dmaengine transfer in sci_stop_tx()
Date:   Fri,  4 Jun 2021 18:57:04 +0900
Message-Id: <20210604095704.756190-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Stop dmaengine transfer in sci_stop_tx(). Otherwise, the following
message is possible output when system enters suspend and while
transferring data, because clearing TIE bit in SCSCR is not able to
stop any dmaengine transfer.

    sh-sci e6550000.serial: ttySC1: Unable to drain transmitter

Notes:
 - sci_dma_stop_tx() is a macro in the .h file because struct sci_port
   is declared in the .c file and #ifdef should be in the .h file.
 - This patch uses dmaengine_terminate_async() so that we can apply
   this into longterm kernel v4.9.x or later.

Fixes: 73a19e4c0301 ("serial: sh-sci: Add DMA support.")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Changes from v1:
 - Don't put #ifdef in the .c file.
 - Update the commit description.
 https://lore.kernel.org/linux-renesas-soc/TY2PR01MB3692C545672195370487FA60D83C9@TY2PR01MB3692.jpnprd01.prod.outlook.com/T/#t
 
 drivers/tty/serial/sh-sci.c |  2 ++
 drivers/tty/serial/sh-sci.h | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4baf1316ea72..3793cf9f352c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -610,6 +610,8 @@ static void sci_stop_tx(struct uart_port *port)
 	ctrl &= ~SCSCR_TIE;
 
 	serial_port_out(port, SCSCR, ctrl);
+
+	sci_dma_stop_tx(port);
 }
 
 static void sci_start_rx(struct uart_port *port)
diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index c0dfe4382898..435c674af1ce 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -174,3 +174,19 @@ enum {
 	(((port)->type == PORT_SCI) ? SCI_TDxE_CLEAR : SCIF_TDxE_CLEAR)
 #define SCxSR_BREAK_CLEAR(port) \
 	(((port)->type == PORT_SCI) ? SCI_BREAK_CLEAR : SCIF_BREAK_CLEAR)
+
+#ifdef CONFIG_SERIAL_SH_SCI_DMA
+#define sci_dma_stop_tx(port)					\
+{								\
+	struct sci_port *s = to_sci_port(port);			\
+								\
+	if (s->chan_tx && !dma_submit_error(s->cookie_tx)) {	\
+		dmaengine_terminate_async(s->chan_tx);		\
+		s->cookie_tx = -EINVAL;				\
+	}							\
+}
+#else
+static inline void sci_dma_stop_tx(struct uart_port *port)
+{
+}
+#endif /* CONFIG_SERIAL_SH_SCI_DMA */
-- 
2.25.1

