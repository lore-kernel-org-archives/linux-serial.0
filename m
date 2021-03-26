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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84798C433EB
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 11:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E7961A44
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 11:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCZLPs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Mar 2021 07:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhCZLPd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Mar 2021 07:15:33 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB834C0613AA;
        Fri, 26 Mar 2021 04:15:32 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id bt4so2392645pjb.5;
        Fri, 26 Mar 2021 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5k4LK0I779i125dqLNMdZVaDSPCul1nXlVCzLiWx3OY=;
        b=mSql5w0CLSZnU5mD6lil6aD/NIEUDLGO2y24MmPkZo0MVPGHSVz5Q9+Ido++F74gqD
         YnKrRpJsfL4WXR9nL5FCVIV7sRhHFskLJ/SfwtBkgDJcoA/lxPenybRp39i9EjmpVnm3
         Wfl7RnKo2En+6/vUjUmGbtDvOpcg9vcJ5MDERQ+eIzJIcz6BihqtHRzcnqWuuRBnezTF
         ceHCzv6ZDsLa0vqgxEzS5OwNCjazNyyOWeerq1plhmTK5IwEgU8rqG3hyUfgGL4t8JI1
         ZhS7Qi+OeRKqXQ+juZT8TMaPZlcO0wX26tw54cg0FaMpVOiPYnIZxewMW88gf22x+bVA
         LQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5k4LK0I779i125dqLNMdZVaDSPCul1nXlVCzLiWx3OY=;
        b=Cx5zNRpOmCgY0S9U+Z4oj0ontr3FRCDnSISMlwqgPX/FJpb5uSdzPrWRNXIAf6nVp/
         u3oC0Rh3sfurKLz2WJLeYlWjCAICk7B93dBw/ceEKSDxTaEX08AV3TUeR42p8o4aSTY3
         x3Qs2tXKBaMujJwv0QFnFr0klTSumKTiGeEFSwamX0d1+Jycf4C1c0cXZmf9pmcIHeRI
         L1x2xe6WBYCZtu+Gv9fLvXYTgdIKZ+ZYfgNLZ/6lQsZOF9PcZbjyM1Ea30qqIupqElys
         wiQp1UFcHOHjO2klj6Prrd8jbTY59bEXbaEh1AvpnjGcmWHrGMgjHYyH6zK594GKevGZ
         w5nw==
X-Gm-Message-State: AOAM531PprhFnn6HwgAM8S5SR44E9BLb4muJ5kXsqApn7ciyCHUYfQUH
        CGxfO3RvrFtpYdWqmkKwMBmg7UbVjUQsyZYj
X-Google-Smtp-Source: ABdhPJwhvZ3EnfuZurA9F+HEFqVEOtBWHOterQqdMDBaDF+RggY+HEjblwBMwUmgjopNGp7vt/ULnA==
X-Received: by 2002:a17:90a:3ec3:: with SMTP id k61mr12950361pjc.125.1616757332479;
        Fri, 26 Mar 2021 04:15:32 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id l3sm8108414pfc.81.2021.03.26.04.15.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Mar 2021 04:15:32 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh@kernel.org, valentin.caron@foss.st.com,
        Alexandre.torgue@foss.st.com, rong.a.chen@intel.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@foss.st.com, erwan.leray@st.com,
        linux-serial@vger.kernel.org, lkp@intel.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v6 7/9] ARM: stm32: Add a new SOC - STM32H750
Date:   Fri, 26 Mar 2021 19:15:00 +0800
Message-Id: <1616757302-7889-6-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616757302-7889-1-git-send-email-dillon.minfei@gmail.com>
References: <1616757302-7889-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

The STM32H750 is a Cortex-M7 MCU running at 480MHz
and containing 128KBytes internal flash, 1MiB SRAM.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

v6: no changes

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

