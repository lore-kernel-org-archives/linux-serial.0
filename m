Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEFBC2D0C9
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C455F2073B
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="lf4Aej6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbfLMALO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:11:14 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:41956 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731540AbfLMAHu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:50 -0500
Received: by mail-pj1-f67.google.com with SMTP id ca19so336720pjb.8
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=90upK2rNWVbhL85i5hQP/jGsi5V6IZt+HmB20otgQwk=;
        b=lf4Aej6+VViJsx13yqwSVC5yLuItQAkGF92kCEBpdJP6ImeRMq3ECDiOksOWoINZTA
         oXBjj7bPK/FrXCa8PpEr+lbBwkNxflEOyl/Qdp5HwPcikT0eEjT2XFbAJ/zdWAu+mkx9
         +l81TS3tdF/8QpB9Dp5fqaogRTafmNji+4KxzXMRGtkJBgXQ5eeN4brRbT85x8s9XSFw
         m0Uq/V9lFhwua+8W6eAPzclzuUxH9QXcc+w1hZAEFwN3c/3VlFx9fA3cZLQw53ZSzFVt
         f1iTldQs/7jJY4Kd/L9VuW8f2V8dpFkPJPHK3Ksf1z8h6ykCTQFc//+jWZHKyHmGJe/l
         zIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=90upK2rNWVbhL85i5hQP/jGsi5V6IZt+HmB20otgQwk=;
        b=OsYQiK/daIqrOXIXJfyNjFuwuJdF7WOsFsB+Kzl7So5b5oqXM/2KNZ4I3vCSzxYDcR
         IQP3RbhS23pudCpSEynbfbnmTOY4TKGKo7zQoXgP7y+rW5eE8WWjFEnAI1/kfdynMtdb
         f1SobEDKoa+qbYbYFvAYD5p8g+JacIy4zJ2YP8XMg5fe064RxzP3yHUXbP+o1KCu3l/H
         5tFgdcJZ8YJCJ4/AWj7D8X8or8BGNPPIwAf4zG4WY3ctjlhXaaX54uriz3C9Gzw/Ebsb
         5TZ/eYnEIoxBw9MAiio8MNVLjDucx8qN+bCai8VwkbfCRYkDLtdzRX9PM8X/Y9VPAFQi
         Z3ZA==
X-Gm-Message-State: APjAAAUTx/GnrcDc4qoIo+8+7JCBdrQUfRhf5uY5hi0QXDcBhGPpZ+XW
        XaWekzW0uN0uOwslWc+m8xOqdQ==
X-Google-Smtp-Source: APXvYqyok9Kicleir7Xd8YV5SWVEkQodaxMdZkamceeJ64Z0/AdH1eoy7toZYsJlUIwn6MPBrJuoPA==
X-Received: by 2002:a17:90a:1b6b:: with SMTP id q98mr13390438pjq.106.1576195669296;
        Thu, 12 Dec 2019 16:07:49 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:48 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/58] tty/serial: Migrate atmel_serial to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:11 +0000
Message-Id: <20191213000657.931618-13-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The SUPPORT_SYSRQ ifdeffery is not nice as:
- May create misunderstanding about sizeof(struct uart_port) between
  different objects
- Prevents moving functions from serial_core.h
- Reduces readability (well, it's ifdeffery - it's hard to follow)

In order to remove SUPPORT_SYSRQ, has_sysrq variable has been added.
Initialise it in driver's probe and remove ifdeffery.

While at it, remove forward-declaration of atmel_console - it wasn't
needed even at the moment the driver was first time introduced:
commit 1e6c9c2878c9 ("[ARM] 3242/2: AT91RM9200 support for 2.6 (Serial)")

Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Richard Genoud <richard.genoud@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/atmel_serial.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index a8dc8af83f39..4020fc8ceb49 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -51,10 +51,6 @@
 #define ATMEL_RTS_HIGH_OFFSET	16
 #define ATMEL_RTS_LOW_OFFSET	20
 
-#if defined(CONFIG_SERIAL_ATMEL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/serial_core.h>
 
 #include "serial_mctrl_gpio.h"
@@ -196,10 +192,6 @@ struct atmel_uart_port {
 static struct atmel_uart_port atmel_ports[ATMEL_MAX_UART];
 static DECLARE_BITMAP(atmel_ports_in_use, ATMEL_MAX_UART);
 
-#ifdef SUPPORT_SYSRQ
-static struct console atmel_console;
-#endif
-
 #if defined(CONFIG_OF)
 static const struct of_device_id atmel_serial_dt_ids[] = {
 	{ .compatible = "atmel,at91rm9200-usart-serial" },
@@ -2877,6 +2869,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	atmel_port = &atmel_ports[ret];
 	atmel_port->backup_imr = 0;
 	atmel_port->uart.line = ret;
+	atmel_port->uart.has_sysrq = IS_ENABLED(CONFIG_SERIAL_ATMEL_CONSOLE);
 	atmel_serial_probe_fifos(atmel_port, pdev);
 
 	atomic_set(&atmel_port->tasklet_shutdown, 0);
-- 
2.24.0

