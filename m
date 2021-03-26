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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E2EC433E4
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 11:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C4861A32
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 11:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCZLPq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Mar 2021 07:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhCZLPY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Mar 2021 07:15:24 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2309AC0613AA;
        Fri, 26 Mar 2021 04:15:24 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id t20so744887plr.13;
        Fri, 26 Mar 2021 04:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bPpEBr2VNoEucElp60nsPa9fsdYETM52GmgTsr1VV5w=;
        b=IYuTYcTRms+QwLVCSrjm5uBdCHbX2jp8Krrt3XJ5qltPrPl48oYpfD9SYO1IwvIPZH
         FJyfVNstmmLT8ad75L5TGtj7dylWZaKUnxHivjmbk248CT98ZcyNag2nsjqv8gY+S7AX
         eVAaQ5YPhuSHl4/bhqi+UvZWoatTrD8WFv9lGwsOJfmMsxpreIsaEM0XBO1ZPrplZffD
         yYyctlzBblvcuUeMnGTkxLTkMhAApdotlmeTcWiuHVxNkfvd1qdgA93/qwLCSVBbgay1
         kcNax34mnDUYbaA4sXnRgk2g6XSbeW5WFL4iD9x21splUppZ7QFbf0JNO/rOdwiZui7j
         uRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bPpEBr2VNoEucElp60nsPa9fsdYETM52GmgTsr1VV5w=;
        b=DB34Ilmu7SQP+4FvqEcOB//plRc+sgJU85vhiSTd8MwN/+FPbFP9j6KfZZzMwcHHcK
         +TGmILYS1hLHWGUig9eBCKUfsNGSAVfHViy2Y6xoCUvd4ZAiBPCQHCViAc3yG7PeeWYI
         WzduQRd8Ck1ay4xtla6mj9XGtuaT4mEFlUEK/WGOXa7cY6asjA1OSKXiUBX/Hh7HjQIM
         Sc0NTLXOrwCPKPeOUL6MBrN3+f/ufnAWui2Rgo9NkS/HtZF/H4jCB+1Ss9PDTB3TWFIB
         2G/iVSSX4cK4cHzJkMp18wxe+5NH23rsQ9XAt+gk1J56sZq26aEkSTDFX52jwBnW7+AS
         lHVA==
X-Gm-Message-State: AOAM532YQehVdyXWscsBPmdor6VnWq66aqQtXjRWUGU2K31pAEwun/60
        359vehDN9MZQdwbInafrq9jkiw3HeVeJXHQT
X-Google-Smtp-Source: ABdhPJwd5T+kpADDMnMHcg+MZmHelEtQ3t7nsJWs6qhXcjRS2jUsr1ahQTDjO+ghsKV8EJhjZp+ruQ==
X-Received: by 2002:a17:902:8a95:b029:e7:1029:94be with SMTP id p21-20020a1709028a95b02900e7102994bemr13865648plo.26.1616757323780;
        Fri, 26 Mar 2021 04:15:23 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id l3sm8108414pfc.81.2021.03.26.04.15.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Mar 2021 04:15:23 -0700 (PDT)
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
Subject: [PATCH v6 5/9] ARM: dts: stm32: add stm32h750-pinctrl.dtsi
Date:   Fri, 26 Mar 2021 19:14:58 +0800
Message-Id: <1616757302-7889-4-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616757302-7889-1-git-send-email-dillon.minfei@gmail.com>
References: <1616757302-7889-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch add stm32h750-pinctrl.dtsi which just
reference stm32h7-pinctrl.dtsi

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

v6: no changes

 arch/arm/boot/dts/stm32h750-pinctrl.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32h750-pinctrl.dtsi

diff --git a/arch/arm/boot/dts/stm32h750-pinctrl.dtsi b/arch/arm/boot/dts/stm32h750-pinctrl.dtsi
new file mode 100644
index 000000000000..ef8c4d881dba
--- /dev/null
+++ b/arch/arm/boot/dts/stm32h750-pinctrl.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2021 - All Rights Reserved
+ * Author: Dillon Min  <dillon.minfei@gmail.com> for STMicroelectronics.
+ */
+
+#include "stm32h7-pinctrl.dtsi"
+
+&pinctrl{
+	compatible = "st,stm32h750-pinctrl";
+};
+
-- 
2.7.4

