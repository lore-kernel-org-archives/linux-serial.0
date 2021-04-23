Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A76DC433B4
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 19:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C0B61425
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 19:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243738AbhDWTUp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWTUo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Apr 2021 15:20:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E749C061574;
        Fri, 23 Apr 2021 12:20:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id g16so8843204plq.3;
        Fri, 23 Apr 2021 12:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lrwUQ3mmw/iuK0YfShTAVZs6e4JFUEWjX4fuTIAouS4=;
        b=hFCMPBi1cl2+Neu+I8EaVYggjVlCkCFUKGxE1gcEOsRSMKpDNUDn6EqVUj1NAkVhKT
         tWgAxLjqR9t82qoyPxq0UTOtU4lbixjMvTCQcU+jxdc16Na6LQCfJHcXDn567Q2V31ag
         xSX3nJ8qET4nHKAJkqDUWvaE8VjJUoMvvy3XxZkA4pABwGuR/LA3lpLm5skNw0ELFvFA
         euNkn3TDTi7olkasg8tbYqZ4Zb6xMii8n96HtPAhSaQwEAeLl0abRAy0cvdzgZvaX4LH
         00DWLoSS9B8I5W1EumOuDIF04zim1H1Pmvn/3YIyGExmXkoqMnV2a4A1XtyKZoEd+a+O
         SpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lrwUQ3mmw/iuK0YfShTAVZs6e4JFUEWjX4fuTIAouS4=;
        b=mSc1mifV3TWfdv7enYVf7g0cE5KSo9M7j5x+pOrwj3Wkop/gah7IykXfhkuboAdM4F
         Doa0GbLiHRFnIs90l9kPy67h5qeiZn4RyJUw9HJ5I8j+Otd/bC12JjewB5eOaFl705oD
         bd0S1mQN8wLqalqBK3RUqp4vEV3O+NsuP/M+qVIWvt1ru/RbOiX679H77xP5VbFpX+Jr
         jw4IkXpu3gP3pl/S8R0dki6NvmlkINugJ2k/1p3KGrQamCZ61KsA5cnem9fOXVIxsZOQ
         3mWF5dd4qi263iOQbBADqkW6sCuM2YbNP3I1ygW82+/unTIGzOTyrdINCF7UBMhnc+YG
         2l8w==
X-Gm-Message-State: AOAM533uojW7dr5LGt5/OEHT20gNASq4Gi3EqXPdd1S/c8LGuPLMOLq0
        RW9Wwy9wrjI0r1XibZdrkG45qgZRiWQ=
X-Google-Smtp-Source: ABdhPJx4+zV4nZreZuUpbOw322b3TTxPOEtufkajXv1w7iIZ7Du0aB5/sbOVfC7UyN4CybeuEbiByQ==
X-Received: by 2002:a17:90a:a604:: with SMTP id c4mr7594749pjq.81.1619205606289;
        Fri, 23 Apr 2021 12:20:06 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y29sm5401444pfq.29.2021.04.23.12.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 12:20:05 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250: of: Check for CONFIG_SERIAL_8250_BCM7271
Date:   Fri, 23 Apr 2021 15:19:20 -0400
Message-Id: <20210423191920.42940-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Jim Quinlan <jim2101024@gmail.com>

This commit has of_platform_serial_probe() check specifically for the
"brcm,bcm7271-uart" and whether its companion driver is enabled. If it
is the case, and the clock provider is not ready, we want to make sure
that when the 8250_bcm7271.c driver returns EPROBE_DEFER, we are not
getting the UART registered via 8250_of.c.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/tty/serial/8250/8250_of.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 65e9045dafe6..aa458f3c6644 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -192,6 +192,10 @@ static int of_platform_serial_probe(struct platform_device *ofdev)
 	u32 tx_threshold;
 	int ret;
 
+	if (IS_ENABLED(CONFIG_SERIAL_8250_BCM7271) &&
+	    of_device_is_compatible(ofdev->dev.of_node, "brcm,bcm7271-uart"))
+		return -ENODEV;
+
 	port_type = (unsigned long)of_device_get_match_data(&ofdev->dev);
 	if (port_type == PORT_UNKNOWN)
 		return -EINVAL;
-- 
2.17.1

