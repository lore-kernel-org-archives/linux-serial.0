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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECE1C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA15464EB7
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhCOJo5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 05:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhCOJof (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 05:44:35 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3707DC061574;
        Mon, 15 Mar 2021 02:44:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id r16so4892688pfh.10;
        Mon, 15 Mar 2021 02:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+b9sWME9s06yIBLOEvf5WrW2EmjZFwJwqifh5Bs79ks=;
        b=Myituj1qTSZfJC3Hp4o2Z4CYtaGyZHHQLhU6ZS6rQ5EDWBFB/JsHTR9Hgyb0SOjTcw
         ntOkd6NmlStBkXRjztO0g0mb/YnZbG0v5akINg/2pV/9qxiX6vQ25oAh46rvbqoM9HFQ
         TZXL730poJwkJirQcaBUpg2rsvWhQ3Qls3BsN1GtNngMDwjLb4WClDK2zGKc7FJjciRn
         DXknXwATZY37RIjubZGrXbpgmaBM7Fim2tHQRegMnSI3/5yTGCOC2l4ZowNMVtm2Jl8B
         wg7ndnR4eO6Fy2wSLbou4+L1j7mNLTFCZwiyPExEPU7xh0649FO/R46sVx6n9+JdXhuI
         lPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+b9sWME9s06yIBLOEvf5WrW2EmjZFwJwqifh5Bs79ks=;
        b=DQic2GzC312l5l4k06pD/5Pxiz5W4r4n8aHwL1OeNgGbuGLGJ6H9c5FzfTjJdlcT6V
         m28RISs9zypkSd7i29Oq5nTACMIpnZyruy/T4siVGj+mdzWrxVa+6K9LA7QAL8SbRzUA
         zA1NIMELPjyQC6zdS/SCDSdTdisP+OIkLEungIPSKX7p93+N9xp66d4v2MpMOG54netn
         Heuknrc032XLpBMHHBmVvV+HOK5GTvnK4XmFB2qIcPotbjm85nLGW7XwfrIG+0/OKUkW
         nrjL8cRkIYXLzAFfMZ9jY0qAcy7eAAdMbx25fxSx+i8mX6un7XBjcL+qz86EBc0JggJC
         YOEg==
X-Gm-Message-State: AOAM533MjEs9qAuEa3eaB/IMCTJcdEkoR75pxrsTCzPna7Eod9Jqctid
        gDJsRk+H4LweYoFutPAE4k8=
X-Google-Smtp-Source: ABdhPJwDc35fAvaJM4ILflo7oBaMuGLN4ekfPrxGNP4kOGjDyeaKeI8jYDKP42cSl9FI02PMi9FmWQ==
X-Received: by 2002:aa7:9841:0:b029:1f8:f326:a3b3 with SMTP id n1-20020aa798410000b02901f8f326a3b3mr9487795pfq.7.1615801474820;
        Mon, 15 Mar 2021 02:44:34 -0700 (PDT)
Received: from localhost.localdomain ([120.245.122.54])
        by smtp.gmail.com with ESMTPSA id 14sm12780811pfy.55.2021.03.15.02.44.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 02:44:34 -0700 (PDT)
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
Subject: [PATCH v3 1/9] Documentation: arm: stm32: Add stm32h750 value line doc
Date:   Mon, 15 Mar 2021 17:43:48 +0800
Message-Id: <1615801436-3016-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
References: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
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
 Documentation/arm/index.rst                    |  1 +
 Documentation/arm/stm32/stm32h750-overview.rst | 33 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
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
index 000000000000..c8ce59ec3bd1
--- /dev/null
+++ b/Documentation/arm/stm32/stm32h750-overview.rst
@@ -0,0 +1,33 @@
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
-- 
1.9.1

