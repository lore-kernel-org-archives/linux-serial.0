Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ED8C10DCE
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 08:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161B020753
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 08:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHuYa0ft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgCRIbb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:31:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42357 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgCRIbb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 04:31:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id h8so13255419pgs.9;
        Wed, 18 Mar 2020 01:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iZajfuLlwwvoieDzcgFOBiOg5tee4mEACfY8TbSb56U=;
        b=mHuYa0ftHNzsfWROq+4uoaGwPMXRKtWUCRoxdnH72RRijhTqcF17Lu9Jx3xejPuoli
         DuZwdmSq+QIOJ0fo9qx0yTipEuixYdC93etaJE/eAftr13kgVjmTe9st27MuRtTx0mGT
         /GwmAEZuRNZFyxE67i7pqI/Wutmwi4++dpgWn8n8KBTnHuV1HFzQTOGHT2pM5eq+hIhk
         3NFYqNsjZ3y7edVZaZm3u3GsAdWClNEK6/uaRSCKWZh/rveuDTiufntvbglUBdByZpXw
         ksKxRgdWT5rex1mMsqMDjPZ5v4tEyD4zAaCHGuFsqbmreyWO7Q3IUWLmTJs7fptvWvZg
         OMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iZajfuLlwwvoieDzcgFOBiOg5tee4mEACfY8TbSb56U=;
        b=B4R9xVgXgdW7Gsu/9NlHSDv58eSaLcuSv19Cv1AuQ5sT47Z6FX6s7ibAI1Ua031QM/
         C/fimiY+6pnpkJTJerx/wtcNZNLgAqszD9m1uT4DFJPoFEV+nIHC5EQuEEHbDNOzDWij
         5lQkMzgelsLiq2ADGfzFWz7c4x/j/rLdpjp9ChEKoY3rbKgbhMyR64wbpn6vCdYEnVN4
         njgwR58MTY1Zlsuy9SvkYngV4Yf6sW/SYSZxbcUxEcB+4oHa8IItHuEcfLJmCRwOzBNb
         RlRoIOsFeR+2Oib1DiosS6MWBUdvO3uemewzOZy9A6qxwkzcIoOXZjAdMKsA+af9q8+b
         V7oQ==
X-Gm-Message-State: ANhLgQ0n9Xj6wBz4qyKYw7BYKPPH2XJhj2z61eQDFKlV39YGkj6QjHKf
        thdFbqNrVyeTt6Cp1IZjZV4=
X-Google-Smtp-Source: ADFU+vsrdWvEkXSuFDD1PBY1foEOqE0caf8luPW6mZ73fdifDSNpPEZ/YAFbOaP/Rv8tTeBoZ7L2dg==
X-Received: by 2002:aa7:9790:: with SMTP id o16mr3225388pfp.322.1584520290204;
        Wed, 18 Mar 2020 01:31:30 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c11sm5894326pfc.216.2020.03.18.01.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 01:31:29 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v2 1/2] serial: sprd: getting port index via serial alias only
Date:   Wed, 18 Mar 2020 16:31:19 +0800
Message-Id: <20200318083120.13805-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This patch simplifies the process of getting serial port number, with
this patch, serial devices must have alias configured in devicetree.

The serial port searched out via sprd_port array maybe wrong if we don't
have serial alias defined in devicetree, and specify console with command
line, we would get the wrong port number if other serial ports probe
failed before console's. So using alias is mandatory.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/tty/serial/sprd_serial.c | 36 +++++---------------------------
 1 file changed, 5 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 914862844790..9f8c14ff6454 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1102,29 +1102,6 @@ static struct uart_driver sprd_uart_driver = {
 	.cons = SPRD_CONSOLE,
 };
 
-static int sprd_probe_dt_alias(int index, struct device *dev)
-{
-	struct device_node *np;
-	int ret = index;
-
-	if (!IS_ENABLED(CONFIG_OF))
-		return ret;
-
-	np = dev->of_node;
-	if (!np)
-		return ret;
-
-	ret = of_alias_get_id(np, "serial");
-	if (ret < 0)
-		ret = index;
-	else if (ret >= ARRAY_SIZE(sprd_port) || sprd_port[ret] != NULL) {
-		dev_warn(dev, "requested serial port %d not available.\n", ret);
-		ret = index;
-	}
-
-	return ret;
-}
-
 static int sprd_remove(struct platform_device *dev)
 {
 	struct sprd_uart_port *sup = platform_get_drvdata(dev);
@@ -1204,14 +1181,11 @@ static int sprd_probe(struct platform_device *pdev)
 	int index;
 	int ret;
 
-	for (index = 0; index < ARRAY_SIZE(sprd_port); index++)
-		if (sprd_port[index] == NULL)
-			break;
-
-	if (index == ARRAY_SIZE(sprd_port))
-		return -EBUSY;
-
-	index = sprd_probe_dt_alias(index, &pdev->dev);
+	index = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (index < 0 || index >= ARRAY_SIZE(sprd_port)) {
+		dev_err(&pdev->dev, "got a wrong serial alias id %d\n", index);
+		return index;
+	}
 
 	sprd_port[index] = devm_kzalloc(&pdev->dev, sizeof(*sprd_port[index]),
 					GFP_KERNEL);
-- 
2.20.1

