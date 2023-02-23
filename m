Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEDEC61DA4
	for <linux-serial@archiver.kernel.org>; Thu, 23 Feb 2023 04:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjBWEZH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Feb 2023 23:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjBWEYd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Feb 2023 23:24:33 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1126303F8
        for <linux-serial@vger.kernel.org>; Wed, 22 Feb 2023 20:23:09 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id CD6B680ADF;
        Thu, 23 Feb 2023 05:23:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1677126187;
        bh=a3O2TGgOusMKS5UkGFPkp696mfXETUFA4hkni+79F8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sxll1XHBq0EdMVrBhnjyddtAgXkmLif11P+b/AVTEeZvNg1tSQ4cVXmgZxlOkxRHC
         LDBIReWdMR69/JYEXucG03RFqI1UX8ftKt5l89gR7MJuVQ5RHDLdppqir2CKW0Iocw
         mVT2UA+ZXvOMQBdrod0WLu5dSFVzLJpoKO6GOpSiVYyWU2ojae9eYjnBYQp+C47x5A
         oVuUCu4HE4erpaLIi/b0xX6R73I0IF8Xff2TdAUmvnb/S1jTaxtaCjwZEtg8f6n8p/
         WLdOLBmVJ9qc3aySIfixsVA8ofaYZw6XyPYv3hL4xg9xHlGllthhMCvoLX85Nuhsw1
         R74O/N2xic1jA==
From:   Marek Vasut <marex@denx.de>
To:     linux-serial@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Philippe Romain <jean-philippe.romain@foss.st.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/2] serial: stm32: Re-assert RTS/DE GPIO in RS485 mode only if more data are transmitted
Date:   Thu, 23 Feb 2023 05:22:52 +0100
Message-Id: <20230223042252.95480-2-marex@denx.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230223042252.95480-1-marex@denx.de>
References: <20230223042252.95480-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The stm32_usart_transmit_chars() may be called with empty or stopped
transmit queue, and no XON/OFF character pending. This can happen at
the end of transmission, where this last call is used to either handle
the XON/XOFF x_char, or disable TX interrupt if queue is empty or
stopped.

If that occurs, do not assert the RS485 RTS/DE GPIO anymore, as the
GPIO would remain asserted past the end of transmission and that would
block the RS485 bus after the transmission.

Only assert the RS485 RTS/DE GPIO if there is either pending XON/XOFF
x_char, or at least one character in running transmit queue.

Fixes: d7c76716169d ("serial: stm32: Use TC interrupt to deassert GPIO RTS in RS485 mode")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Erwan Le Ray <erwan.leray@foss.st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jean Philippe Romain <jean-philippe.romain@foss.st.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Valentin Caron <valentin.caron@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-serial@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
---
 drivers/tty/serial/stm32-usart.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index bf51e2152dd5a..1e38fc9b10c11 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -693,8 +693,9 @@ static void stm32_usart_transmit_chars(struct uart_port *port)
 	int ret;
 
 	if (!stm32_port->hw_flow_control &&
-	    port->rs485.flags & SER_RS485_ENABLED) {
-		stm32_port->txdone = false;
+	    port->rs485.flags & SER_RS485_ENABLED &&
+	    (port->x_char ||
+	     !(uart_circ_empty(xmit) || uart_tx_stopped(port)))) {
 		stm32_usart_tc_interrupt_disable(port);
 		stm32_usart_rs485_rts_enable(port);
 	}
-- 
2.39.1

