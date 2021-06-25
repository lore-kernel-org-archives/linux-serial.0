Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2E3C49EA7
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 14:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A293461982
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 14:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhFYOjS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 10:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhFYOjS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 10:39:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B46361963;
        Fri, 25 Jun 2021 14:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624631817;
        bh=P00gi1Wtx+KpLLM7s98I0ogOiO2aXZ3GHASm7R/VtvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKseQSOcV9prIj+yP/LdEb+uUHmS2u2OaqMWk6fyxO6U+yWF2mhF/f4BDak86EIqS
         YRkTBuDSkPC5WBwlUMgGLqtEhxj6ziLQ35yzgo8KTxe15BitQI7NqEo0R6t5xczww/
         bAgwl4TW6uGHYPUOB2FZolH+kjDbeXmH4TgXf+mU23Lq85xJmh4YsQjA7vPEtyuTp/
         lMcnUC2QAJ73Oo6q3ZXd7tWkeO+mi1ZcIdFYDG9YeQNZBnhWTeNxVP8ZTUVHyzGVzL
         gEVrQo+D3gPC+PJRgwGYN0Q9k+pUxH39e9cY+yPdwG2NZBTaSJbMA6LlNjh8hHMI1J
         79KXONpAwsP1Q==
Received: by pali.im (Postfix)
        id 5ACC9A7D; Fri, 25 Jun 2021 16:36:55 +0200 (CEST)
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 01/11] serial: mvebu-uart: fix calculation of clock divisor
Date:   Fri, 25 Jun 2021 16:36:07 +0200
Message-Id: <20210625143617.12826-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210625143617.12826-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210625143617.12826-1-pali@kernel.org>
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

