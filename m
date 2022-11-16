Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4484DC4332F
	for <linux-serial@archiver.kernel.org>; Wed, 16 Nov 2022 14:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiKPOti (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Nov 2022 09:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiKPOt0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Nov 2022 09:49:26 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7A432B8B;
        Wed, 16 Nov 2022 06:49:24 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id v8so11715408qkg.12;
        Wed, 16 Nov 2022 06:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbM5jPqWMW+ZSl/JSR0+XTeoHUgjIND5CEiOvEuQtSk=;
        b=PRWc0U7J5pAZNRoK7CPP+L+WKOUezRC7GcfZGc/EkY9Oecm/u4DIcjZYj+Yyipg6sS
         178IvYFnqI1hnjr/OrvAoAgqOBmL306RkNSmdyhFWym+EKqXfwgmN8am4I/DLZs5ARpB
         ZR2CQnaskTci2KGFuk0gA+s+cRzngvkBJ2WLuV9NVelmKprPuPXee18Mfm3Z0Js4bUG/
         ZHVKd7Bunhvg7VWT8AHzqaHXUr9pk20jfFbuAxE8YNwWtNMT+INF3yo8Eh06RjJFm/xC
         RelO8ogc5Ndh7K/jqMYrTZdw2KmBzec5b2xnrUdCxa+hOczfCkyZ3pxmhCdaYeMh60je
         GaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbM5jPqWMW+ZSl/JSR0+XTeoHUgjIND5CEiOvEuQtSk=;
        b=1yFuP4mU42pRTTV3En9kpHndyNms2ZAqkUZNeNG7JJfUK4JLD7HijLMdIgIM5YOUT6
         liT+8aNn+6kT7w9pjNue4nfzGhaIjjrOQ3Y20ScEsEtcSdXSRFwJ+ZbD8Ke863s3rJr1
         +ryslLXg5oMOV2eOMuAbCEcFcbCPu7dkkm30tRfOJp46LC+Drswc84VADKDZBgNPTwpA
         I1Y6+DpuDDluPDcPoJUUH4niopXhMg7FyvIC97M8PCnR8jjAWkWNuiToM/svMQ+Zt6g6
         8fX3ejbcU7Dw10MDkjbpjJ82OTKW3n3qhCsMzxR/hC+wx2SV6qxuWL+G1IAL4YMNUd1Y
         x+1w==
X-Gm-Message-State: ANoB5pmzFTFDYkaYvQNXhUl4TpPi13vumlMXzG1MorVGXJpc/GdTsV9i
        c9a+j9wafbAfwgQTnAJ9n7BWwwEE+vf6Mg==
X-Google-Smtp-Source: AA0mqf6p2uq0pZRkd8/l6mb/PcvGZco83vJ7V5lzW2+57TlRJ0WnQO+welWA5FPATcUIc84zDS6S2Q==
X-Received: by 2002:a05:620a:3708:b0:6fa:88c:50e5 with SMTP id de8-20020a05620a370800b006fa088c50e5mr19318464qkb.186.1668610164217;
        Wed, 16 Nov 2022 06:49:24 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id g5-20020ac84805000000b0039a55f78792sm8729624qtq.89.2022.11.16.06.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:49:23 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 08/14] serial: liteuart: simplify passing of uart_insert_char() flag
Date:   Wed, 16 Nov 2022 09:49:02 -0500
Message-Id: <20221116144908.234154-9-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116144908.234154-1-gsomlo@gmail.com>
References: <20221116144908.234154-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Simply provide the hard-coded TTY_NORMAL flag to uart_insert_char()
directly -- no need to dedicate a variable for that exclusive purpose.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index c90ab65fbdcf..81aa7c1da73c 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -73,7 +73,6 @@ static void liteuart_timer(struct timer_list *t)
 	struct liteuart_port *uart = from_timer(uart, t, timer);
 	struct uart_port *port = &uart->port;
 	unsigned char __iomem *membase = port->membase;
-	unsigned int flg = TTY_NORMAL;
 	int ch;
 	unsigned long status;
 
@@ -86,7 +85,7 @@ static void liteuart_timer(struct timer_list *t)
 
 		/* no overflow bits in status */
 		if (!(uart_handle_sysrq_char(port, ch)))
-			uart_insert_char(port, status, 0, ch, flg);
+			uart_insert_char(port, status, 0, ch, TTY_NORMAL);
 	}
 
 	tty_flip_buffer_push(&port->state->port);
-- 
2.38.1

