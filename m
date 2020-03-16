Return-Path: <SRS0=SyHF=5B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC0EC0044D
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 10:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A231F2071C
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 10:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ7iXmOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgCPKTq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:19:46 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34545 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730553AbgCPKTq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Mar 2020 06:19:46 -0400
Received: by mail-pj1-f66.google.com with SMTP id q16so1244810pje.1;
        Mon, 16 Mar 2020 03:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mWF1mQ7ZH4dg5Dr7L5zKSdzNMwdVYCRVhY+EMksJxOo=;
        b=LJ7iXmOuTKPxZkgTcGBgDAnK+VK2q3usX2xdwbp7ITK+LoCu/8qPz0N54iWF3nGaWp
         OhlCQf1eSRDI8VuPqJ3GAiAtsMFMzZ8tmxJZDqmGrA35m6uln2FqytbTJo1ibGhiQwmx
         pQTCiFHW/Tcl+VfItDhiU+BqJoW+aODvmMujOS9vkRJ7BcCDFhkk2CMpOwnrW1NAAclO
         t5abM5+3IA92SJf3Mpm1F9HqSItWAbec8WTXN8iGTEGmSp+7KCUhyoDqcqsOAAlQT8pG
         UAVnYZszIq8DXU+yUXyTig9Ok1mt59zl+SX/Ra8DIgPmJLWYKvqhveDY5zx4+2w7LHzw
         pILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mWF1mQ7ZH4dg5Dr7L5zKSdzNMwdVYCRVhY+EMksJxOo=;
        b=ALFj9lTqY0ZFUeJrSa16Uf//MPDMMZBC2kYIDMTyxPpB565vkaM1whusv5Lhj651Y6
         KPW77+H7jh5OWDKKLmm1OBenrkpBgQpTcY9oOru2c8ZQLe0enQe1i4VyVkFL+ShW9HBx
         tBM0TqFVjkbfgGxQ8XTS77BBCiv5XMACTJd5ibW63VRmq02/LrrJqj2AdNM3k1lwj51F
         KPA5B+IJjhq/YZQ3hkJ1Ax7Ir3xHty9omHd4kLXEPm1/1WIlNxQ9X0TO1zxV47+qR+1l
         7RkBRdif3Z5oKdPLLxHVxss6M6a0KMb3BS4P6Sqco5vdlEAfSD/54JxvTRrW0ybkhSdy
         Joaw==
X-Gm-Message-State: ANhLgQ0B0732/ddbDOD3KISypCzDKKITXin8nUTUoQhk1+/vpPI8GJ8Z
        ZHMx1Bg7KKdupR46IIX1dN5Ceox8
X-Google-Smtp-Source: ADFU+vtWV3aRcYN3eBSXu291bkp5ZnP80f0tTep9FcnaUHMlvQbQ+2ptU0rgh/F6d2PoVWJwnk1Ijg==
X-Received: by 2002:a17:90a:714a:: with SMTP id g10mr24457931pjs.155.1584353984512;
        Mon, 16 Mar 2020 03:19:44 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u3sm21676491pfb.36.2020.03.16.03.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 03:19:43 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 2/3] serial: sprd: remove __init from sprd_console_setup
Date:   Mon, 16 Mar 2020 18:19:29 +0800
Message-Id: <20200316101930.9962-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316101930.9962-1-zhang.lyra@gmail.com>
References: <20200316101930.9962-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The function sprd_console_setup() would be called from .probe() which can
be called after freeing __init functions, for example the .probe() would
return -EPROBE_DEFER since it depends on clock modules.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/tty/serial/sprd_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 18706333f146..914862844790 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1013,7 +1013,7 @@ static void sprd_console_write(struct console *co, const char *s,
 		spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static int __init sprd_console_setup(struct console *co, char *options)
+static int sprd_console_setup(struct console *co, char *options)
 {
 	struct sprd_uart_port *sprd_uart_port;
 	int baud = 115200;
-- 
2.20.1

