Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF20DC43219
	for <linux-serial@archiver.kernel.org>; Fri,  4 Mar 2022 08:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiCDIE4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Mar 2022 03:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiCDIEy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Mar 2022 03:04:54 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01C8D95EC
        for <linux-serial@vger.kernel.org>; Fri,  4 Mar 2022 00:04:05 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 448EC3F615
        for <linux-serial@vger.kernel.org>; Fri,  4 Mar 2022 08:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646381044;
        bh=0kJxljmXqNGTN5eMb3x4xxptqrabkXZDbHX7wYX3Zgs=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=SIR33sfQOuew9IIWRZ8L9pIhMHNVvAOa+bjYV/mckGlYYeQzmbty8snoSbBX8vMDw
         7MwxXV5pu573HLUd22XOeYIASwDQHkTdpolLDq9TPewgvuIPRl9NfUKp8oMpJqrOA4
         f89TtsFEXfz8JnS387tdijCPgHVmaX+oqyhuAF7oKPFZt+NKqzaIK+7WKHbews7onT
         UcoiQy5pFJmP+TL158eatNTcOnf6TJUvG0Np2yVF2aah3U1psgSZB2ca1Sp0Yztfcc
         mVji85h828cE1bWWLF8ACFlz7rbhN0/z4WVyWgVDYpW/NJYChh2S9lEJb95dorV4kU
         Q+BP0GZYFRsWg==
Received: by mail-ej1-f69.google.com with SMTP id i14-20020a17090639ce00b006dabe6a112fso320415eje.13
        for <linux-serial@vger.kernel.org>; Fri, 04 Mar 2022 00:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0kJxljmXqNGTN5eMb3x4xxptqrabkXZDbHX7wYX3Zgs=;
        b=4OjZh9PWpf6uzZnWkHCjaKvQLxxlqK3HcEJZTXrvBZztIUzaGPKOhY6bv8gSKqUgws
         ENSQJEVPDsoge9jouwHIOUvrgQP1FXJ3+aeV2a2rsY4+qZEDK+VJLkWChV5P62mcD31p
         VWz8hgILeUNcvFg0JFUeF09w9QN3fqpiRRmDJ/JWOgIEaJ2fLMNz0nPdqO/OC5Hu8Ykp
         KXN87LXFlLj2055BkBFHZdEOuRa2yy6qJbQ+elSqle9aS4wzZCRtdEKE7mBzOeiZvmcF
         GWuUjTc7cPEHA0iVn6iikKzaCWAT3DhSXkG27NlXWdJRzE4s8GsMoTkTFseNgu2a4KHa
         6BZA==
X-Gm-Message-State: AOAM530RMF47jATGTuTzqU1vaZyJROgyZALG891JjplJDEPLkBsHdd/o
        mRyM1apF3OHktB0bJSw48Gg+OfjDQhDpttLVUPEbR0IBNuIMy2it3y+Kfjwakq487Ia2Wu1NpHa
        OAInjhqX7Y+xWOTh191yQqIKYKJfUsCgrJIuowrpeAw==
X-Received: by 2002:a05:6402:3486:b0:409:8ed0:9340 with SMTP id v6-20020a056402348600b004098ed09340mr38136582edc.255.1646381042926;
        Fri, 04 Mar 2022 00:04:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+80NQg1qjGxzXwSnkNAPo7pilmgr6uO9HNvq8gSWafsXxSwmS24hqLp+IqtbfmR78BXE2qw==
X-Received: by 2002:a05:6402:3486:b0:409:8ed0:9340 with SMTP id v6-20020a056402348600b004098ed09340mr38136568edc.255.1646381042702;
        Fri, 04 Mar 2022 00:04:02 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm1481465ejb.82.2022.03.04.00.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 00:04:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] tty: serial: samsung: constify UART name
Date:   Fri,  4 Mar 2022 09:03:45 +0100
Message-Id: <20220304080348.218581-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
References: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The UART name from driver data holds only string literals.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 0b4f40044e87..279c413f2300 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -63,7 +63,7 @@ enum s3c24xx_port_type {
 };
 
 struct s3c24xx_uart_info {
-	char			*name;
+	const char		*name;
 	enum s3c24xx_port_type	type;
 	unsigned int		port_type;
 	unsigned int		fifosize;
-- 
2.32.0

