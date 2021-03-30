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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0371FC433E1
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 08:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE89561999
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 08:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhC3I7K (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 Mar 2021 04:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbhC3I6x (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Mar 2021 04:58:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE95C061762;
        Tue, 30 Mar 2021 01:58:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v8so5809038plz.10;
        Tue, 30 Mar 2021 01:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FUmJbGGhJ0M8BOof8LnXQJFcnuGvgG4sMjXT3YiPkS4=;
        b=tWWjc17CwkjTu7PLrTye0AARaJrJSAObQBbyUVq5qn/DG/aZm9LaaBgVWrIR1Pcg4V
         LEIu3DaRdLNHNyBJbINXKfuRXtJCAb+vGDsECaCoYZP5uj0b3egrAjhfjtmZqU+CFttS
         WbimF8Ko3WiejsftdeZNEL0Al/OEDzBvWU38Ej/sNyuxkaTBhVQ8T4RpljBvY90fRyiJ
         Bai8eCzP4efucCLRCLoZQwA1MjFUYUzkMgw66TVPuCQAxee6so91ncR/qXEgh+jldwQb
         X71uxSm8VlVvvzaIZ1AOY0hCkQSHSD/PHfrjj1vMHuezODgcp0yQdZBKme4qZy3nWsUi
         /utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FUmJbGGhJ0M8BOof8LnXQJFcnuGvgG4sMjXT3YiPkS4=;
        b=XNnCtw0pSTU1fuqesw8PRvGtj6uY14Mp9PPEwbgj+Hmk4bLAG/VmuTgWEbBZYaaxSX
         0bwkWLk/GYaOqCp+8QBjmQWyFOiZsAGz8xrJJ993zipUJ1nQc01WeX7OAg9TS2ZbdeM0
         LVm2F6SvHqNhtov9ud/p2UdRPtsZH95GQjd7Sx94tW9+Fn+2FX5JKuAQpYrVw2w9E3Xi
         O0UrZudXBPlz4kYCzpefcICX0zqjvORuqGr4wHL7K5dtgCHXpoK+gfqe22Do5kIkV+Lq
         2zHPaqaWnKedVOCjC2jNOK0d6iL1M+13Hi4DzlU/eCHqWT4Wq0Xocj59rsIyijtV0asJ
         M5Cw==
X-Gm-Message-State: AOAM533MtWjhFFw2NvUYHmZev/YTbs1GC9B+gFUOFGfwO4FHhFfbiMhn
        vkbhWSvs9VMaI8zZ15JuEBo=
X-Google-Smtp-Source: ABdhPJxoK0LnTrxg0IQQDSduBRY1DwM9p7bY7psUqjidgg8DbkkuBfvtcB4b+hXzvtpQJpZA6pKOpg==
X-Received: by 2002:a17:90a:cf8f:: with SMTP id i15mr3343412pju.22.1617094732561;
        Tue, 30 Mar 2021 01:58:52 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id y8sm20952642pfp.140.2021.03.30.01.58.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 01:58:52 -0700 (PDT)
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
Subject: [PATCH v8 5/6] ARM: stm32: Add a new SOC - STM32H750
Date:   Tue, 30 Mar 2021 16:58:23 +0800
Message-Id: <1617094704-10040-6-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617094704-10040-1-git-send-email-dillon.minfei@gmail.com>
References: <1617094704-10040-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

The STM32H750 is a Cortex-M7 MCU running at 480MHz
and containing 128KBytes internal flash, 1MiB SRAM.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
v8: no changes

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

