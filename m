Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7AEC433ED
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 14:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74578613F7
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 14:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhELOOf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 May 2021 10:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhELOOP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 May 2021 10:14:15 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7BEC061574;
        Wed, 12 May 2021 07:13:07 -0700 (PDT)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7A0FA2225B;
        Wed, 12 May 2021 16:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620828785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JAJPgRblRiNhiOC7XlWvYpG23ZdxlO3ho2zd+PjduLM=;
        b=UlUaMHCpDptMDnBzMTThi8xYbNzm4UQynA+GukccDk60YAQ56FVYox2CTVCPI+fCCMzvuw
        AZ3Z7mqMruTFelNUuCIAz7XUbEzkhO2fJzpYITIKtywguwVn0BzoUfnceOGsK5H8EihAQh
        UrevMcyNl5IxlLkjHclghT8DihXAFO0=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Johan Hovold <johan@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 1/9] serial: fsl_lpuart: don't modify arbitrary data on lpuart32
Date:   Wed, 12 May 2021 16:12:47 +0200
Message-Id: <20210512141255.18277-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210512141255.18277-1-michael@walle.cc>
References: <20210512141255.18277-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

lpuart_rx_dma_startup() is used for both the 8 bit and the 32 bit
version of the LPUART. Modify the UARTCR only for the 8 bit version.

Fixes: f4eef224a09f ("serial: fsl_lpuart: add sysrq support when using dma")
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 794035041744..fbf2e4d2d22b 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1625,7 +1625,7 @@ static void lpuart_rx_dma_startup(struct lpuart_port *sport)
 	sport->lpuart_dma_rx_use = true;
 	rx_dma_timer_init(sport);
 
-	if (sport->port.has_sysrq) {
+	if (sport->port.has_sysrq && !lpuart_is_32(sport)) {
 		cr3 = readb(sport->port.membase + UARTCR3);
 		cr3 |= UARTCR3_FEIE;
 		writeb(cr3, sport->port.membase + UARTCR3);
-- 
2.20.1

