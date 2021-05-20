Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE58C43470
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 02:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30CDF6109F
	for <linux-serial@archiver.kernel.org>; Thu, 20 May 2021 02:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhETCQL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 May 2021 22:16:11 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:42489 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230301AbhETCPu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 May 2021 22:15:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1498E580853;
        Wed, 19 May 2021 22:13:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 19 May 2021 22:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=agM4yFIvUjmDK
        +7w1/5Qg1pbG8oDP4ygpRUviEPVwU8=; b=d/hZn5uMTzUkWpNZJmBAGWk8ntKY2
        T/LQMY1AQZeg+Z2CPSmFpaifYdopOB9EWW+QPf5cty/qK6njwp44nhDGXV1KpTLj
        Cg2M+6ezxnh1rjlbuPfyk4ZMAHMDrumzr6dTNETrbDQAmNpHRTE5pPOzyR2RLd/D
        qU8T3NLw2cYQrJHGeL2ftUeXxcI8L6nUKALUZw3m+jC8C9CsuqH/PaZSsDGWRl6A
        GI18kWvflPHn5VF8pQFcds5na8V3YOaRUNpuczycPqGBr6efiaLlbJhTULE8BUd8
        LERAQalNy7AENVilRHkQGOgdSrMB77gGefxd0UbvUMRmZWsyVjeZJsQdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=agM4yFIvUjmDK+7w1/5Qg1pbG8oDP4ygpRUviEPVwU8=; b=C4p4WdVI
        hIByzbaRiaU9S5kQemex08CSNX/tFqVW39IUylyrLDBh5mX86kBtJ89uyrQJJm3g
        Fj5ZqiN/zDvnHaIVxrsv+pSzMzQ51SC4wppDOlCc9VhPAXPU+vctdvQT8uJlWoU7
        LKFSnQ5vu7rB/V/Kcr5zgT2AwCo/o2fTLmbQbfPAYMhtbnB4t37u3xaoELzqGiV2
        SfUj3LKp5PzsURjMOjwT4++dRdpM97pRy8m6qxhLgs8whYfbYbWx9KeresqufKHu
        AKSFaLDu5MsPWBpNteRphRJxZkjnHBU0Ke3061fTgk6oOXHhfL8Ff1Nc41sM+eLO
        UjHQXP+EK1xFUg==
X-ME-Sender: <xms:4cWlYGsV8G1j-kW-xl2PTaJZYvOfu3xP8HBaUYCCVUxV15ppERh-0g>
    <xme:4cWlYLdcEVMpN63IFOPmoUZNm5W18WtfEWPQVr6z-ALkZgSbqqqO3xxOCKIFrafBU
    TY-iXjRplUXsonAxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejtddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgurhgv
    ficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrghtth
    gvrhhnpeehhfegffehvefhieejkedtvedvlefhgfeufedtgfetueevtedvffduffelleef
    heenucffohhmrghinhepphhorhhtrdguvghvnecukfhppedvtdefrdehjedrvdduhedrke
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgu
    rhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:4cWlYBw8xRl0nUO__ztvXO053yrINyRzKYB5d4YFPZ3OZEmQ_9OJyQ>
    <xmx:4cWlYBMsryNOxK5jAVVLOjn_SsiMHIaiUoofv4koguYM5dX7OPnMPg>
    <xmx:4cWlYG-a9uqFCqLZuUH-RFFMW9c8e7HxqeP4_sDUaW523fS-f82lkQ>
    <xmx:4sWlYJZ3g6Pprmw8CC4xlsRFwKld6e9BaAwRD0of5ePsz_LRl76RPw>
Received: from mistburn.lan (203-57-215-8.dyn.iinet.net.au [203.57.215.8])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Wed, 19 May 2021 22:13:49 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org, joel@jms.id.au,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        jenmin_yuan@aspeedtech.com, ryan_chen@aspeedtech.com,
        miltonm@us.ibm.com, ChiaWei Wang <chiawei_wang@aspeedtech.com>
Subject: [PATCH v3 1/2] serial: 8250: Add UART_BUG_TXRACE workaround for Aspeed VUART
Date:   Thu, 20 May 2021 11:43:33 +0930
Message-Id: <20210520021334.497341-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520021334.497341-1-andrew@aj.id.au>
References: <20210520021334.497341-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Aspeed Virtual UARTs directly bridge e.g. the system console UART on the
LPC bus to the UART interface on the BMC's internal APB. As such there's
no RS-232 signalling involved - the UART interfaces on each bus are
directly connected as the producers and consumers of the one set of
FIFOs.

The APB in the AST2600 generally runs at 100MHz while the LPC bus peaks
at 33MHz. The difference in clock speeds exposes a race in the VUART
design where a Tx data burst on the APB interface can result in a byte
lost on the LPC interface. The symptom is LSR[DR] remains clear on the
LPC interface despite data being present in its Rx FIFO, while LSR[THRE]
remains clear on the APB interface as the host has not consumed the data
the BMC has transmitted. In this state, the UART has stalled and no
further data can be transmitted without manual intervention (e.g.
resetting the FIFOs, resulting in loss of data).

The recommended work-around is to insert a read cycle on the APB
interface between writes to THR.

Cc: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/tty/serial/8250/8250.h              |  1 +
 drivers/tty/serial/8250/8250_aspeed_vuart.c |  1 +
 drivers/tty/serial/8250/8250_port.c         | 12 ++++++++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 52bb21205bb6..34aa2714f3c9 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -88,6 +88,7 @@ struct serial8250_config {
 #define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
 #define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
 #define UART_BUG_PARITY	(1 << 4)	/* UART mishandles parity if FIFO enabled */
+#define UART_BUG_TXRACE	(1 << 5)	/* UART Tx fails to set remote DR */
 
 
 #ifdef CONFIG_SERIAL_8250_SHARE_IRQ
diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index a28a394ba32a..4caab8714e2c 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -440,6 +440,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	port.port.status = UPSTAT_SYNC_FIFO;
 	port.port.dev = &pdev->dev;
 	port.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
+	port.bugs |= UART_BUG_TXRACE;
 
 	rc = sysfs_create_group(&vuart->dev->kobj, &aspeed_vuart_attr_group);
 	if (rc < 0)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d45dab1ab316..fc5ab2032282 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1809,6 +1809,18 @@ void serial8250_tx_chars(struct uart_8250_port *up)
 	count = up->tx_loadsz;
 	do {
 		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
+		if (up->bugs & UART_BUG_TXRACE) {
+			/*
+			 * The Aspeed BMC virtual UARTs have a bug where data
+			 * may get stuck in the BMC's Tx FIFO from bursts of
+			 * writes on the APB interface.
+			 *
+			 * Delay back-to-back writes by a read cycle to avoid
+			 * stalling the VUART. Read a register that won't have
+			 * side-effects and discard the result.
+			 */
+			serial_in(up, UART_SCR);
+		}
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
 		if (uart_circ_empty(xmit))
-- 
2.30.2

