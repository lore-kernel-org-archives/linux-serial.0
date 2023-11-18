Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4057DC2BB3F
	for <linux-serial@archiver.kernel.org>; Sat, 18 Nov 2023 03:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjKRDjf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Nov 2023 22:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjKRDje (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Nov 2023 22:39:34 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BF2D79
        for <linux-serial@vger.kernel.org>; Fri, 17 Nov 2023 19:39:31 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2839c113cbcso944941a91.3
        for <linux-serial@vger.kernel.org>; Fri, 17 Nov 2023 19:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700278771; x=1700883571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xk65QbdRKZdLNSQh19GKuOPbc61/SWIMytvbu8dUYc=;
        b=jsiDW+/iFIlrJvhc1hGwOytoJLciIuIJz7wYjuNWDFnZ5gFquyO+WxRLDmDf5KmNJ+
         eG085RVuTESbmH30O6YSw8ZW16Q7nLxcgyL9+bMp6SI3m5pWoLrHgy887fKYprXZpcrx
         oMEzW3lRZpTqyB728Efq+OoAtH9CWzEzyaNwvWGBFjaxWg3dZz/nsVVU0iAZfsFfI/4Y
         EsxySpBUlSzbfQVUjuAOCMVGxvMtyMtb10oppx2S905yksnzieWrRF17TgLpe11JBXu1
         P1shtwpdQNms3HtW890uvEIPO3UYTqHZ5Lg8UU6lp2/7b8CotK6ZFshNEW8Y2O/GlU+l
         Rbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700278771; x=1700883571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Xk65QbdRKZdLNSQh19GKuOPbc61/SWIMytvbu8dUYc=;
        b=j1pmUjnthJymv5Yf0n/xYCwuH+QjkyBEVp4KS9nUcfyYeINWWa5kA2AC4AhKbJMjqA
         dbEXTIzRVF5sk4MYSuTPKhGdj3V6i7aiRz54yQ1bmUHXY8mLrl+loGi66KYF+FjFAloN
         InaBI9YL4AnRQojg382r50DYFl2A9EMBFF0O9SogDGRpDfF9DY3E2tevWpSeLqyyC/i4
         rrHHzC4QJhMwwp9bLY++PRx1VpNdQVvqdGrRKjW/cBe9WSwvnaGrEQfS8I0rjmXgmJ5w
         UX3r/iSb1WclcqPSb0QitLn2k1ZIw/2kRXOT9f6LJkTqWZmtF9YcfdFEUbUVy8m6QL0M
         Briw==
X-Gm-Message-State: AOJu0Yzj3aZzEq21w00z5My7jIZLVFImIwKJpuMSO8ncnL+GpmVcpowS
        2sIzOhLtNCJvTOJl3c9vvVU6yw==
X-Google-Smtp-Source: AGHT+IEdivzV5yM9VLUbAmX/fPwvXT56J4szG18kUoyADgqsU5ZolAzZbNQxZHHnYCkaszm6OKc0Yw==
X-Received: by 2002:a17:90b:4a49:b0:280:4ec6:97e9 with SMTP id lb9-20020a17090b4a4900b002804ec697e9mr1593141pjb.30.1700278770582;
        Fri, 17 Nov 2023 19:39:30 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.80.108])
        by smtp.gmail.com with ESMTPSA id cz8-20020a17090ad44800b00280fcbbe774sm2053823pjb.10.2023.11.17.19.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 19:39:29 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v4 0/5] RISC-V SBI debug console extension support
Date:   Sat, 18 Nov 2023 09:08:54 +0530
Message-Id: <20231118033859.726692-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The SBI v2.0 specification is now frozen. The SBI v2.0 specification defines
SBI debug console (DBCN) extension which replaces the legacy SBI v0.1
functions sbi_console_putchar() and sbi_console_getchar().
(Refer v2.0-rc5 at https://github.com/riscv-non-isa/riscv-sbi-doc/releases)

This series adds support for SBI debug console (DBCN) extension in KVM RISC-V
and Linux RISC-V.

To try these patches with KVM RISC-V, use KVMTOOL from riscv_sbi_dbcn_v1
branch at: https://github.com/avpatel/kvmtool.git

These patches can also be found in the riscv_sbi_dbcn_v4 branch at:
https://github.com/avpatel/linux.git

Changes since v3:
 - Rebased on Linux-6.7-rc1
 - Dropped PATCH1 to PATCH5 of v3 series since these were merged through
   KVM RISC-V tree for Linux-6.7
 - Used proper error code in PATCH1
 - Added new PATCH2 which add common SBI debug console helper functions
 - Updated PATCH3 and PATCH4 to use SBI debug console helper functions

Changes since v2:
 - Rebased on Linux-6.6-rc5
 - Handled page-crossing in PATCH7 of v2 series
 - Addressed Drew's comment in PATCH3 of v2 series
 - Added new PATCH5 to make get-reg-list test aware of SBI DBCN extension

Changes since v1:
 - Remove use of #ifdef from PATCH4 and PATCH5 of the v1 series
 - Improved commit description of PATCH3 in v1 series
 - Introduced new PATCH3 in this series to allow some SBI extensions
   (such as SBI DBCN) do to disabled by default so that older KVM user space
   work fine and newer KVM user space have to explicitly opt-in for emulating
   SBI DBCN.
 - Introduced new PATCH5 in this series which adds inline version of
   sbi_console_getchar() and sbi_console_putchar() for the case where
   CONFIG_RISCV_SBI_V01 is disabled.

Anup Patel (4):
  RISC-V: Add stubs for sbi_console_putchar/getchar()
  RISC-V: Add SBI debug console helper routines
  tty/serial: Add RISC-V SBI debug console based earlycon
  RISC-V: Enable SBI based earlycon support

Atish Patra (1):
  tty: Add SBI debug console support to HVC SBI driver

 arch/riscv/configs/defconfig            |  1 +
 arch/riscv/configs/rv32_defconfig       |  1 +
 arch/riscv/include/asm/sbi.h            | 10 +++++
 arch/riscv/kernel/sbi.c                 | 43 ++++++++++++++++++
 drivers/tty/hvc/Kconfig                 |  2 +-
 drivers/tty/hvc/hvc_riscv_sbi.c         | 59 ++++++++++++++++++++++---
 drivers/tty/serial/Kconfig              |  2 +-
 drivers/tty/serial/earlycon-riscv-sbi.c | 24 ++++++++--
 8 files changed, 129 insertions(+), 13 deletions(-)

-- 
2.34.1

