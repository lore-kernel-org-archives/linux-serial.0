Return-Path: <SRS0=YkBk=4W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665D2C3F2D7
	for <linux-serial@archiver.kernel.org>; Thu,  5 Mar 2020 10:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B70B21556
	for <linux-serial@archiver.kernel.org>; Thu,  5 Mar 2020 10:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZzzyTL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCEKc4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:32:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45372 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCEKcz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Mar 2020 05:32:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so2554149pfg.12;
        Thu, 05 Mar 2020 02:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g6jvlcLfOVkePq/CeddtHcxNNxbcBUnyepFlczoKoYc=;
        b=UZzzyTL1ZB+yE8Jt4H6j1p0yCFX46aPS9ZVAdNXjxcjsGur/jB4RL5cMMdJTJGpUn9
         q/MOLQvyGC2HPHdgiMK02FBCt2o6KP1Wp+kbz8Akytmny/l/mf5JNhIySMszdPb8gzp5
         8EVXlxu7bnHIaPcLpmpI/GkApgcj69lS6s3ZsUBONyErebXYbBnRB0NeWPhlDgp+4shU
         bd3IPUMzVnn/KKnxbCAAZgDRQNzLzyLvbL6g9kMeCp66G5bmJMAvaPsqHK765DG7iHgZ
         PaDbVA6j14QUozLFqClvOzW/89MtlDshCqkTf+6UIj+2kNESIZzNpfVmOtkuCKXpLB2s
         ASZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g6jvlcLfOVkePq/CeddtHcxNNxbcBUnyepFlczoKoYc=;
        b=IBJD9eGaIQYqp2aeiFHrXUNl4kT+eOhlEYudsoAVHKFJ3oPVY3UOtfJ+yKYiP+B4nM
         vO+v9cDn88E4hqxJCzDomg5j2k2KnGJs/YzEcxDnqc5x2HSiWSH98FP2Goy/8EhZ2MVd
         Ko43gmlM1D4EOemDtRXygHtqf55I2yK7LOEq7JqeLjd/MEAopqZ5jgc4UzvVgihog3Q1
         jjqClLXveQmW22+cUChkyU4558r8y1lAewK+vQz3W5MICL2kHA10efwEjfjhRcURs2Mt
         yWFm1s1pJ9d2Mor0j5tfLN6kmG890SXCh44WHIrqF1SDR3XyFIUeCnnk+3unDq9Cf7vY
         RrKg==
X-Gm-Message-State: ANhLgQ3ollkf0r7z/4yrKsYUniEV9h9OrC99QnNeQ49drgO0ulAXNeCk
        XOXnFYiLn5VlXyfbaFktsNM=
X-Google-Smtp-Source: ADFU+vvjSIb9MWOcCZUFhbK955O/9E7FK0p9nq90jMrFm/uX5fq+xfRZeu1hdPIvtSZHOabTmOSYPA==
X-Received: by 2002:a63:8343:: with SMTP id h64mr6769837pge.73.1583404374332;
        Thu, 05 Mar 2020 02:32:54 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id t17sm31540145pgn.94.2020.03.05.02.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 02:32:53 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 1/2] arm64: change ARCH_SPRD Kconfig to tristate
Date:   Thu,  5 Mar 2020 18:32:27 +0800
Message-Id: <20200305103228.9686-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The default value of Kconfig for almost all sprd drivers are the same with
ARCH_SPRD, making these drivers built as modules as default would be easier
if we can set ARCH_SPRD as 'm', so this patch change ARCH_SPRD to tristate.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 arch/arm64/Kconfig.platforms | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b2b504ea6fd6..76778b2f520d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -249,7 +249,7 @@ config ARCH_TEGRA
 	  This enables support for the NVIDIA Tegra SoC family.
 
 config ARCH_SPRD
-	bool "Spreadtrum SoC platform"
+	tristate "Spreadtrum SoC platform"
 	help
 	  Support for Spreadtrum ARM based SoCs
 
-- 
2.20.1

