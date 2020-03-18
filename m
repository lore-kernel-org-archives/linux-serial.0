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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE4AC5ACD6
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E09F20768
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 10:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TafRyY03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgCRKv2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:51:28 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33285 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRKv2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 06:51:28 -0400
Received: by mail-pj1-f68.google.com with SMTP id dw20so1033559pjb.0;
        Wed, 18 Mar 2020 03:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RFCqkk9G7v0hEiTj+pktV1iDnOwW2a7UQAQlvqLPDVI=;
        b=TafRyY03ELWWWVZ9m7cQwqtr32Ip9+Mmqtu0CiPWy+Eb1USfP9ehbiONtHEpLsNbuj
         z0L7wF8g66vIEwSp7GZ/39o/yeY5kUfYQqOjongAVRvcu0aF6UwP8phnWQs+3rJhbVIq
         ZcdPNN3LcahD/tTdWynfVynrBcrPDY5rJEedxZmOwHBbz1OY67Rf6aRqb99XKbpA4+V0
         l9REVIjfPboRdTdcMj5VOErADHk2VE/JlsbV1vyhFUul5Luv36UhZ4idOmb6kYmAYRE4
         wTWoqQ8QJfNRNlPxsHiOje1dNoH1vc+OyLItfhUfCsQMKzsKVIYlTqsIjguENpOduwvI
         B9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RFCqkk9G7v0hEiTj+pktV1iDnOwW2a7UQAQlvqLPDVI=;
        b=QQK8UEUnGMejf5c6gEEb9/vwC0+EhdJ40rT9UMmDH2QQkLpvt3xmvuObEw6wzWJuWa
         nVEGX6w17+MtAxqgyiH49CwXnE7PoYvf3fK2dXBkAiKZRIvhVwpwEJo0dobTjyGQLtSf
         aByPo+IWYn+0YmnFsjLui7OqvPCdmsZywA1iOal4NZ6ikwLhwCsNMr30Eap6nfaKs/jZ
         dICEDZUsa7g8o8rUQ7+7rIOWyPYy7USqYSeQw2VQeZDU3/mMInhJU/QEf7Qqv+XJP6ty
         UI6X1JuzIUNycmpdgPReRiX0p7/xPu6b2M8N0YBRVCT8i0b5sWW0FTW5QKZUkwo33N4y
         ReLA==
X-Gm-Message-State: ANhLgQ1I73Dv+LZtti/m+wjl3ArxKPgZAJ85+wMhlavi2oOnIsgqa1+H
        DAvhc+WF2eSUmUlS5nduEITaGe9j
X-Google-Smtp-Source: ADFU+vtWn0J6zWgCCLf9r0YrSl90FVLx5kf0BbgrFL90zCK9swkIV0BQeBSHecgADp3jJQ0dHyRQPg==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr3280325plb.138.1584528685593;
        Wed, 18 Mar 2020 03:51:25 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id l25sm5799504pgn.47.2020.03.18.03.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 03:51:24 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v3 1/2] serial: sprd: getting port index via serial aliases only
Date:   Wed, 18 Mar 2020 18:50:48 +0800
Message-Id: <20200318105049.19623-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318105049.19623-1-zhang.lyra@gmail.com>
References: <20200318105049.19623-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

This patch simplifies the process of getting serial port number, with
this patch, serial devices must have aliases configured in devicetree.

The serial port searched out via sprd_port array maybe wrong if we don't
have serial alias defined in devicetree, and specify console with command
line, we would get the wrong port number if other serial ports probe
failed before console's. So using aliases is mandatory.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/tty/serial/sprd_serial.c | 36 +++++---------------------------
 1 file changed, 5 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 914862844790..e9d148d47bec 100644
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
+		return -EINVAL;
+	}
 
 	sprd_port[index] = devm_kzalloc(&pdev->dev, sizeof(*sprd_port[index]),
 					GFP_KERNEL);
-- 
2.20.1

