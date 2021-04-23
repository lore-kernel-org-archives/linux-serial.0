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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9163DC433B4
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 18:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB57613D8
	for <linux-serial@archiver.kernel.org>; Fri, 23 Apr 2021 18:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243462AbhDWSfA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Apr 2021 14:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhDWSe7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Apr 2021 14:34:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4CFC061574;
        Fri, 23 Apr 2021 11:34:21 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f11-20020a17090a638bb02901524d3a3d48so1644378pjj.3;
        Fri, 23 Apr 2021 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ae1Dg8y0lP5V7dkFaUmfaA9k11TAbQosKBq+vb9Jow=;
        b=JqMyOVliMrzRp6IA5HA/AelAUTvlEh1nbaEGOc3miOW0hQdxQvCmC+kXXGn+IzMMVk
         b+5UrjfLboDtFxTAkujnIRNBAR0b4hDckgxgKz/OPgJfxAXApqGCmOaxfzyz3MNYC2SR
         ompfscidyn9hsQ7UAtdR1SF6hnc08Kr8/tjmP9MjCXCrpwfjd4boxhBwc240vhd7wHBg
         FetRZwvQ01kme6fbcpGXyLN3dArGsOJB8LT356mL6LQMRTA+CA/VKubEBDrjvjsCyQNO
         WILQ8wH5a6FWXylVNUNoBjxVt3eEVHYnU29/mfVcaWqAlQQL7A6RhXptCsv97pT7rkYI
         WTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ae1Dg8y0lP5V7dkFaUmfaA9k11TAbQosKBq+vb9Jow=;
        b=KLvvvU9cH+qD4CW70U+Dknc4GXCAQC9hnqA3er6dw96fkf7n97DPATeciItyeq/wjr
         NAevJagkGozq6r+1qdMS7Qdp1BI0YnYa5y5ZtxyDP+f+SfbVzyGtnYUgiiDcaXwbVorK
         vUpzsK6hRfJGUM4C35MmOO19WcTwCarT7yRiy46mWDVqEstJQ1bLg5JlNFF14hbJjP5k
         YVSKeN40JG48+T5638Hs7rLkc4xzu4U7OoezJdqsCMeu19AIgyz17n+lcuXWFIkyBUTq
         PJ/Gajh4OjJHwNVaBy8ZEMYN9ZctlCHizBSdTnABdjLkguXGFYL3HKjvBmbtCVo+IGeA
         giyw==
X-Gm-Message-State: AOAM531RITnKbEMB9Qw2SbmMdycdD3Lke8nK0hqUjHO7P1vaDDp6utSt
        FCNJLcHVJkDPDd8ZhWIKic9M7Guzj5c=
X-Google-Smtp-Source: ABdhPJwFX6hIMN8LuFoTGg1xoWlDYo70Z/+35G4V7FnIdrrEkaju4cVcg9GeHltBusATaatH3t1UgQ==
X-Received: by 2002:a17:90a:6b84:: with SMTP id w4mr5837462pjj.134.1619202860534;
        Fri, 23 Apr 2021 11:34:20 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f10sm8456763pju.27.2021.04.23.11.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 11:34:19 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        andy.shevchenko@gmail.com, Jim Quinlan <jim2101024@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH tty-next] serial: 8250: of: Check for CONFIG_SERIAL_8250_BCM7271
Date:   Fri, 23 Apr 2021 11:32:04 -0700
Message-Id: <20210423183206.3917725-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Jim Quinlan <jim2101024@gmail.com>

Our SoC's have always had a NS16650A UART core and older SoC's would
have a compatible string of: 'compatible = ""ns16550a"' and use the
8250_of driver. Our newer SoC's have added enhancements to the base
core to add support for DMA and accurate high speed baud rates and use
this newer 8250_bcm7271 driver. The Device Tree node for our enhanced
UARTs has a compatible string of: 'compatible = "brcm,bcm7271-uart",
"ns16550a"''. With both drivers running and the link order setup so
that the 8250_bcm7217 driver is initialized before the 8250_of driver,
we should bind the 8250_bcm7271 driver to the enhanced UART, or for
upstream kernels that don't have the 8250_bcm7271 driver, we bind to
the 8250_of driver.

The problem is that when both the 8250_of and 8250_bcm7271 drivers
were running, occasionally the 8250_of driver would be bound to the
enhanced UART instead of the 8250_bcm7271 driver. This was happening
because we use SCMI based clocks which come up late in initialization
and cause probe DEFER's when the two drivers get their clocks.

Occasionally the SCMI clock would become ready between the 8250_bcm7271
probe and the 8250_of probe and the 8250_of driver would be bound. To
fix this we decided to config only our 8250_bcm7271 driver and added
"ns16665a0" to the compatible string so the driver would work on our
older system.

This commit has of_platform_serial_probe() check specifically for the
"brcm,bcm7271-uart" and whether its companion driver is enabled. If it
is the case, and the clock provider is not ready, we want to make sure
that when the 8250_bcm7271.c driver returns EPROBE_DEFER, we are not
getting the UART registered via 8250_of.c.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Signed-off-by: Al Cooper <alcooperx@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/tty/serial/8250/8250_of.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 0b077b45d6a9..bce28729dd7b 100644
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
2.25.1

