Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D46CC433E3
	for <linux-serial@archiver.kernel.org>; Sun, 28 Mar 2021 15:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A1061972
	for <linux-serial@archiver.kernel.org>; Sun, 28 Mar 2021 15:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhC1PqF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 28 Mar 2021 11:46:05 -0400
Received: from smtp.wifcom.cz ([85.207.3.150]:54756 "EHLO smtp.wifcom.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230294AbhC1Pps (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 28 Mar 2021 11:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eaxlabs.cz; s=mail;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=/6zusLrlarjoJKgAyXwKgpDFQJDYaG12zzl0PqOu+pE=;
        b=iOmEVd2h2FjOysT1WCaXG7jx9rnkY3KeVovNJIBjX2mZpxw+Cj5Uf86dB1+3DC9WjWN0Is/MJBws5j09mxJD8Vh8n6ugRQEMj+hKd89CWLiRJxkO2jNUxHvf2p0jE77fwvE2A465k334/ehqCSqeR4aNdg5MFE6UqIYSNgczjxY=;
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
Subject: [PATCH v8 2/2] tty/serial: Add rx-tx-swap OF option to stm32-usart
Date:   Sun, 28 Mar 2021 17:43:06 +0200
Message-Id: <20210328154306.22674-2-devik@eaxlabs.cz>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210328154306.22674-1-devik@eaxlabs.cz>
References: <YF3tKmzX1PtlX59x@kroah.com>
 <20210328154306.22674-1-devik@eaxlabs.cz>
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Wif-ss: -1.1 (-)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

STM32 F7/H7 usarts supports RX & TX pin swapping.
Add option to turn it on.
Tested on STM32MP157.

Signed-off-by: Martin Devera <devik@eaxlabs.cz>
Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
v8:
  - rebase to the latest tty-next
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
---
 drivers/tty/serial/stm32-usart.c | 11 ++++++++++-
 drivers/tty/serial/stm32-usart.h |  4 ++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index cba4f4ddf164..4d277804c63e 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -671,6 +671,12 @@ static int stm32_usart_startup(struct uart_port *port)
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
 		writel_relaxed(USART_RQR_RXFRQ, port->membase + ofs->rqr);
@@ -789,7 +795,7 @@ static void stm32_usart_set_termios(struct uart_port *port,
 	cr1 = USART_CR1_TE | USART_CR1_RE;
 	if (stm32_port->fifoen)
 		cr1 |= USART_CR1_FIFOEN;
-	cr2 = 0;
+	cr2 = stm32_port->swap ? USART_CR2_SWAP : 0;
 
 	/* Tx and RX FIFO configuration */
 	cr3 = readl_relaxed(port->membase + ofs->cr3);
@@ -1047,6 +1053,9 @@ static int stm32_usart_init_port(struct stm32_port *stm32port,
 	stm32port->wakeup_src = stm32port->info->cfg.has_wakeup &&
 		of_property_read_bool(pdev->dev.of_node, "wakeup-source");
 
+	stm32port->swap = stm32port->info->cfg.has_swap &&
+		of_property_read_bool(pdev->dev.of_node, "rx-tx-swap");
+
 	stm32port->fifoen = stm32port->info->cfg.has_fifo;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/tty/serial/stm32-usart.h b/drivers/tty/serial/stm32-usart.h
index a86773f1a4c4..77d1ac082e89 100644
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
@@ -268,6 +271,7 @@ struct stm32_port {
 	int last_res;
 	bool tx_dma_busy;	 /* dma tx busy               */
 	bool hw_flow_control;
+	bool swap;		 /* swap RX & TX pins */
 	bool fifoen;
 	bool wakeup_src;
 	int rdr_mask;		/* receive data register mask */
-- 
2.11.0

