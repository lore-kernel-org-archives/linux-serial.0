Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC60C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 12:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006CA619D2
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 12:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhCVMjq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Mar 2021 08:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231387AbhCVMiP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Mar 2021 08:38:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 436CD619A0;
        Mon, 22 Mar 2021 12:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616416646;
        bh=qZ8CtAubEETq0hjuoxRlHxWl/vHQSMOfCTA7Kp6wJwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYYkk8FELbgLOVmQUv6gJ2DulxAV1wfnX51aHQv3rbXxNRs6mVptSiDXTM0S8Ko1J
         tffDo++S+uOZg6c9FQpNL7rDS6oybzlCy5NugJ/PGA3NrlmuSudyfeOHs2SIQCnlKG
         xvUKSVC9DFfbwCitjh2e4NMZINJTkX715b6uHvo0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 065/157] tty: serial: stm32-usart: Remove set but unused cookie variables
Date:   Mon, 22 Mar 2021 13:27:02 +0100
Message-Id: <20210322121935.827607612@linuxfoundation.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210322121933.746237845@linuxfoundation.org>
References: <20210322121933.746237845@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

[ Upstream commit 24832ca3ee85a14c42a4f23a5c8841ef5db3d029 ]

Fixes the following W=1 kernel build warning(s):

 drivers/tty/serial/stm32-usart.c: In function ‘stm32_transmit_chars_dma’:
 drivers/tty/serial/stm32-usart.c:353:15: warning: variable ‘cookie’ set but not used [-Wunused-but-set-variable]
 drivers/tty/serial/stm32-usart.c: In function ‘stm32_of_dma_rx_probe’:
 drivers/tty/serial/stm32-usart.c:1090:15: warning: variable ‘cookie’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Gerald Baeza <gerald.baeza@st.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Link: https://lore.kernel.org/r/20201104193549.4026187-29-lee.jones@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/stm32-usart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index ee6c7762d355..f4de32d3f2af 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -350,7 +350,6 @@ static void stm32_transmit_chars_dma(struct uart_port *port)
 	struct stm32_usart_offsets *ofs = &stm32port->info->ofs;
 	struct circ_buf *xmit = &port->state->xmit;
 	struct dma_async_tx_descriptor *desc = NULL;
-	dma_cookie_t cookie;
 	unsigned int count, i;
 
 	if (stm32port->tx_dma_busy)
@@ -394,7 +393,7 @@ static void stm32_transmit_chars_dma(struct uart_port *port)
 	desc->callback_param = port;
 
 	/* Push current DMA TX transaction in the pending queue */
-	cookie = dmaengine_submit(desc);
+	dmaengine_submit(desc);
 
 	/* Issue pending DMA TX requests */
 	dma_async_issue_pending(stm32port->tx_ch);
@@ -1087,7 +1086,6 @@ static int stm32_of_dma_rx_probe(struct stm32_port *stm32port,
 	struct device *dev = &pdev->dev;
 	struct dma_slave_config config;
 	struct dma_async_tx_descriptor *desc = NULL;
-	dma_cookie_t cookie;
 	int ret;
 
 	/* Request DMA RX channel */
@@ -1132,7 +1130,7 @@ static int stm32_of_dma_rx_probe(struct stm32_port *stm32port,
 	desc->callback_param = NULL;
 
 	/* Push current DMA transaction in the pending queue */
-	cookie = dmaengine_submit(desc);
+	dmaengine_submit(desc);
 
 	/* Issue pending DMA requests */
 	dma_async_issue_pending(stm32port->rx_ch);
-- 
2.30.1



