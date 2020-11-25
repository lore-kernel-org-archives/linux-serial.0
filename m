Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F53C63777
	for <linux-serial@archiver.kernel.org>; Wed, 25 Nov 2020 08:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C2D208CA
	for <linux-serial@archiver.kernel.org>; Wed, 25 Nov 2020 08:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvi2cfB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgKYIO1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Nov 2020 03:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgKYIO1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Nov 2020 03:14:27 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98CBC0613D4
        for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2020 00:14:26 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id d20so1845560lfe.11
        for <linux-serial@vger.kernel.org>; Wed, 25 Nov 2020 00:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sOHhuzAwgLPX9+dHydyy/C4aJvmRH/7hKhV3ba73BEs=;
        b=nvi2cfB1aj0qbdM3m59TrH2P5Nty1UMR3VclQVhwY2HMDHe2js7tsEZKjqL3gx8OtY
         KZbjAZABfQemRj9f8Z8+9a6SfnID+xxrX+0P89fctV8tPVVAWnD3RVAHDlmsqoCaRUDh
         PO7AeqIbbZuHwBshHUxf+uWwzG5H2sHULNWXir4PR+A+zhtiTy2zS/MiO7dnOB3jK0to
         H99i/yEGfHhyaqUu0l3ptqrLZ5CNdEwFKyapyWzZcArCbKb5aYhkQYY6FJMzBHnkux2G
         hcYNQglXGl9w3f/OtdP8ZJqPa8gShdGwsKMJ3nhjRBKpmLJcOaEMqL1y/7/QUaYoJ1Zi
         B9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sOHhuzAwgLPX9+dHydyy/C4aJvmRH/7hKhV3ba73BEs=;
        b=tWuMOu/L4KG5pMSJbQAiZf/blWneQmUa2uF3p2gKvl6RvSctGMGdpbU0IXa07BZQoO
         XXe9nrWdvZmw2COvxXmiLy3J4JaOcukOj4yJ0wt7NVdx3sgtSX6TaqVILljG95Ylh9Ch
         WxcPvq+WxuZ2+Xo1NWFcehT0XVqBVVbX8UMUe3EzqK8G5QTf7aP4BymPMrFc+Sy4otlx
         xpXT2PV60AhQAuyGFbNiEt5L+Gk4ueQ7YE1iv+t0gV9Gxb6Ek7I2Whb1CaDP11BaMpIU
         Y8T3Br2Nsm+Z9YOveXS42zyRWeCtcu2T1/Y5lIr74ELpG8Pg9QRexb3Tgo4kjKPafBx+
         mGjw==
X-Gm-Message-State: AOAM531KjLlx9FnENUrlTIlA1TrjC9ovgxHReF0ZD5SuDPHETX1tXX0M
        S/29LzXzB886FWOfCrxMogw=
X-Google-Smtp-Source: ABdhPJyI07nxh/gMP4ImduvaDogFPCqN+U7D9hU/dehRm3QrL2J0XZ2Bc0VPplAfZfdei4wNSDGRUQ==
X-Received: by 2002:a19:c310:: with SMTP id t16mr823636lff.21.1606292065204;
        Wed, 25 Nov 2020 00:14:25 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id z4sm170212lfr.230.2020.11.25.00.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 00:14:24 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] tty: serial: bcm63xx: allow building on ARM64
Date:   Wed, 25 Nov 2020 09:13:52 +0100
Message-Id: <20201125081352.25409-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Hardware supported by bcm63xx is also used by BCM4908 SoCs family that
is ARM64.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/tty/serial/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 28f22e58639c..6907c5b17a0e 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1133,7 +1133,8 @@ config SERIAL_TIMBERDALE
 config SERIAL_BCM63XX
 	tristate "Broadcom BCM63xx/BCM33xx UART support"
 	select SERIAL_CORE
-	depends on MIPS || ARM || COMPILE_TEST
+	depends on MIPS || ARM || ARM64 || COMPILE_TEST
+	default ARCH_BCM4908
 	help
 	  This enables the driver for the onchip UART core found on
 	  the following chipsets:
-- 
2.26.2

