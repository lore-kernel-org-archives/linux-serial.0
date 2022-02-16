Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946A0C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 16 Feb 2022 16:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbiBPQSu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:18:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbiBPQSt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Feb 2022 11:18:49 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8561FFF7D
        for <linux-serial@vger.kernel.org>; Wed, 16 Feb 2022 08:18:36 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 24F3922246;
        Wed, 16 Feb 2022 17:18:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645028307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7AB8VBpyFBQKRoN6d6vVzUF8grAsjn3IGpYvohsqVUY=;
        b=XUlEGO8/0o2gpwuSbOUUklB3WX45dX2DxfaFJ6f1VD0048KatWTVsWqKE/7woCd3Ugw6p4
        DkRS8IPWyqCSQ3fDD+iDtpJxSx3HlcgHThKAQKDb4XigY4r9hTsjykgZEtbF3x+s5OxH1m
        Bjb2M/z+NdUeUfAibmlZA2gir71oT1A=
From:   Michael Walle <michael@walle.cc>
To:     Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH] tty: serial: atmel: add earlycon support
Date:   Wed, 16 Feb 2022 17:18:22 +0100
Message-Id: <20220216161822.1071245-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add early console support which relies on the bootloader for the
initialization of the UART.
Please note, that the compatibles are taken from at91-usart MFD
driver.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/tty/serial/atmel_serial.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 2d09a89974a2..50fc6d51ff0d 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2673,6 +2673,30 @@ static struct console atmel_console = {
 	.data		= &atmel_uart,
 };
 
+static void atmel_serial_early_write(struct console *con, const char *s,
+				     unsigned int n)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, n, atmel_console_putchar);
+}
+
+static int __init atmel_early_console_setup(struct earlycon_device *device,
+					    const char *options)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->con->write = atmel_serial_early_write;
+
+	return 0;
+}
+
+OF_EARLYCON_DECLARE(atmelserial, "atmel,at91rm9200-usart",
+		    atmel_early_console_setup);
+OF_EARLYCON_DECLARE(atmelserial, "atmel,at91sam9260-usart",
+		    atmel_early_console_setup);
+
 #define ATMEL_CONSOLE_DEVICE	(&atmel_console)
 
 #else
-- 
2.30.2

