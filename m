Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A0AC433E8
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 02:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FAC619B5
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 02:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhC3C3s (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Mar 2021 22:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhC3C31 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Mar 2021 22:29:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E31AC061762;
        Mon, 29 Mar 2021 19:29:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso8670425pji.3;
        Mon, 29 Mar 2021 19:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZC7OsJDitwURS7yQv21Tqa62xwQC02uZmH02f7XnvdM=;
        b=ZMDEApQI7isg6vY98cwN7EKN0hFbkKliHzcvx4tJLy9YSb1vFLx3oKDaruXdXkQI9p
         EEMt0K+Q8jhqbXTkngijL08KxUzIYpPG9tISDqG2GbDicw8k8H43IrVBdAw70y4txkj3
         1vn3SBNsOmAql2S78jNx7X6Kh21zHfw1CBALq+szWBs+JK0es3Wpr2r0PtVWmxHQZnnB
         ZJKJUGxZxm/7uUK328q+bd8KZmzn2XbCId1weMgckVrputIVNCuexxgjUb2EnuzYFasz
         lLKw3CtlQWTnJEfkfylj2bGs7f/mQtYVBLRSim+BTZJeLzq93ItcDnBIv4RgwslexYZY
         5deQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZC7OsJDitwURS7yQv21Tqa62xwQC02uZmH02f7XnvdM=;
        b=Z6dHETH6psRyZE57O7nkeFHjM7etal0ojPqEYwqJE8eC5glGwUpzB4zb7pIH5fsuUK
         uEaIQ/qM1Pc24PGCbxKQZE5OLYkxSsEtLnv+ypwAi1qZjehUABTn230c3wwJul6D7GOA
         uhRm2uLyBpeYGbf3utI64wOxHemo3wGEC7VteD6H8+NM240sYCAI0/zRs+wLOwbxNpx/
         GQfp16gISOr79WX8fj8g7JuwFWAzGJBvw7rYslSSlOR0JHN1VVLCGPd4VZ00mEo1FHl2
         ObMr13JQizbT4aUuCcRYrLlWCPBU3wKVOcbZoFRCP2EFaFRqMhc55iFjuxbgN0SfB1In
         fTMw==
X-Gm-Message-State: AOAM5314WK1bqQYu4lQhQg7p63cHHQG4U3nBH9JxUGuQGhWSob6QEcCd
        Qi3SDR0QhRBuyDnf21soapA=
X-Google-Smtp-Source: ABdhPJwetibVZU5KRDLAzy+ulEXTyr3gBVWCsEo78h4LF3Gg2xL2QGuIbH7u0kMZgnT99MafHPx9+Q==
X-Received: by 2002:a17:902:a610:b029:e6:5eda:c39e with SMTP id u16-20020a170902a610b02900e65edac39emr31678090plq.11.1617071367006;
        Mon, 29 Mar 2021 19:29:27 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id i13sm17681385pgi.3.2021.03.29.19.29.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Mar 2021 19:29:26 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh@kernel.org, valentin.caron@foss.st.com,
        Alexandre.torgue@foss.st.com, rong.a.chen@intel.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, afzal.mohd.ma@gmail.com,
        gregkh@linuxfoundation.org, erwan.leray@foss.st.com,
        erwan.leray@st.com, linux-serial@vger.kernel.org, lkp@intel.com,
        patrice.chotard@foss.st.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v7 5/6] ARM: stm32: Add a new SOC - STM32H750
Date:   Tue, 30 Mar 2021 10:28:57 +0800
Message-Id: <1617071338-9436-6-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617071338-9436-1-git-send-email-dillon.minfei@gmail.com>
References: <1617071338-9436-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

The STM32H750 is a Cortex-M7 MCU running at 480MHz
and containing 128KBytes internal flash, 1MiB SRAM.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
v7: no changes

 arch/arm/mach-stm32/board-dt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
index 011d57b488c2..a766310d8dca 100644
--- a/arch/arm/mach-stm32/board-dt.c
+++ b/arch/arm/mach-stm32/board-dt.c
@@ -17,6 +17,7 @@ static const char *const stm32_compat[] __initconst = {
 	"st,stm32f746",
 	"st,stm32f769",
 	"st,stm32h743",
+	"st,stm32h750",
 	"st,stm32mp157",
 	NULL
 };
-- 
2.7.4

