Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD351C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 12 Mar 2021 15:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE4164FE0
	for <linux-serial@archiver.kernel.org>; Fri, 12 Mar 2021 15:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhCLPjo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Mar 2021 10:39:44 -0500
Received: from smtp.wifcom.cz ([85.207.3.150]:52254 "EHLO smtp.wifcom.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231709AbhCLPjj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Mar 2021 10:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eaxlabs.cz; s=mail;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=kSXHXTR/TeMt8/zrDo1WiK6sqLAP5dPJKbJ+mSkPfN4=;
        b=e2Q+SqAyLIJ7yR/vQT8I0y/kY8Iw9CSblfWZEtJIqo8fMHkgMYGV69ndEzaPGALV/s9X1L72QmM0a3D57B6iK3qMC9vLwIjmfP9qjAkODP2t+SVyXtdEEWV20r820YAV7SJ8omiRUyTRe/lI4sAc/p3JJUVofY50m07bxMplQNg=;
From:   Martin Devera <devik@eaxlabs.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Martin Devera <devik@eaxlabs.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jiri Slaby <jirislaby@kernel.org>, Le Ray <erwan.leray@st.com>,
        fabrice.gasnier@foss.st.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 2/2] tty/serial: Add rx-tx-swap OF option to stm32-usart
Date:   Fri, 12 Mar 2021 16:37:02 +0100
Message-Id: <20210312153702.12349-2-devik@eaxlabs.cz>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210312153702.12349-1-devik@eaxlabs.cz>
References: <1615559009.788146.2976052.nullmailer@robh.at.kernel.org>
 <20210312153702.12349-1-devik@eaxlabs.cz>
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Wif-ss: -2.9 (--)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

STM32 F7/H7 usarts supports RX & TX pin swapping.
Add option to turn it on.
Tested on STM32MP157.

Signed-off-by: Martin Devera <devik@eaxlabs.cz>
Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
v6: 
  - add version changelog
v4:
  - delete superfluous has_swap=false
v3:
  - add has_swap to stm32_usart_info (because F4 line
    doesn't support swapping)
  - move swap variable init from stm32_usart_of_get_port
    to stm32_usart_init_port because info struct is not
    initialized in stm32_usart_of_get_port yet
  - set USART_CR2_SWAP in stm32_usart_startup too
v2:
  - change st,swap to rx-tx-swap (pointed out by Rob Herring)
  - rebase patches as suggested by Greg Kroah-Hartman
---
 drivers/tty/serial/stm32-usart.c | 11 ++++++++++-
 drivers/tty/serial/stm32-usart.h |  4 ++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index b3675cf25a69..d390f7da1441 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -644,6 +644,12 @@ static int stm32_usart_startup(struct uart_port *port)
 	if (ret)
 		return ret;
 
+	if (stm32_port->swap) {
+		val = readl_relaxed(port->membase + ofs->cr2);
+		val |= USART_CR2_SWAP;
+		writel_relaxed(val, port->membase + ofs->cr2);
+	}
+
 	/* RX FIFO Flush */
 	if (ofs->rqr != UNDEF_REG)
 		stm32_usart_set_bits(port, ofs->rqr, USART_RQR_RXFRQ);
@@ -758,7 +764,7 @@ static void stm32_usart_set_termios(struct uart_port *port,
 	cr1 = USART_CR1_TE | USART_CR1_RE;
 	if (stm32_port->fifoen)
 		cr1 |= USART_CR1_FIFOEN;
-	cr2 = 0;
+	cr2 = stm32_port->swap ? USART_CR2_SWAP : 0;
 	cr3 = readl_relaxed(port->membase + ofs->cr3);
 	cr3 &= USART_CR3_TXFTIE | USART_CR3_RXFTCFG_MASK | USART_CR3_RXFTIE
 		| USART_CR3_TXFTCFG_MASK;
@@ -1006,6 +1012,9 @@ static int stm32_usart_init_port(struct stm32_port *stm32port,
 			return stm32port->wakeirq ? : -ENODEV;
 	}
 
+	stm32port->swap = stm32port->info->cfg.has_swap &&
+		of_property_read_bool(pdev->dev.of_node, "rx-tx-swap");
+
 	stm32port->fifoen = stm32port->info->cfg.has_fifo;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index cb4f327c46db..a85391e71e8e 100644
--- a/drivers/tty/serial/stm32-usart.h
+++ b/drivers/tty/serial/stm32-usart.h
@@ -25,6 +25,7 @@ struct stm32_usart_offsets {
 struct stm32_usart_config {
 	u8 uart_enable_bit; /* USART_CR1_UE */
 	bool has_7bits_data;
+	bool has_swap;
 	bool has_wakeup;
 	bool has_fifo;
 	int fifosize;
@@ -76,6 +77,7 @@ struct stm32_usart_info stm32f7_info = {
 	.cfg = {
 		.uart_enable_bit = 0,
 		.has_7bits_data = true,
+		.has_swap = true,
 		.fifosize = 1,
 	}
 };
@@ -97,6 +99,7 @@ struct stm32_usart_info stm32h7_info = {
 	.cfg = {
 		.uart_enable_bit = 0,
 		.has_7bits_data = true,
+		.has_swap = true,
 		.has_wakeup = true,
 		.has_fifo = true,
 		.fifosize = 16,
@@ -271,6 +274,7 @@ struct stm32_port {
 	int last_res;
 	bool tx_dma_busy;	 /* dma tx busy               */
 	bool hw_flow_control;
+	bool swap;		 /* swap RX & TX pins */
 	bool fifoen;
 	int wakeirq;
 	int rdr_mask;		/* receive data register mask */
-- 
2.11.0

