Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D39C433EF
	for <linux-serial@archiver.kernel.org>; Sun, 14 Nov 2021 18:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F423361152
	for <linux-serial@archiver.kernel.org>; Sun, 14 Nov 2021 18:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbhKNSmJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 14 Nov 2021 13:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbhKNSmH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 14 Nov 2021 13:42:07 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B643DC061766
        for <linux-serial@vger.kernel.org>; Sun, 14 Nov 2021 10:39:12 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r132so10491258pgr.9
        for <linux-serial@vger.kernel.org>; Sun, 14 Nov 2021 10:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=accesio-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=anHNcea/d5M+SiTjUt2VJ9/z3vYkBDxBcoFnPfcwYoI=;
        b=4/vWfl2nYUKNPwbF2CZxcEBYJl36smceEm/mmgIUsyXciSUpY8QlGErrqTHNubOVL2
         nIJPkAunoU+Tl4Kvz59Vvozv7Hez5vFblMf4pO3oOC/sQ51hVmalaYAHsMfKFe4FYCaf
         DCkrJr5YWwj5KlFx6me2qkPE38vaI2DLAdvC7g4t11JkSig/+bgnS3qcgTQYIcSco4iN
         znZnNeGbrGNq/YsiTZ4/gnjiBQcyX4aEkF0WWAJE+tCS5lbf2DY9os2ukZ2JcctrRQIu
         oM6G/frSFHsrE2roI/CYsY/13TfsqAylglM9popxTO34Biikt/36QIDSxrf91ZJHrNTr
         2QrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=anHNcea/d5M+SiTjUt2VJ9/z3vYkBDxBcoFnPfcwYoI=;
        b=e3iiKXS3pk1EgcH3J4IpO+C9QuCTSpQGmGT/+wOCMHi788JiVJyWkmQCVNKPHEU/5z
         R/eFuuahGK+D2BEajEFNOLbSU/nfzAuebaMhZkqgkLj73AmaH89R01zy6Kvbvxi327fQ
         L+Ft/Vf1VP8psQvlpfb573TUWbVJ+8qUheMmsN6Br3YmCartfP7zRQauoxP0U/4GVbDi
         VC8a0p5GZhQbZhu9ozZ8zPAcvKqpMWTIkZhmuEQKEtdmNbENTsJhMEkHdH6cCx1WYris
         /V7ldcICRvW4/m/PsW/Np/A3GQPA+am0LoT+nH3wUPF6JRc4GSrzhzbWytohV3C8916o
         YNFQ==
X-Gm-Message-State: AOAM532kdkKO6yNCSNl0w6+hnU+W9LfBTHejWqPKqaGL3vYLpOBfI/dD
        0dBxN5L6CzPualCoJIEe6wub304Vtnond2zVWtyd5timWzHwvXanjVc2rM8ETaHOTftyL93Ifqr
        yUrE5/T+HyN5QegO5necVxi7JRHBnk/bXWE432wcvMGEajTsKvUNgXzHcesW9iHz7DuiA2ngGwu
        nMEs8=
X-Google-Smtp-Source: ABdhPJwuS1wwoXaKBv3PctVv+RCIILlNEohs6JGvYLk9XvuRIaKT/2pc5mnAM5EKqxcFeThKiYoRow==
X-Received: by 2002:a62:8082:0:b0:494:61a:1f62 with SMTP id j124-20020a628082000000b00494061a1f62mr28464578pfd.29.1636915151888;
        Sun, 14 Nov 2021 10:39:11 -0800 (PST)
Received: from work-laptop.dolannet.net ([98.149.220.160])
        by smtp.gmail.com with ESMTPSA id y130sm12551642pfg.202.2021.11.14.10.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 10:39:11 -0800 (PST)
From:   Jay Dolan <jay.dolan@accesio.com>
To:     linux-serial@vger.kernel.org
Cc:     Jay Dolan <jay.dolan@accesio.com>
Subject: [PATCH 1/3] serial: 8250_pci: rewrite pericom_do_set_divisor
Date:   Sun, 14 Nov 2021 10:39:06 -0800
Message-Id: <20211114183908.444923-2-jay.dolan@accesio.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211114183908.444923-1-jay.dolan@accesio.com>
References: <20211114183908.444923-1-jay.dolan@accesio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixes: 6bf4e42f1d19de10800f4483b4bb7945aab283cb

Have pericom_do_set_divisor() use the uartclk instead of a hardcoded
value to work with different speed crystals. Tested with 14.7456 and 24
MHz crystals
Have pericom_do_set_divisor always calculate the divisor rather than
call serial8250_do_set_divisor() for rates below baud_base.
Do not write registers or call serial8250_do_set_divisor() if valid
divisors could not be found.

Signed-off-by: Jay Dolan <jay.dolan@accesio.com>
---
 drivers/tty/serial/8250/8250_pci.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 5d43de143f33..aea43683b76d 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1325,28 +1325,32 @@ pericom_do_set_divisor(struct uart_port *port, unsigned int baud,
 	int scr;
 	int lcr;
 	int actual_baud;
-	int tolerance;
+	int divisor;
 
-	for (scr = 5 ; scr <= 15 ; scr++) {
-		actual_baud = 921600 * 16 / scr;
-		tolerance = actual_baud / 50;
+	for (scr = 16 ; scr > 4 ; scr--) {
+		if (baud > (port->uartclk / scr) + (baud/50))
+			continue;
 
-		if ((baud < actual_baud + tolerance) &&
-			(baud > actual_baud - tolerance)) {
+		divisor = port->uartclk / scr / baud;
+		if (divisor == 0 ||
+			port->uartclk / scr / divisor - baud > baud/50) {
+			divisor++;
+		}
+
+		if (divisor > 0xffff)
+			continue;
 
+		actual_baud = port->uartclk / scr / divisor;
+		if (abs(actual_baud - baud) < baud/50) {
 			lcr = serial_port_in(port, UART_LCR);
 			serial_port_out(port, UART_LCR, lcr | 0x80);
-
-			serial_port_out(port, UART_DLL, 1);
-			serial_port_out(port, UART_DLM, 0);
+			serial_port_out(port, UART_DLL, divisor & 0xff);
+			serial_port_out(port, UART_DLM, divisor >> 8 & 0xff);
 			serial_port_out(port, 2, 16 - scr);
 			serial_port_out(port, UART_LCR, lcr);
 			return;
-		} else if (baud > actual_baud) {
-			break;
 		}
 	}
-	serial8250_do_set_divisor(port, baud, quot, quot_frac);
 }
 static int pci_pericom_setup(struct serial_private *priv,
 		  const struct pciserial_board *board,
-- 
2.25.1

