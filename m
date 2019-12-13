Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179B8C00454
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE9C206E2
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="pAhylW84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbfLMALS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:11:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43987 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731397AbfLMAHi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id h14so375005pfe.10
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ht926qJSnvFGYIB9K4O+nNF4O0GCYV2PIQMqyDhIY5k=;
        b=pAhylW84Ppk1pzQ07cJ1GCoqAdv+PqaHjW642NqJkc81qr3/BsO1kzzIV+BxYI8KJX
         v9yTtPYVQlJMZuz72or3lFYMBEFW6qZx9BLjNTipBf0mRr0Ldyfnt2Omlz0ogqyTJGrj
         kZcx3UYqZ/dx7jXcXzBk/vaClRf7gjx1/mi55jkyiIcvUU/xzH2VMeQTmcq8+jRv+010
         h3HWaYmF2Jof57rK5I49kt7xMb0qjvp5HLlTnQiLUIqUf23RkLT1zF2bntEymIlnFn5+
         MI3/yaUhVKiz/oPzU+Wm5tN4v3m6jlv5ZvpNuqqprA10sYLna8sxyoJ4d9Hmc0drxyDL
         b1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ht926qJSnvFGYIB9K4O+nNF4O0GCYV2PIQMqyDhIY5k=;
        b=NRpNCc68P8qotvHVPBlmk1TgCFCCywMkXaH7KajdBnk0b6uIC8QXX1tJUHC2YzQDw5
         XPKzDgzsoMGpOhJSQl4HdZXb6MwJBOOpSHp1lQQQ6M1+iQEZcGEoTcsYrM518Gv7Cn5g
         0mMr4qRF/SKtsGrUw6ut1yZ1yA2PykYP3V4zgLtqRxblmuPHVlnEpTDfhATMKMy63qgw
         ZPcDHWPRqiNa9ipnMsav2WhMw9nDpsPYuyCVZ1yB1MOuUYDLRTZyyAsjbi5eqXbjFTq1
         vvlqhWS/2+cl7PEjWlAdkzJQAMZKK1IE2+otwQEGw2ukZYVb5Zxo04HtZYXbn2erjdyE
         q6Lw==
X-Gm-Message-State: APjAAAUIQyDoutmGzOqpS5YlFWZ2E3439LKm77ReQpW+hol7TxxDDxFl
        aQ2SCdtugPyR0eXw+o0+P4Fojw==
X-Google-Smtp-Source: APXvYqylue42aFMD17i+b85QMKbex5T+5d6XmumWHoNiwhyBRGK276IyodScoTiKLMJ9kqwqnXofjA==
X-Received: by 2002:a63:4b48:: with SMTP id k8mr13646417pgl.362.1576195657625;
        Thu, 12 Dec 2019 16:07:37 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:36 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 08/58] tty/serial: Migrate 8250_port to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:07 +0000
Message-Id: <20191213000657.931618-9-dima@arista.com>
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

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/8250/8250_port.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 90655910b0c7..8243f280a2ec 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -11,10 +11,6 @@
  *  membase is an 'ioremapped' cookie.
  */
 
-#if defined(CONFIG_SERIAL_8250_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/ioport.h>
@@ -3055,6 +3051,7 @@ void serial8250_init_port(struct uart_8250_port *up)
 
 	spin_lock_init(&port->lock);
 	port->ops = &serial8250_pops;
+	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 
 	up->cur_iotype = 0xFF;
 }
-- 
2.24.0

