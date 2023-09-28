Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333FBE732DF
	for <linux-serial@archiver.kernel.org>; Thu, 28 Sep 2023 14:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjI1O66 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Sep 2023 10:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjI1O66 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Sep 2023 10:58:58 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE31194
        for <linux-serial@vger.kernel.org>; Thu, 28 Sep 2023 07:58:57 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3ae473c0bd6so1079207b6e.0
        for <linux-serial@vger.kernel.org>; Thu, 28 Sep 2023 07:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695913136; x=1696517936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=srhsfwizfjHK3WOc++jYyBx3URfwhs3dX8xRl/CFbCg=;
        b=Y+qwHYKFdppEuVPD6W4MAevaJsdXCErp6nqZ1gfAPJ0NXuG7etR2SCLPUWAx5I0IWu
         GKeWH2X3y1J6byCHJSX2ya5rB0DY7/iEryy9pfwdGUSJKv2AJkHi7Y7EoE0310mDTmJi
         7H70kWOG4Mbk2/WbgeUWhWGnQMF0QBrch2z3hpFY1JmI7DwglSJdZJUmxfSFceBpyIMW
         FPYJGIQmQwRLjTeYG3zeZdkvR2DSs0ffBobD2hMbYqFX5944v/6yTqjESzOJprmhnkOG
         AB7N4tkbZboZgmr6lYMSN2lCW0VJQK44ehpDGp2S3rHt4/hca+by0FksK1ICO6c7CRba
         fmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695913136; x=1696517936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srhsfwizfjHK3WOc++jYyBx3URfwhs3dX8xRl/CFbCg=;
        b=gLZ8p397zX6RIYxFKObSYDh683Ue1erKBoqFXiXQU7oTSoTvWtiiB5EhMxLUI9jCp6
         V4+dMWnh0Art9Y0Tbb+yoPsx1bCEkb+E7UeaVtdgRjjIbbHHJ6k6W8n0ZniysFAYYn62
         kcPUq3m2tvXSy0T1dX0OrbxUEze2WPN8SXcoL7fpw1RqWkKMWpSfjtQGvRj7L/NHE0Vc
         TQ8BoLsD9J2r8x/G99N46tyNjp54wZWByTUGzubjeMAD3Euaoa1IqOcaMaAyGVRpwhSM
         v0o+6IeeJRcDw6gDCai68x4+L3G52DwS+sPaSIPGRDhio6jDmkk637IYfwLxake1+W4x
         4bxA==
X-Gm-Message-State: AOJu0Yw57uo+3CElM9hZWkRQdSBM6SsbzCxKjU+In+19g2AvSQxA8KqV
        sfPRR8STg3PDFJ3UqFefxjQ=
X-Google-Smtp-Source: AGHT+IGKbfID/AmEiCcoaLZK18KaC+DnlmJQRQ53DDx8fEtuFj3zl8teRLRuZrrXhGsUfV8arXLNGA==
X-Received: by 2002:a05:6808:1491:b0:3a9:e8e2:579d with SMTP id e17-20020a056808149100b003a9e8e2579dmr1801023oiw.2.1695913129323;
        Thu, 28 Sep 2023 07:58:49 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:386c:ba81:a385:9374])
        by smtp.gmail.com with ESMTPSA id z22-20020aa791d6000000b0068a0c403636sm13438128pfa.192.2023.09.28.07.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 07:58:48 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux@armlinux.org.uk, linux-serial@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH] serial: amba-pl011: Do not complain when DMA is absent
Date:   Thu, 28 Sep 2023 11:58:42 -0300
Message-Id: <20230928145842.466933-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

Many SoCs do not integrate DMA for the amba pl011 UART, causing
the following message on boot:

uart-pl011 80074000.serial: no DMA platform data

The UART still works in PIO, so better not to print such message that
may confuse people by causing them to think that there is something wrong
with the UART.

Change the message to debug level.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 41eabad4c94b..61cc24cd90e4 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -421,7 +421,7 @@ static void pl011_dma_probe(struct uart_amba_port *uap)
 
 		/* We need platform data */
 		if (!plat || !plat->dma_filter) {
-			dev_info(uap->port.dev, "no DMA platform data\n");
+			dev_dbg(uap->port.dev, "no DMA platform data\n");
 			return;
 		}
 
-- 
2.34.1

