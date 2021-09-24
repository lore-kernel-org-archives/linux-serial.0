Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44016C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 24 Sep 2021 13:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260C86103B
	for <linux-serial@archiver.kernel.org>; Fri, 24 Sep 2021 13:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346466AbhIXNcy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Sep 2021 09:32:54 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59680
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346848AbhIXNcs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Sep 2021 09:32:48 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8E8C340292
        for <linux-serial@vger.kernel.org>; Fri, 24 Sep 2021 13:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632490274;
        bh=7+KXOT92gYpnQNddSURkQHCHQzdadUuSju5IBYQg/jM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=sVvsUKi9lEJq+wtE+ltyxWwL/YISuMLOhaARzUS/umOi/Kwfnt789AOQJeIwL84Iv
         bH8s/NIzy5AOO/HlSNmF/7FqRJC5JQudi+miQIjeevbQqpEKi7X3zJg7Vy2SnvnKfU
         aoxbMEExSPgkGAB/57REKDs0xSO6BS89WJc/nKvXlLRqRo26GcWv1zMs0RRV2CsboL
         Or8Emf1Gf+S7Po7qKtMUkNGcrpNwyVdP1rgkn97sUsPnrmAZzGyQ/wXeTWOuFVq1uz
         qdAouH0gHJ5Nl751wZwjj9K1iNnpFka6BoSrzSN4vAqoUVPdQyYUjD8SGz2CCOvjh7
         W6mn8DFPxAmhQ==
Received: by mail-wr1-f70.google.com with SMTP id l9-20020adfc789000000b00160111fd4e8so8073226wrg.17
        for <linux-serial@vger.kernel.org>; Fri, 24 Sep 2021 06:31:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7+KXOT92gYpnQNddSURkQHCHQzdadUuSju5IBYQg/jM=;
        b=pZ0BG29sYgUX5+obrjfFhVKRDRHV92AyQSjHDahtIoQsr+S2vYSQIvFvvkS+aSELTV
         YFyslKts4PSVsvIS0cqQPRq56JWgd18wJc9HMcmYys9ScRH4y1DG4+e9NDxTGOIxTIvB
         +GQDtWVQx1vbwmNDt4HT3wUwiJeqYbuyCH6ObKvD6hD8Jgmey+WwAM4Ugb8OBkSb3yM+
         lvhit/GcMyMH1iwyk9rCzYHnSP4GV/rEvwpFCb5qaiJKEOUbfb2XohFInxhuwDX9VOTs
         rVgAq8YWqk0F/D5/GMKot2SYohTx2MXXEtwCrrzbwnhPJjA+CawtOnXsr5jd75/CYgMc
         w+NA==
X-Gm-Message-State: AOAM5321vqR/6PXxbZC2daV3Pc3zqLrrUKeJmhj+mEZOaONYYuLCOs9G
        XSXCEaW9HF2ZsHEjaywMgjOOhfiOt4amF7etgpkEG8x4uF4vGlFlRst+XMRpJABboAYKf5wTCjh
        Y+DPhBWj57FGsSvajTdiAt/6OZS4TQuDBeq09rdxHOQ==
X-Received: by 2002:a5d:6ad1:: with SMTP id u17mr11690056wrw.204.1632490274240;
        Fri, 24 Sep 2021 06:31:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYckO6AhgoRej7g84y99iwDf/PCFMj3wlTxVqGTic4nAdGVQ1B/693JNp0/Os6wI7jAGiLug==
X-Received: by 2002:a5d:6ad1:: with SMTP id u17mr11690031wrw.204.1632490274096;
        Fri, 24 Sep 2021 06:31:14 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id j27sm8003049wms.6.2021.09.24.06.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:31:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: samsung: describe driver in KConfig
Date:   Fri, 24 Sep 2021 15:30:40 +0200
Message-Id: <20210924133040.111706-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Describe better which driver applies to which SoC, to make configuring
kernel for Samsung SoC easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/tty/serial/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 131a6a587acd..6ff94cfcd9db 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -239,10 +239,11 @@ config SERIAL_SAMSUNG
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || ARCH_APPLE || COMPILE_TEST
 	select SERIAL_CORE
 	help
-	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
-	  providing /dev/ttySAC0, 1 and 2 (note, some machines may not
-	  provide all of these ports, depending on how the serial port
-	  pins are configured.
+	  Support for the on-chip UARTs on the Samsung
+	  S3C24xx/S3C64xx/S5Pv210/Exynos and Apple M1 SoCs, providing
+	  /dev/ttySAC0, 1 and 2 (note, some machines may not provide all of
+	  these ports, depending on how the serial port pins are configured.
+	  Choose Y/M here only if you build for such SoC.
 
 config SERIAL_SAMSUNG_UARTS_4
 	bool
-- 
2.30.2

