Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B444C3F2C6
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 17:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5643921775
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 17:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="TiGwFnEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgCCRnp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:43:45 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:57305 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbgCCRnZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Mar 2020 12:43:25 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1D6DF23E68;
        Tue,  3 Mar 2020 18:43:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583257403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ix33EOeH4iyFZQbA3UicdowwjCiTrJGPGdI3GcWK1Xo=;
        b=TiGwFnEdtydNxA/DM3N+nGsDGqRFxTE9yAgXgqX4ykrm/ZIFzjjX/8OHm0Y/FgtH81ipCr
        /XzZJG/8V64ARj1FybxgQLYPQfYTw0UimkuslBTUAwD0xJUNlK+6hSS3hlcoUVsACND513
        C1WwNdE1yTCOT5WrHeD0vsOQhhQpP5s=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jiri Slaby <jslaby@suse.com>, Peng Fan <peng.fan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Yuan Yao <yao.yuan@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 7/9] tty: serial: fsl_lpuart: add LS1028A earlycon support
Date:   Tue,  3 Mar 2020 18:43:04 +0100
Message-Id: <20200303174306.6015-8-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303174306.6015-1-michael@walle.cc>
References: <20200303174306.6015-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 1D6DF23E68
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.496];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[14];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a early_console_setup() for the LS1028A SoC with 32bit, little
endian access. If the bootloader does a fixup of the clock-frequency
node the baudrate divisor register will automatically be set.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/fsl_lpuart.c | 51 +++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 54af8c1927ee..f443c74eee44 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1874,11 +1874,12 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
-static void
-lpuart32_serial_setbrg(struct lpuart_port *sport, unsigned int baudrate)
+static void __lpuart32_serial_setbrg(struct uart_port *port,
+				     unsigned int baudrate, bool use_rx_dma,
+				     bool use_tx_dma)
 {
 	u32 sbr, osr, baud_diff, tmp_osr, tmp_sbr, tmp_diff, tmp;
-	u32 clk = sport->port.uartclk;
+	u32 clk = port->uartclk;
 
 	/*
 	 * The idea is to use the best OSR (over-sampling rate) possible.
@@ -1924,10 +1925,10 @@ lpuart32_serial_setbrg(struct lpuart_port *sport, unsigned int baudrate)
 
 	/* handle buadrate outside acceptable rate */
 	if (baud_diff > ((baudrate / 100) * 3))
-		dev_warn(sport->port.dev,
+		dev_warn(port->dev,
 			 "unacceptable baud rate difference of more than 3%%\n");
 
-	tmp = lpuart32_read(&sport->port, UARTBAUD);
+	tmp = lpuart32_read(port, UARTBAUD);
 
 	if ((osr > 3) && (osr < 8))
 		tmp |= UARTBAUD_BOTHEDGE;
@@ -1938,14 +1939,23 @@ lpuart32_serial_setbrg(struct lpuart_port *sport, unsigned int baudrate)
 	tmp &= ~UARTBAUD_SBR_MASK;
 	tmp |= sbr & UARTBAUD_SBR_MASK;
 
-	if (!sport->lpuart_dma_rx_use)
+	if (!use_rx_dma)
 		tmp &= ~UARTBAUD_RDMAE;
-	if (!sport->lpuart_dma_tx_use)
+	if (!use_tx_dma)
 		tmp &= ~UARTBAUD_TDMAE;
 
-	lpuart32_write(&sport->port, tmp, UARTBAUD);
+	lpuart32_write(port, tmp, UARTBAUD);
+}
+
+static void lpuart32_serial_setbrg(struct lpuart_port *sport,
+				   unsigned int baudrate)
+{
+	__lpuart32_serial_setbrg(&sport->port, baudrate,
+				 sport->lpuart_dma_rx_use,
+				 sport->lpuart_dma_tx_use);
 }
 
+
 static void
 lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 		   struct ktermios *old)
@@ -2439,6 +2449,30 @@ static int __init lpuart32_early_console_setup(struct earlycon_device *device,
 	return 0;
 }
 
+static int __init ls1028a_early_console_setup(struct earlycon_device *device,
+					      const char *opt)
+{
+	u32 cr;
+
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->port.iotype = UPIO_MEM32;
+	device->con->write = lpuart32_early_write;
+
+	/* set the baudrate */
+	if (device->port.uartclk && device->baud)
+		__lpuart32_serial_setbrg(&device->port, device->baud,
+					 false, false);
+
+	/* enable transmitter */
+	cr = lpuart32_read(&device->port, UARTCTRL);
+	cr |= UARTCTRL_TE;
+	lpuart32_write(&device->port, cr, UARTCTRL);
+
+	return 0;
+}
+
 static int __init lpuart32_imx_early_console_setup(struct earlycon_device *device,
 						   const char *opt)
 {
@@ -2453,6 +2487,7 @@ static int __init lpuart32_imx_early_console_setup(struct earlycon_device *devic
 }
 OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart", lpuart_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart", lpuart32_early_console_setup);
+OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1028a-lpuart", ls1028a_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart", lpuart32_imx_early_console_setup);
 EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
 EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);
-- 
2.20.1

