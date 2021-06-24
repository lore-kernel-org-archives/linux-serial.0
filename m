Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CAEC49EAB
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 22:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35F8D613AD
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 22:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhFXWwR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Jun 2021 18:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232713AbhFXWwO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Jun 2021 18:52:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70380613C1;
        Thu, 24 Jun 2021 22:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624574994;
        bh=TY3iBQKER6Z5ph8zWEWZU/pK1GZsZOyt08z1Cvndgwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejK/fnKjQ/O4Pjsb2S5Y2uMIa3P9h5tOCV7V+GC5VTG1CrPP0MCXEnJHMCmEQDPFI
         57Mn6q1Gc+p0gSUHttDkZmgtruixOPQ/TX/cAzAOPq3dX7sn4nIo3srL0cKH1NsoVm
         xIm/tQpq1c8tFs/6bNzo6rYSc4w3IaAl4/e7a/8xyv5VvAd9xaEQrDt/E4qRIT2TuQ
         MUoPRrJ8MzzvK6YYLuDdxV7QeNKPPt4sDawMvcnYQIR+l0KLEw8152sNKuToSERz9/
         WXeiJa8iYuPIU0QRAZWj7hmAgIXTZMBLgt9hoEBiBc+hwOQdMYxUp+N2PX+4F5PexH
         A7PhJifWCgPdg==
Received: by pali.im (Postfix)
        id 9FB21BFC; Fri, 25 Jun 2021 00:49:52 +0200 (CEST)
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
Subject: [PATCH 02/10] serial: mvebu-uart: do not allow changing baudrate when uartclk is not available
Date:   Fri, 25 Jun 2021 00:49:01 +0200
Message-Id: <20210624224909.6350-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624224909.6350-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Testing mvuart->clk for non-error is not enough as mvuart->clk may contain
valid clk pointer but when clk_prepare_enable(mvuart->clk) failed then
port->uartclk is zero.

When mvuart->clk is not available then port->uartclk is zero too.

Parent clock rate port->uartclk is needed to calculate UART clock divisor
and without it is not possible to change baudrate.

So fix test condition when it is possible to change baudrate.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 68a0db1d7da2 ("serial: mvebu-uart: add function to change baudrate")
---
 drivers/tty/serial/mvebu-uart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index f81bfdaa608c..dc0c26824ddb 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -445,12 +445,11 @@ static void mvebu_uart_shutdown(struct uart_port *port)
 
 static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 {
-	struct mvebu_uart *mvuart = to_mvuart(port);
 	unsigned int d_divisor, m_divisor;
 	u32 brdv, osamp;
 
-	if (IS_ERR(mvuart->clk))
-		return -PTR_ERR(mvuart->clk);
+	if (!port->uartclk)
+		return -EOPNOTSUPP;
 
 	/*
 	 * The baudrate is derived from the UART clock thanks to two divisors:
-- 
2.20.1

