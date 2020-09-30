Return-Path: <SRS0=IvhS=DH=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADF2C2D0A8
	for <linux-serial@archiver.kernel.org>; Wed, 30 Sep 2020 08:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD4A206C3
	for <linux-serial@archiver.kernel.org>; Wed, 30 Sep 2020 08:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCO0WZF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgI3IPR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 30 Sep 2020 04:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgI3IPQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 30 Sep 2020 04:15:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F10C061755;
        Wed, 30 Sep 2020 01:15:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l126so657057pfd.5;
        Wed, 30 Sep 2020 01:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R35UUTJMurgzHTEafJYZTtjQpMJxWZuFDoF37yOkcQI=;
        b=oCO0WZF93LZom3p+7Exyf36KYLBTH+Vg4OU1Fk9w1nLfafBwxftGcp/uFPpvWYZ5ME
         LXgDDJKRA6lI0Mmy4XV4ZE3iyMsgCUEF5bczv39NaV/dy3ZT+L2M/Z0rRrM2pgDaUV08
         xc78QnBdQZAWntkrH7d3rJbkTup1A9qX32GX9yeOpmzDneQqdeDwm+QJYvWcBg1bIZst
         s6Jys4LvRS+YgogB1ckqawQi77x7n4SbuHcq4jynzQ9HBCLv0LPEzVJtJ5fI8UmGnUUu
         fiZ2zqv6qZt5a9DuCnLuufO8Fsr29JxIdBvOOZceTYzQNRddc3z9ioql/AzsylYhYBh2
         FVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R35UUTJMurgzHTEafJYZTtjQpMJxWZuFDoF37yOkcQI=;
        b=h8SEXdkzzLSH8uhr5KRxBl0Z+ilEQ1VBK9QhBBAcFEoAuJwHDWySez7utDgXgwbk6i
         0MBdg9M8OiJVXH/8Ha42cbYD6hZwFLnfxLdvpX0J+2BZVPXUPYGkaVMNODBGF9bZwrgj
         6BaeQ0VxSpE2pf/Iaj+kNJlSVvyStk9UNaJiLCFM7H8pOq4LGKzHvwGYvtG9BWnFR0hv
         nlsDtnc2GA37Hf8l4rgdIkoa+iTWBxqv7siTKma5YcAvFPj6OtZBfEvuPIdZ39D1Je9G
         zu08XpwBhaOh5B02qB1mLalBQIrBe1ZQqcxQSlf659J7dkn1Z/kaVP22NuEmjQABp4LZ
         3rDQ==
X-Gm-Message-State: AOAM530WYxhb1f3BnFihr5sRDSvSvN38UPj6l9MYOf9ngOoLvqAuVX0Z
        S2vTQ0dUvx+BVUx/Iv4Arw==
X-Google-Smtp-Source: ABdhPJyoP2JOVUZou7mzbgih+WLmU0/MgzGa7mx4dbmq8QnnAnfd/u10joRGySLrvFVHgnckJTGXvg==
X-Received: by 2002:a63:c1e:: with SMTP id b30mr1267597pgl.345.1601453715878;
        Wed, 30 Sep 2020 01:15:15 -0700 (PDT)
Received: from localhost.localdomain ([47.242.140.181])
        by smtp.gmail.com with ESMTPSA id 1sm1371684pgm.4.2020.09.30.01.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 01:15:14 -0700 (PDT)
From:   Pujin Shi <shipujin.t@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, hankinsea@gmail.com,
        shipujin.t@gmail.com
Subject: [PATCH] tty: serial: mvebu-uart: Remove unused variable 'ret'
Date:   Wed, 30 Sep 2020 16:14:59 +0800
Message-Id: <20200930081459.1269-1-shipujin.t@gmail.com>
X-Mailer: git-send-email 2.18.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

'ret' variable is now defined but not used in mvebu_uart_probe(),
causing this warning:

  drivers/tty/serial/mvebu-uart.c: In function ‘mvebu_uart_probe’:
  drivers/tty/serial/mvebu-uart.c:806:6: warning: unused variable ‘ret’ [-Wunused-variable]

Signed-off-by: Pujin Shi <shipujin.t@gmail.com>
---
 drivers/tty/serial/mvebu-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 7443c0506eb4..118b29912289 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -803,7 +803,7 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 							   &pdev->dev);
 	struct uart_port *port;
 	struct mvebu_uart *mvuart;
-	int ret, id, irq;
+	int id, irq;
 
 	if (!reg) {
 		dev_err(&pdev->dev, "no registers defined\n");
-- 
2.18.1

