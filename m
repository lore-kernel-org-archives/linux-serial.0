Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6459C433ED
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 12:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B0461221
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 12:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbhEQMmk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 08:42:40 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:41241 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237091AbhEQMmh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 08:42:37 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9788E5808A4;
        Mon, 17 May 2021 08:41:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 17 May 2021 08:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=MF+FHtIUrSHPdv8pdx7xGvA8pK
        5kMkTH+JjfQNKGQSU=; b=Jlc+d3CsoDg5Dj5AkPN6IPlUwNaL70WXBrBs+dMRN/
        /OsddQIg+KK2RdgrXGSzupNs3yjokIJwzi1HuhnX1d/PU6bClf7yrzx/5Irp3Hac
        aGoQi4XgjX13NH+x5iazvtaGFfR+71YRC/IPT7UdVoZ9N225X4X8Iw8xW7DgA2BA
        KWxVOk2CDBPuYyRtVUbkxRqZ2VBXOBhc/hI9oW1+Y+GZb85HH8iBfmlbWpikux6e
        EokBq4fGwg1wGubtQFks6t1kYfeOSnUrRawjo9qyZH08dgOuj4bZzhsnjWElNAjI
        FrTbnyLuwaJxaPkUeN1geeC3H3hxxF60en+QsztDn3ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=MF+FHtIUrSHPdv8pd
        x7xGvA8pK5kMkTH+JjfQNKGQSU=; b=jeRyaiiheB49PyjYDrrdCFe2KLAqUonB7
        8yVjWW/0KiCkm0XFMq0yoqHbq+gFIbDyF5QPN100JWC/9XhOLgnwTSK0Z812u/tU
        TI+P6QEPcGuaWW9ym7PzWfxPbFN8gQAf/IcyURKfndhWPCcJ2ybVisikvnJCc3v7
        8j5+koqHSsUjS7JrKclMRkrbV0KHn+WMo8EASqHcr9J0Qb9KvyxetSieHMMoX7x4
        jfEyJso3d0RUUvwpeqeqa1BxlyOFxssSgfW75hI8e3pNqH8j7ubglNwcuFEsJ2dA
        XY5BXR8NFLIB79CyPwHzBN0Moi9G5r2GYzmwY1mATbMkDQMmgTqkw==
X-ME-Sender: <xms:b2SiYD8Cfk9dr8VfeBG1c3uoajAlDfkBhldGGsPj2R9RY_IH5nzUtw>
    <xme:b2SiYPuqtQrJK208NsIzpRNBB4Ns8IH8tWbS9q9l0zt7JymRHQeC361taX7eHAwnf
    4HiY1_HUHv674OsNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeihedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetnhgurhgvficu
    lfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrghtthgvrh
    hnpeegfedttdfhfeegtdejveeivdehtefhveejudeujeevvdeifeegvdduffeigeehhfen
    ucffohhmrghinhepphhorhhtrdguvghvnecukfhppedvtdefrdehjedrvdduhedrkeenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgv
    fiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:b2SiYBCnuwf9VGbenYUaOk89dozsHE56pR6YpRHHfawIGphupMERVQ>
    <xmx:b2SiYPftoQrObGOZeY4qvnLnhuY4KyGFx6fhjD8LVjlqI1Z1Kl4A7w>
    <xmx:b2SiYIMAttCZYKkMXb6Pf-5EMPhuj85capD4X5ZD9pqcPqOONOmlzg>
    <xmx:cGSiYHp6-oc-IfnjOVyT_NOomPBBvZYKLzJlgRv-7kpg0IMAMIbZZQ>
Received: from mistburn.lan (203-57-215-8.dyn.iinet.net.au [203.57.215.8])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon, 17 May 2021 08:41:14 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org, joel@jms.id.au,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        jenmin_yuan@aspeedtech.com, ryan_chen@aspeedtech.com,
        miltonm@us.ibm.com, ChiaWei Wang <chiawei_wang@aspeedtech.com>
Subject: [PATCH] tty: 8250: Add UART_BUG_TXRACE workaround for Aspeed VUART
Date:   Mon, 17 May 2021 22:11:05 +0930
Message-Id: <20210517124105.3565860-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.30.2
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
 drivers/tty/serial/8250/8250.h              | 1 +
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 1 +
 drivers/tty/serial/8250/8250_port.c         | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 52bb21205bb6..4d6f5e0ecd4c 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -88,6 +88,7 @@ struct serial8250_config {
 #define UART_BUG_NOMSR	(1 << 2)	/* UART has buggy MSR status bits (Au1x00) */
 #define UART_BUG_THRE	(1 << 3)	/* UART has buggy THRE reassertion */
 #define UART_BUG_PARITY	(1 << 4)	/* UART mishandles parity if FIFO enabled */
+#define UART_BUG_TXRACE (1 << 5)	/* UART Tx fails to set remote DR */
 
 
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
index d45dab1ab316..6c032abfc321 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1809,6 +1809,8 @@ void serial8250_tx_chars(struct uart_8250_port *up)
 	count = up->tx_loadsz;
 	do {
 		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
+		if (up->bugs & UART_BUG_TXRACE)
+			serial_in(up, UART_SCR);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		port->icount.tx++;
 		if (uart_circ_empty(xmit))
-- 
2.30.2

