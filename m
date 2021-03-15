Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ED3C43331
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E085964EB5
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhCOJpb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 05:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCOJp2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 05:45:28 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B8FC061574;
        Mon, 15 Mar 2021 02:45:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x21so4906616pfa.3;
        Mon, 15 Mar 2021 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ep4oDr1hglklL7K/WBO42zrmw7RgFyDwJC2jJIwneMg=;
        b=CY0QFw48sP9XRK0pge5CLUvMCuHUxO7IkJKsEmkPNDbnFpuSc77oOs5XrPzrxrsi5D
         8I5DLUt+5/SG2KmW2gfB4RjFlBq5XVZ/PFQksIzTA4U/xS1sxqA68A6ACFh+mJq6RMNv
         ol4gTZyWcMO3ccOex712CdxB2x55bUB2k9z20rnqx800xoNH3+AP8bXXppGnEykVf3Oz
         iEyKqmAihUI2p5NuV4LvS7jmt9pPU8WY79LlwueaZ4lbbmCJSs310DntYdI7AGcymajh
         QkeitNg4nBMdgJNFexsqr9MFPAPFdNUXBv3mW5i6WEjivm8NcwbbNmp/IfR9z4po8LbU
         S2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ep4oDr1hglklL7K/WBO42zrmw7RgFyDwJC2jJIwneMg=;
        b=OmL9kl3bLnA1AwIdXVLQPUnQlLMXw7g1/NY/g/W/305RNvKy6I9Iwst95DDtClkbeZ
         0Gjgypkaxu0D6He2KEF/xj5g97Z0mq2xogxBCANjI51TK1tBp1cW0pC61P52hJ9gYO7Y
         UWWG9HyrhmghO6KiAZVyD2uozhG3EWZ65C76f4OyRK5DXPNVJhs2w0A8ka0IDt8Kwsr2
         fL1gLPGa+SHB7xJAvW49gb9Cos49HKutBcqlGcqPJ6W37bt3zWeRdAqyxvuTu/wGFGe3
         EZSufHexf1UVmWHaz5ftJcO8k3RlimTzJYiXqgFF+7gbBN9iqEeAqOUOAj4vuJiAnxqC
         uMdw==
X-Gm-Message-State: AOAM533D5bxtCeCEnCXexBpIwPaY/75bJpZtCPPgSKhRCtXocg0lKBE0
        qxIDLoSjv4nQMl2SmgY8lCI=
X-Google-Smtp-Source: ABdhPJyrPUV5QT9n5Vkw3w86SxR6jp8X5ZjJvYUSAFfYyVOOLONK+/ghx0cPcD4gq2GDhDbR/HNORQ==
X-Received: by 2002:a63:6981:: with SMTP id e123mr22900109pgc.423.1615801527715;
        Mon, 15 Mar 2021 02:45:27 -0700 (PDT)
Received: from localhost.localdomain ([120.245.122.54])
        by smtp.gmail.com with ESMTPSA id 14sm12780811pfy.55.2021.03.15.02.45.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 02:45:27 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, alexandre.torgue@foss.st.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@st.com, erwan.leray@foss.st.com,
        linux-serial@vger.kernel.org
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v3 8/9] pinctrl: stm32: Add STM32H750 MCU pinctrl support
Date:   Mon, 15 Mar 2021 17:43:55 +0800
Message-Id: <1615801436-3016-9-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
References: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch adds STM32H750 pinctrl and GPIO support
since stm32h750 has the same pin alternate functions
with stm32h743, so just reuse the stm32h743's pinctrl
driver

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 drivers/pinctrl/stm32/Kconfig             | 2 +-
 drivers/pinctrl/stm32/pinctrl-stm32h743.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/stm32/Kconfig b/drivers/pinctrl/stm32/Kconfig
index f36f29113370..fb1ffc94c57f 100644
--- a/drivers/pinctrl/stm32/Kconfig
+++ b/drivers/pinctrl/stm32/Kconfig
@@ -35,7 +35,7 @@ config PINCTRL_STM32F769
 	select PINCTRL_STM32
 
 config PINCTRL_STM32H743
-	bool "STMicroelectronics STM32H743 pin control" if COMPILE_TEST && !MACH_STM32H743
+	bool "STMicroelectronics STM32H743/STM32H750 pin control" if COMPILE_TEST && !MACH_STM32H743
 	depends on OF && HAS_IOMEM
 	default MACH_STM32H743
 	select PINCTRL_STM32
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32h743.c b/drivers/pinctrl/stm32/pinctrl-stm32h743.c
index ffe7b5271506..700206c7bc11 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32h743.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32h743.c
@@ -1966,6 +1966,9 @@
 		.compatible = "st,stm32h743-pinctrl",
 		.data = &stm32h743_match_data,
 	},
+	{	.compatible = "st,stm32h750-pinctrl",
+		.data = &stm32h743_match_data,
+	},
 	{ }
 };
 
-- 
1.9.1

