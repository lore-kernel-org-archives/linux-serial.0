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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E15C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 06:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F021B61A1F
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 06:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhCYGUf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Mar 2021 02:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCYGTu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Mar 2021 02:19:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8A3C06174A;
        Wed, 24 Mar 2021 23:19:50 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g15so982098pfq.3;
        Wed, 24 Mar 2021 23:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X8oRWWuPlCAw0yNFLdz89qGD/soNoAofvNQ+OkW3A5s=;
        b=SWPqxDvQ3eNKCCSXGcrmuHHK0VJUnRUCBt9MfO+97gkk/nmowld9MWuhIztHD8d88b
         hsTWhkTddKAj6/OEgESo0qpwkrknR7nFZndH2/SVbkqDzPYEJaiCRoqUPEjx8BL5l2GC
         wNp/eu5+KNrvfjHCKXnBG5yFlYad/CtR5Pdv1QmdnRD+c5PASswz/6Te+EvjsXcU+zSY
         aKip2Leie1GV3LS5kraQN7b94ahqjQVVtefoJr6W03EV82KiwV7ptrMGOUw/69PALao1
         5EfhbTzMX/wXF4LEJMff9nSif9J6U1Yq2XyZaPmDar8Ei3HxNGwLFBClOAKT+qT2YLbu
         bEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X8oRWWuPlCAw0yNFLdz89qGD/soNoAofvNQ+OkW3A5s=;
        b=fIJ193QP4QzXJsb46LEyLi6XCFx/azH9Xsf6PuHzCL5wFFK7OUqXjjqcaUg5PJ6lv9
         ANvwwpWeeWERWuL/Y+i7GY07un2cXXuTuByHKg7s+WtmIrm1i1QunJwZw/wB6aPi3IwQ
         Fn0QgYWyQ8pjB2DM53EA6SZbbEyqiEWo/aePgdRrw4XKhQU6DTxDCN2euLz3NgrWKbq1
         ZPKXuue+Er3BS35hp3jl8LDkZ3g9ea33vXG22QRDrqTpvkdRPQykNT7Gt+cncS3KUSJs
         3w+sJsu3G6MIHvGEuiOk/aFsXM0sXQFZ/f4LflbBVoK1DHFG1gVuOf1DgfxOJYPnvHQh
         qOjg==
X-Gm-Message-State: AOAM531E9DU1JwBNNxe8WkXeH3WxficMYwYBdf6UwwQkg5BB/qb6Ajc4
        j/9KilaFnj9rzgjzVPWwIU4=
X-Google-Smtp-Source: ABdhPJzvIiGb+AchLmsneF41VvHj51SYIXzqCKG/aa1VPiwzvdJk4BB0Vx6Defk8BpoMpfkn0hhb2A==
X-Received: by 2002:a17:902:b20c:b029:e6:cef9:6498 with SMTP id t12-20020a170902b20cb02900e6cef96498mr7771027plr.56.1616653189761;
        Wed, 24 Mar 2021 23:19:49 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id b19sm4393086pfo.7.2021.03.24.23.19.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:19:49 -0700 (PDT)
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
Subject: [PATCH v5 7/9] ARM: stm32: Add a new SOC - STM32H750
Date:   Thu, 25 Mar 2021 14:19:20 +0800
Message-Id: <1616653162-19954-6-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616653162-19954-1-git-send-email-dillon.minfei@gmail.com>
References: <1616653162-19954-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

The STM32H750 is a Cortex-M7 MCU running at 480MHz
and containing 128KBytes internal flash, 1MiB SRAM.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

v5: no changes

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

