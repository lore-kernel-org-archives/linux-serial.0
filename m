Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DD9C433B4
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 14:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999AD6127A
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 14:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhELOOg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 May 2021 10:14:36 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:58517 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhELOOP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 May 2021 10:14:15 -0400
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 31C0A2225D;
        Wed, 12 May 2021 16:13:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620828786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFF3464Ov8Z2ChbvZV2eQ/PAASkGDOipVGOpBK/usRA=;
        b=W/k9dzuTkeFAerVNrFdOyWmRZEF6+C//qJcbtWp/JHq/pr4XeQURHyRrw0iijlCohZToGD
        uqXiIPMFjkRYzNcFwufa6XskwqvRIHY/z2hFh9anjQp9vAnYa0vrtR0H6iq3uh0c4RscaQ
        cdo+J6IfIU1SHQ5jw88xq1hOET+Ox48=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Johan Hovold <johan@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 2/9] serial: fsl_lpuart: use UARTDATA_MASK macro
Date:   Wed, 12 May 2021 16:12:48 +0200
Message-Id: <20210512141255.18277-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210512141255.18277-1-michael@walle.cc>
References: <20210512141255.18277-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use the corresponding macro instead of the magic number. While at it,
drop the useless cast to "unsigned char".

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index fbf2e4d2d22b..b76ddc0d8edc 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -928,9 +928,9 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 		 */
 		sr = lpuart32_read(&sport->port, UARTSTAT);
 		rx = lpuart32_read(&sport->port, UARTDATA);
-		rx &= 0x3ff;
+		rx &= UARTDATA_MASK;
 
-		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
+		if (uart_handle_sysrq_char(&sport->port, rx))
 			continue;
 
 		if (sr & (UARTSTAT_PE | UARTSTAT_OR | UARTSTAT_FE)) {
-- 
2.20.1

