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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FC8C433E5
	for <linux-serial@archiver.kernel.org>; Wed, 31 Mar 2021 08:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3B9619DE
	for <linux-serial@archiver.kernel.org>; Wed, 31 Mar 2021 08:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbhCaI3g (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 Mar 2021 04:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbhCaI3X (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 Mar 2021 04:29:23 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445CDC061574;
        Wed, 31 Mar 2021 01:29:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso839168pjh.2;
        Wed, 31 Mar 2021 01:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tMbHlMOQBksugwXBraiPexKO3Alo10XSX/pY8DpNjzc=;
        b=O9WJJ3ruoiqLzVNW7uPCFBfMEyso1s+K1/uMHnwhvj2kc016TSYf1hD/xl406Q6GQZ
         mKz2bWnbJkIhNir8G7jFBYAVrPS2ZDlVKcsIZbbp1nWwm7hQdC61BOmBp+I68kVUWI0x
         G6dTVBjCpB995gEgLY2+eTtMCb7ZJ7svX+mIiaetO+3qStIoK1sY6o27WEo4/pN86/Ng
         R4HdqRJY5Nw7LrJnc0nuyiSI/y0GupNdNZ82so1ACQ5MSGQa0XL6qs1EMYd5gVO2RaYT
         8Nf232Q4XxManJB/za08xAENqjHeJVzktwe5JaULRwW3h4HOOL59vqWbqR61BwxAkS2z
         0PFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tMbHlMOQBksugwXBraiPexKO3Alo10XSX/pY8DpNjzc=;
        b=GWTF2vnVdU3torfGO6QLfwOtIxChJmlaSWgvt8x/S0ngwm2gU0ZU+AJapiWoY/kwKV
         uit3fJboCiMTCzpWpy57dO/3d7JXH4U+wZ0P8a1pTh6UKjdnOqh/PRsHA9I+mOlGAuA5
         nh+og//vjxvjCzv0JySZcd9T4Wt09PyumDtpMO+LugewWsyKEHdnJ+ccM9mYM3bq0Epk
         L/etjHe18fE4KpK0WqXjmm2uQej9fJWB2Nxz4lsTc4QmGgol4XxCozsQNIFGQvQ3VsrO
         JmmrmH8hQ8MvCwpQmReWKRvmaM487jZvsPjxwABIMy5gT7gMtDeQPDHgkMTxwf7rM4VE
         bbLQ==
X-Gm-Message-State: AOAM533BdlcEd8mKfm/kmkFwkr9xCMY6IehujTkbEhw/CO+CqQNthDOi
        d9IQhCbj494Krf0eOwe6JTY=
X-Google-Smtp-Source: ABdhPJwPtt7oyAheZL9ldgtU5oBOVHSeZHN7Uv0gqCjbJJ6ZtWHCMvSvPYH+wC+K6bEGkWHGVN41Fw==
X-Received: by 2002:a17:90a:e64a:: with SMTP id ep10mr2463653pjb.105.1617179361933;
        Wed, 31 Mar 2021 01:29:21 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id v1sm1420991pjt.1.2021.03.31.01.29.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Mar 2021 01:29:21 -0700 (PDT)
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
        patrice.chotard@foss.st.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, pali@kernel.org,
        mchehab+huawei@kernel.org, andrew@lunn.ch
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v9 5/6] ARM: stm32: Add a new SOC - STM32H750
Date:   Wed, 31 Mar 2021 16:28:44 +0800
Message-Id: <1617179325-6383-6-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617179325-6383-1-git-send-email-dillon.minfei@gmail.com>
References: <1617179325-6383-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

The STM32H750 is a Cortex-M7 MCU running at 480MHz
and containing 128KBytes internal flash, 1MiB SRAM.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
v9: no changes

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

