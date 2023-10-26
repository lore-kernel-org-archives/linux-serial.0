Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B29C25B48
	for <linux-serial@archiver.kernel.org>; Thu, 26 Oct 2023 10:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344699AbjJZKmA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Oct 2023 06:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235012AbjJZKl5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Oct 2023 06:41:57 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3D4D42;
        Thu, 26 Oct 2023 03:41:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD21024000C;
        Thu, 26 Oct 2023 10:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698316912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=89QZghIzrhbdFSkiY8cfj50jVqvDezZ7qykG0hXVcLg=;
        b=X87hLIePGytsjaYLRg0arx9Bl9oHNsdE6MvxwwnFpzyIW4SBLwzF8LBQjdtjzJGJUjnJU9
        Xq+dAcQUJ87nfTzOpq+VzDum0q6v+s+BVhXPoG3PQY6l7ROEgx8NcPPexfcwcHFG23E3FX
        YBF621ORbbZnEf25HB83TF+7gmk1pRmGOdmR9Ve4zS/Czav72svci23wHftEGl7Wjw/G8T
        BzbkPeKJyQrly/u+eqkiITRAI8u1zXG5/RVRayCGpi8Ywz4Kx6jeePPn0PKtaAC1TtAfcv
        BRbuMVohUSmmAyWicWanqn3fHzsn3L6Whccyhm4MohTgoa06v0f6xxa7MI3YIA==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Thu, 26 Oct 2023 12:41:23 +0200
Subject: [PATCH 6/6] tty: serial: amba-pl011: Parse bits option as 5, 6, 7
 or 8 in _get_options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
In-Reply-To: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

pl011_console_get_options() gets called to retrieve currently configured
options from the registers. Previously, LCRH_TX.WLEN was being parsed
as either 7 or 8 (fallback). Hardware supports values from 5 to 8
inclusive, which pl011_set_termios() exploits for example.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/tty/serial/amba-pl011.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5774d48c7f16..b2062e4cbbab 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2384,10 +2384,7 @@ static void pl011_console_get_options(struct uart_amba_port *uap, int *baud,
 			*parity = 'o';
 	}
 
-	if ((lcr_h & 0x60) == UART01x_LCRH_WLEN_7)
-		*bits = 7;
-	else
-		*bits = 8;
+	*bits = FIELD_GET(0x60, lcr_h) + 5; /* from 5 to 8 inclusive */
 
 	ibrd = pl011_read(uap, REG_IBRD);
 	fbrd = pl011_read(uap, REG_FBRD);

-- 
2.41.0

