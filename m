Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B111AC49EAF
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 22:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9631B613BD
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 22:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhFXWwP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Jun 2021 18:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232582AbhFXWwN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Jun 2021 18:52:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64A646138C;
        Thu, 24 Jun 2021 22:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624574993;
        bh=P00gi1Wtx+KpLLM7s98I0ogOiO2aXZ3GHASm7R/VtvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g9bBPTgFeD0qqieH/lPBvJiObWbeFCEHUcEWkYen5KPGeK7QBzRy1NGruRfHbAyUM
         lX+bQ05uQYIT0QRZ4zMyZqjYItXQEeYUR3+rtYnpT9NnVRVx+Byl3tcZy/O5leYFPo
         RE8E72bwDLEz7/Z0tMyKk2TFo1t8ShjvnmES49GtNHlZEZg6hL8Ri4R6rv9G4TmOnx
         /yKi4PsdpAG8iuAr4LDnAK9ozaEN1pfuaMGe5eYdHSxz7vtR2N4zqUEeXsi3J5V0HV
         M1v+ns5GIsH6Zs+ZxQO0pwdXBkuv4paXjAixfKjXe0O/5JUZ9fya34MfkJa6EWVX1U
         wQv8Ai7t+Ahwg==
Received: by pali.im (Postfix)
        id 87A7896D; Fri, 25 Jun 2021 00:49:51 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/10] serial: mvebu-uart: fix calculation of clock divisor
Date:   Fri, 25 Jun 2021 00:49:00 +0200
Message-Id: <20210624224909.6350-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624224909.6350-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The clock divisor should be rounded to the closest value.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 68a0db1d7da2 ("serial: mvebu-uart: add function to change baudrate")
Cc: stable@vger.kernel.org # 0e4cf69ede87 ("serial: mvebu-uart: clarify the baud rate derivation")
---
 drivers/tty/serial/mvebu-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index e0c00a1b0763..f81bfdaa608c 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -463,7 +463,7 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 	 * makes use of D to configure the desired baudrate.
 	 */
 	m_divisor = OSAMP_DEFAULT_DIVISOR;
-	d_divisor = DIV_ROUND_UP(port->uartclk, baud * m_divisor);
+	d_divisor = DIV_ROUND_CLOSEST(port->uartclk, baud * m_divisor);
 
 	brdv = readl(port->membase + UART_BRDV);
 	brdv &= ~BRDV_BAUD_MASK;
-- 
2.20.1

