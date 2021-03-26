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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72258C433DB
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 11:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9EB60249
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 11:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCZLPo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Mar 2021 07:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhCZLPP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Mar 2021 07:15:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6271DC0613AA;
        Fri, 26 Mar 2021 04:15:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id ay2so744970plb.3;
        Fri, 26 Mar 2021 04:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8LbC0yRdb6KnBRs4/oHMCPB8Wx+wfbQ7JrB27rdabEo=;
        b=ODurMsRARbMLi1n2YX5YSv2Re+1Sl/BpZkwEqgNmkSZe0/9NTRivo0xUNzhrSFYGsI
         Px5M3WxN65FyQHfJ7EW27bHJg76oKnCc/tIX0OoFPhmalG010qPebVHg9blNSXeDM9Xa
         fGx5NTh34AKMAM8BfnCpDm+T+4vOFS8fLoFE+QHRZr5xhlCgtCBIvZ6TBtAjllqsaAGI
         x0d+t1Sem/wtf1YUsMYvcuecD3OB339EQ7XfQqQOBmhHlcF9v3966VbZNg+HxfnPpTN9
         +lsGV/JIUC1js1Q3e9C+pURR3kuTXKZ95EN41n/fwkxcainx5746FZscQBx1sYivXOCM
         Lm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8LbC0yRdb6KnBRs4/oHMCPB8Wx+wfbQ7JrB27rdabEo=;
        b=D+KL3z7su2pv0MwULz6VVUFpMoNsavVvZLMj7VWPqHXCMIUqcuFB9pvjXURviNgAt5
         YTdcOGeA2musWeU7POIiFnNezm33vgBwhj7VCsMqseW68gEHF3UR4P6KvhYKUf7tQsVh
         8LAaGDR3DeY4f2Grd7hROO5q2bquODGBZcw74kL07UoF2bf8oUIxRFYhqwKwk4eoBW5N
         yLgoZy8nb3HKwbkd93CgHt9aVZlfPxogYUcbnXTv2LwIf/ICp2vT9lseZbENkyXPj9WW
         uJ23BvDFbA6gDW7XHjRDXlEIBfVNmtN3miFKB+sNafOaKtMgLVloolodqGpEE/e7Ydb5
         vN2Q==
X-Gm-Message-State: AOAM530kxb5rw8QTb/9zaJcAVZGb8b9N/j9+lXFxcSnFsR8aXxBC949S
        mE0akINAjIYdImYxQdT7/ZA=
X-Google-Smtp-Source: ABdhPJw4f1Ee2Hz0/Mm15LtPxz6VsG6K/k51kVXf8OiJcmT1EppkEPqKWTPnMhHhnWHobI9yDqBs9A==
X-Received: by 2002:a17:902:d341:b029:e6:9a9f:5614 with SMTP id l1-20020a170902d341b02900e69a9f5614mr14828314plk.48.1616757314991;
        Fri, 26 Mar 2021 04:15:14 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id l3sm8108414pfc.81.2021.03.26.04.15.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Mar 2021 04:15:14 -0700 (PDT)
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
Subject: [PATCH v6 1/9] Documentation: arm: stm32: Add stm32h750 value line doc
Date:   Fri, 26 Mar 2021 19:14:56 +0800
Message-Id: <1616757302-7889-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616757302-7889-1-git-send-email-dillon.minfei@gmail.com>
References: <1616757302-7889-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patchset add support for soc stm32h750, stm32h750 has mirror
different from stm32h743

item            stm32h743     stm32h750
flash size:     2MiB          128KiB
adc:            none          3
crypto-hash:    none          aes/hamc/des/tdes/md5/sha

detail information can be found at:
https://www.st.com/en/microcontrollers-microprocessors/stm32h750-value-line.html

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

v6: no changes

 Documentation/arm/index.rst                    |  1 +
 Documentation/arm/stm32/stm32h750-overview.rst | 34 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/arm/stm32/stm32h750-overview.rst

diff --git a/Documentation/arm/index.rst b/Documentation/arm/index.rst
index b4bea32472b6..d4f34ae9e6f4 100644
--- a/Documentation/arm/index.rst
+++ b/Documentation/arm/index.rst
@@ -52,6 +52,7 @@ SoC-specific documents
    stm32/stm32f746-overview
    stm32/overview
    stm32/stm32h743-overview
+   stm32/stm32h750-overview
    stm32/stm32f769-overview
    stm32/stm32f429-overview
    stm32/stm32mp157-overview
diff --git a/Documentation/arm/stm32/stm32h750-overview.rst b/Documentation/arm/stm32/stm32h750-overview.rst
new file mode 100644
index 000000000000..0e51235c9547
--- /dev/null
+++ b/Documentation/arm/stm32/stm32h750-overview.rst
@@ -0,0 +1,34 @@
+==================
+STM32H750 Overview
+==================
+
+Introduction
+------------
+
+The STM32H750 is a Cortex-M7 MCU aimed at various applications.
+It features:
+
+- Cortex-M7 core running up to @480MHz
+- 128K internal flash, 1MBytes internal RAM
+- FMC controller to connect SDRAM, NOR and NAND memories
+- Dual mode QSPI
+- SD/MMC/SDIO support
+- Ethernet controller
+- USB OTFG FS & HS controllers
+- I2C, SPI, CAN busses support
+- Several 16 & 32 bits general purpose timers
+- Serial Audio interface
+- LCD controller
+- HDMI-CEC
+- SPDIFRX
+- DFSDM
+
+Resources
+---------
+
+Datasheet and reference manual are publicly available on ST website (STM32H750_).
+
+.. _STM32H750: https://www.st.com/en/microcontrollers-microprocessors/stm32h750-value-line.html
+
+:Authors: Dillon Min <dillon.minfei@gmail.com>
+
-- 
2.7.4

