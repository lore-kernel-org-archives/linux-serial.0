Return-Path: <SRS0=9Zku=3F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00816C33CB6
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 18:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0F6206D7
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 18:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200885;
	bh=XAohMiQdsEPByrIu6KzGUA3M3MrVIHV9qkKScFLTiAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qxWt+YYdwSzDVrtmP7cdsGe8hoXHole0rJpWBAe/7yiNNZioQfCN/DdgAXb9KXV5t
	 CMjUkuS5aoBoog6UUyjtEbR8UtVsNZ3CeSMAEnNhgBDt/mmbDxUbMIheMbi6QcDykE
	 R0oS3tzvze/W6kRA4j1qdsnwOXum2ol3rcqqF78Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbgAPRHx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:07:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389228AbgAPRHw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jan 2020 12:07:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92D5D20663;
        Thu, 16 Jan 2020 17:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194471;
        bh=XAohMiQdsEPByrIu6KzGUA3M3MrVIHV9qkKScFLTiAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRlX9eqQXkUub4vEc3my0BOIqELnx/Mx1/9F8NB/DZIjnZNxlUoesG8JdWBlhJZmj
         5pUIpOn7oR9qy2VOitW1zNQV9d+VzteOHXCK/L0P7v8p1xK0o4C8xmP/5SRRaoaQOO
         afe7yIoyD1UnsYrN8FP9LzFIgsd8JJenlzjNpDkM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Erwan Le Ray <erwan.leray@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 376/671] serial: stm32: fix transmit_chars when tx is stopped
Date:   Thu, 16 Jan 2020 12:00:14 -0500
Message-Id: <20200116170509.12787-113-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Erwan Le Ray <erwan.leray@st.com>

[ Upstream commit b83b957c91f68e53f0dc596e129e8305761f2a32 ]

Disables the tx irq  when the transmission is ended and updates stop_tx
conditions for code cleanup.

Fixes: 48a6092fb41f ("serial: stm32-usart: Add STM32 USART Driver")
Signed-off-by: Erwan Le Ray <erwan.leray@st.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/stm32-usart.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 0a7953e5ce47..2e7757d5e5d8 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -420,13 +420,8 @@ static void stm32_transmit_chars(struct uart_port *port)
 		return;
 	}
 
-	if (uart_tx_stopped(port)) {
-		stm32_stop_tx(port);
-		return;
-	}
-
-	if (uart_circ_empty(xmit)) {
-		stm32_stop_tx(port);
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		stm32_clr_bits(port, ofs->cr1, USART_CR1_TXEIE);
 		return;
 	}
 
@@ -439,7 +434,7 @@ static void stm32_transmit_chars(struct uart_port *port)
 		uart_write_wakeup(port);
 
 	if (uart_circ_empty(xmit))
-		stm32_stop_tx(port);
+		stm32_clr_bits(port, ofs->cr1, USART_CR1_TXEIE);
 }
 
 static irqreturn_t stm32_interrupt(int irq, void *ptr)
-- 
2.20.1

