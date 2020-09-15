Return-Path: <SRS0=fl1Y=CY=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6213C43461
	for <linux-serial@archiver.kernel.org>; Tue, 15 Sep 2020 05:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC9C2080C
	for <linux-serial@archiver.kernel.org>; Tue, 15 Sep 2020 05:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d5fpZWid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgIOFsq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Sep 2020 01:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgIOFso (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Sep 2020 01:48:44 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B746C061788
        for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2020 22:48:44 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o16so1190978pjr.2
        for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2020 22:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6P44y5mpNfyLXR4RrG6FSEEHMj+iy7zvhbL9GfNdpo=;
        b=d5fpZWid3HK1S3xeIBo+ue3RwJcRvMaqXA2dL6Lr92GKstsooZcdMke7Fq8vsiRI41
         Ey17Xc6tNlQNXNx0S2hxaCGnhuY2Y2OnpPjTzRXLub5w0N7X/JxbD8I82KLgzYJxivrl
         68MOS1P2Q86+kcaiKUH9xAmW8eP9Z7oTe1e0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i6P44y5mpNfyLXR4RrG6FSEEHMj+iy7zvhbL9GfNdpo=;
        b=phWsMPqya5CEGqiY1DZUgKFjYc5hqd4Hpe05BgQIs2G5ZYiu6BE9HzEg9Xneg+2bYY
         PYkn6JS4WvthEjDAf1kbb6IN7cvDh3dXscurjyYRgKww5RGJiwWltx0pIo64S6TzX+Pd
         9xOdAAW1hH6f414/cI9DgM1+grW6OTvZzN2PReTOibYIQBjiTcKFNnOawASLXms1p0C9
         iB4ttR41FMPgZN36+RCM/UY6rTJPaqkgJA29+ElWdScavAPlm1+VNLlopHpbu1jWDixd
         TIxNzrrCFHOtcmzzYlscpLioDAfXUsFWLi9lAKEOaSH0uEAztoKQwHAvKk8E6uXR0cwq
         62Cg==
X-Gm-Message-State: AOAM532W6LFw+hOQVlrqOKll/ABDbauhel8rXH643GQeAG40n+KHJF8h
        I2T+5VHSFuXXJRU3BkbN9X6YKMvqY3hltmjr
X-Google-Smtp-Source: ABdhPJyBoTpUYRjmNE7S4RH/HZ+Wd5QDHCdP+aOrKbrqlSzxhloY/EzG1bmXclaKkAnFOoA370xwVw==
X-Received: by 2002:a17:902:b186:b029:d1:cc21:9a7d with SMTP id s6-20020a170902b186b02900d1cc219a7dmr6444831plr.8.1600148920854;
        Mon, 14 Sep 2020 22:48:40 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id gn24sm11034935pjb.8.2020.09.14.22.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 22:48:40 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Changqi Hu <changqi.hu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH v2 1/2] tty: serial: print earlycon info after match->setup
Date:   Tue, 15 Sep 2020 13:48:25 +0800
Message-Id: <20200915054825.3289105-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

8250 devices may modify iotype in their own earlycon setup. For example:
8250_mtk and 8250_uniphier force iotype to be MMIO32. Print earlycon info
after match->setup to reflect actual earlycon info.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
Change:
v1->v2: rename function
---
 drivers/tty/serial/earlycon.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 2ae9190b64bb9..b70877932d47d 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -56,7 +56,6 @@ static void __init earlycon_init(struct earlycon_device *device,
 				 const char *name)
 {
 	struct console *earlycon = device->con;
-	struct uart_port *port = &device->port;
 	const char *s;
 	size_t len;
 
@@ -70,6 +69,12 @@ static void __init earlycon_init(struct earlycon_device *device,
 	len = s - name;
 	strlcpy(earlycon->name, name, min(len + 1, sizeof(earlycon->name)));
 	earlycon->data = &early_console_dev;
+}
+
+static void __init earlycon_print_info(struct earlycon_device *device)
+{
+	struct console *earlycon = device->con;
+	struct uart_port *port = &device->port;
 
 	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM16 ||
 	    port->iotype == UPIO_MEM32 || port->iotype == UPIO_MEM32BE)
@@ -140,6 +145,7 @@ static int __init register_earlycon(char *buf, const struct earlycon_id *match)
 
 	earlycon_init(&early_console_dev, match->name);
 	err = match->setup(&early_console_dev, buf);
+	earlycon_print_info(&early_console_dev);
 	if (err < 0)
 		return err;
 	if (!early_console_dev.con->write)
@@ -302,6 +308,7 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 	}
 	earlycon_init(&early_console_dev, match->name);
 	err = match->setup(&early_console_dev, options);
+	earlycon_print_info(&early_console_dev);
 	if (err < 0)
 		return err;
 	if (!early_console_dev.con->write)
-- 
2.28.0.618.gf4bc123cb7-goog

