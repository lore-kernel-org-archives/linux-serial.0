Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD6DC64E7A
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 19:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D16F72240A
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 19:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5SWahC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgKTTpt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Nov 2020 14:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgKTTpt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Nov 2020 14:45:49 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50140C0613CF;
        Fri, 20 Nov 2020 11:45:49 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id a18so8869808pfl.3;
        Fri, 20 Nov 2020 11:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wjhndhUbpEPjkeRQX2dQorY8yrHackaZ2HFlAe8HJCQ=;
        b=W5SWahC3Xz90MO33D/+3EAdNptwhhfLpZ++MjjbrfMw62ZwpuWE0VG/CYk0wjDFaCs
         STJopvsMGBOtBrt+XgljOz9romH+MQQcR4e/V9cFI1pfUVawUl1Wi2bvyhZPWuQTogCb
         SpGwdrgZm/k7eEsHMt5/YIlL0CDnFixWiGFmVAnodffFagRoZS3g1SUCTIcWCFN+TIfN
         ex25nB/Z2bIfj2NSQY7gsR8Ac70n8WXhoUln/G2c/RXUtdrXPxDRR30r/OpVVOOs6ask
         H13Nz8ai1+yZDSRPawy23/7+aj2+9EwUatTW09E4JCpPULAAIQziaslik6LqjfXZP/nN
         j7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wjhndhUbpEPjkeRQX2dQorY8yrHackaZ2HFlAe8HJCQ=;
        b=TCdP44IHYGScHDFAylhKR2ZByuYiqsEmtThO0+/gW1s/1tSrxR/bJGwhIaqY4cYJhF
         Tbt9TWFp8hhzMn+LHXaNV44iCtvqN5b8CsPdMseB4x2d6Ph1qy+UQ4Oh1gEYlJQCEFh8
         uskW2JrOr7uKezhb34YJKT6WyS+3m8QTHjMPoQtYbqt3SN0jAwzPRPjbA+5zjPfZaCDr
         W/cQG91Mf8S8sJJ1PoDMgzQuLGIO2OA/qkehy2cbDHExgsk1v3cNoQLDZ7U/RPHqqgLl
         gr6aRvF0Oy6P+W4yF6Nih2/t1yj4Dc70tbkKh0Dj4yq+IQxatgAqM51Km5LgtWozpDUf
         sIxQ==
X-Gm-Message-State: AOAM530724KRgJg2AFfMyHCuGG3FGN1x2AOYeXPdkA4sRNeZvRo+VbPI
        PUGpqITk7fYmXWp/Uz7IRqzFytL5ZwY=
X-Google-Smtp-Source: ABdhPJzLtcx4amnoDl8wCLlU4ZHnmlhz0WL1WkHJXQW4CA5OdZ1ygQdwSZokLnCVzwwyc2HLhxqLUA==
X-Received: by 2002:a63:db50:: with SMTP id x16mr18300775pgi.205.1605901548669;
        Fri, 20 Nov 2020 11:45:48 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id b1sm3755884pgg.74.2020.11.20.11.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:45:47 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jquinlan@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/3] serial: 8250: of: Check for CONFIG_SERIAL_8250_BCM7271
Date:   Fri, 20 Nov 2020 14:43:03 -0500
Message-Id: <20201120194305.8847-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120194305.8847-1-alcooperx@gmail.com>
References: <20201120194305.8847-1-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

This commit has of_platform_serial_probe() check specifically for the
"brcm,bcm7271-uart" and whether its companion driver is enabled. If it
is the case, and the clock provider is not ready, we want to make sure
that when the 8250_bcm7271.c driver returns EPROBE_DEFER, we are not
getting the UART registered via 8250_of.c.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
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

