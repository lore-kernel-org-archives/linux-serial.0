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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FC4C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 06:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0603A61A27
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 06:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCYGTt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Mar 2021 02:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhCYGTd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Mar 2021 02:19:33 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0536EC06174A;
        Wed, 24 Mar 2021 23:19:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so479806pjg.5;
        Wed, 24 Mar 2021 23:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FekWW96f8sKoFK8LSZN/PYb2w/ql5dj/T82FBFJxA4g=;
        b=GYZY9ldqL4FRRCDeMiDDOJmrCCVCV7UTn3cx/pGIv3mUV0irQ4xwpB1nM6Aw8O5pmg
         YS2S1l2opLfBOCSwa0fpUmfP80TYrlIjO0K5DKBJeaagBZeO7LVJTLUyxp/HZXf9b1Vu
         5d69LQzDCYSTTxQrarGvi7l/VlaHQDfpcuT7WPvKg43fgBNsrpOn6KHWJM2cJKsPI4O1
         MsBLiluSCFqAs0M9xkKtF5r2WZlDa232xkDfxgZIJlXwvw5v+fBLWiT9451dg5ysplZG
         TzIUNlp1mz/zbaennKwMe7LZRCxeIpF7+oDgzMFFzDj183ygTL05YemJoP8O4YD/xwIa
         u1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FekWW96f8sKoFK8LSZN/PYb2w/ql5dj/T82FBFJxA4g=;
        b=VtPmZ+DxGl2wtxO2vZzLt3u8JGSbany0AAQf3rNqaDY5ysT0wD3URghFrhVlLYrelW
         P/9vE3WS2wi3ogqqkAThNb+hth730AJILJVocL0cvVzDh1W4HZrO9mUoq/3uoJHKl8H1
         WkkhTRc90G7XMxbCfPaWNJGmiWhyNGFezTs40sQHOebNGGCGTC9ET58ohktIwFbK/3oQ
         fJ7NCpA6Ri75UUGFgXs4/PdqkE2G7/bOoVFY3JVc71XAFmPzGoSbUyxxZvswJcz56QBd
         kIFXXH0GLzH5O4j9j4aL1o1eLdgYpvvRkSo24nnR5+kxBbz+RoLauGaMQH2JyjM0aScZ
         r59g==
X-Gm-Message-State: AOAM530Q5ZNrJeX5I5ybDVoFN7BJenZe2IyA6XamnDq6HbW/64jVPaac
        /e/7y3GBW2k4FRPX6dt/CH5NkXA9AFGIKERA
X-Google-Smtp-Source: ABdhPJy7NKbAmOUkLnoCcU1jypf6//r5IO91+4LIWXhptNEZMeaDjcYCHRDKJ39P1X7ynMijw5O/kA==
X-Received: by 2002:a17:90a:e298:: with SMTP id d24mr7229367pjz.171.1616653172478;
        Wed, 24 Mar 2021 23:19:32 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id b19sm4393086pfo.7.2021.03.24.23.19.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:19:32 -0700 (PDT)
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
Subject: [PATCH v5 1/9] Documentation: arm: stm32: Add stm32h750 value line doc
Date:   Thu, 25 Mar 2021 14:19:16 +0800
Message-Id: <1616653162-19954-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616653162-19954-1-git-send-email-dillon.minfei@gmail.com>
References: <1616653162-19954-1-git-send-email-dillon.minfei@gmail.com>
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

v5: no changes

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

