Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD06FC54EBD
	for <linux-serial@archiver.kernel.org>; Mon,  9 Jan 2023 07:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjAIHMB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Jan 2023 02:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjAIHL7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Jan 2023 02:11:59 -0500
X-Greylist: delayed 587 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Jan 2023 23:11:58 PST
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A36DFD2
        for <linux-serial@vger.kernel.org>; Sun,  8 Jan 2023 23:11:57 -0800 (PST)
From:   Tobias Schramm <t.schramm@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1673247725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oCppCv1oBsre+FVN86oFN46fKVCfGcF37Evg0UDVbMg=;
        b=lXde/TaEiwxChv4sBX/aT/8+A5We1Huz6H/ExEvgCIS96gaNehxWUSxhbYoeFnuf5ZDWfq
        iciIAbeKcl8VwT3kJIBvZPvL59pG5dS9H5WzfbjTWD1uR0LP45A/0vV2VT7nO/IOBNLe1h
        rH6TlalMTyuBtilnFyNOF61AHaxmBW+zs2evkFWG0nmqMzyR7HeRh7xq4JlNi3FjNcfh0L
        tkCcOpiuVCRj3hti8bA/WVK8HeqxlsJhTD93CSqUBV4KF/tqZ8ctnXb0jl6uFmR1P6OPhD
        YT/zm94sVU3AUThynErZiXiPOdzNv2evc35h1P7O6QCqBBMQvJjLzjIzrrvMOA==
To:     Richard Genoud <richard.genoud@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH] serial: atmel: fix incorrect baudrate setup
Date:   Mon,  9 Jan 2023 08:02:00 +0100
Message-Id: <20230109070200.200181-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=t.schramm@manjaro.org smtp.mailfrom=t.schramm@manjaro.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit ba47f97a18f2 ("serial: core: remove baud_rates when serial console
setup") changed uart_set_options to select the correct baudrate
configuration based on the absolute error between requested baudrate and
available standard baudrate settings.
Prior to that commit the baudrate was selected based on which predefined
standard baudrate did not exceed the requested baudrate.
This change of selection logic was never reflected in the atmel serial
driver. Thus the comment left in the atmel serial driver is no longer
accurate.
Additionally the manual rounding up described in that comment and applied
via (quot - 1) requests an incorrect baudrate. Since uart_set_options uses
tty_termios_encode_baud_rate to determine the appropriate baudrate flags
this can cause baudrate selection to fail entirely because
tty_termios_encode_baud_rate will only select a baudrate if relative error
between requested and selected baudrate does not exceed +/-2%.
Fix that by requesting actual, exact baudrate used by the serial.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 drivers/tty/serial/atmel_serial.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index f1c06e12efa0..9cd7479b03c0 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2657,13 +2657,7 @@ static void __init atmel_console_get_options(struct uart_port *port, int *baud,
 	else if (mr == ATMEL_US_PAR_ODD)
 		*parity = 'o';
 
-	/*
-	 * The serial core only rounds down when matching this to a
-	 * supported baud rate. Make sure we don't end up slightly
-	 * lower than one of those, as it would make us fall through
-	 * to a much lower baud rate than we really want.
-	 */
-	*baud = port->uartclk / (16 * (quot - 1));
+	*baud = port->uartclk / (16 * quot);
 }
 
 static int __init atmel_console_setup(struct console *co, char *options)
-- 
2.30.2

