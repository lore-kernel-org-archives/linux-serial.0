Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3289CCD8CAC
	for <linux-serial@archiver.kernel.org>; Tue, 10 Oct 2023 17:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjJJRGZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Oct 2023 13:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbjJJRGA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Oct 2023 13:06:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6287D18A
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 10:05:47 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c5cd27b1acso46468895ad.2
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 10:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696957546; x=1697562346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OF/0DZOVOE1sZojsrN9hmq2DR3MNn3xhzg86O8Xb4xI=;
        b=gzuJ05BHsBpfeRoMHWR26s0956U/nteB5pForucJtcHhDFRBXHR0SGK4os/xRl6z2W
         SA56yVp4pAd/Q2HOzXUk3vEUrX4bVYhS/ugwPAZjDworecKoJGBCR6HmP56lqPm9EbxX
         AWYNJM/CjI8fJIAhJZI3uAKOtq59Lj0Y8qwbnS9kWsgNvOypdilchNNWEYXFn9WQXHOd
         FioZ8wfuddJX2ns6sRZSafTolhZCWCsmJ5y6eDqZG0ytBbwEoiJo0OVZAKRMRnBi0NCl
         tZSJi+TsuvxyQNVF8i5m/GnEgWsk2UR//kOxmU1IaiHvSuY0w05Rc0Jq1WMEm6ecKPbj
         un6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696957546; x=1697562346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OF/0DZOVOE1sZojsrN9hmq2DR3MNn3xhzg86O8Xb4xI=;
        b=vate+RdmjCxYIgRbxXOnYcogD8EMWZaQ2sEA+wlwbDIBm3CAvfirHt822TLYtRnSPu
         ZV7O2iw/T+kq+UmCveAY9COqXmOo6UIwzWWsuGqxHv1TyOXYUbIVpOgFYAbe2YW7D0KX
         YWrasX2fmZ5e1ndGq9OnxQ+Q9B2EcOUMEbvg3Fb+sgX5PAZYt7ASfZ6fahQmnhDLQ1t7
         A7FshrbaCta0HNOVOCRsH+4fZhJjwuPSrPhG7dxiMdmd76CBIhW6qPBqvViRwya9Fmr6
         V5lsqOU/aO333wwbym5gOM0B71EELTANPtcDaoGbT8qtmQT9T7mROjMyPn63yVMYL6NO
         m2EQ==
X-Gm-Message-State: AOJu0YwBznMD+Z2ZwRTL0RPRoWHf2Fv/X/jXR5ppaEPRxMUoRJU6NJHH
        l8yexM0DHKIr0Sgsuwn+UG22wg==
X-Google-Smtp-Source: AGHT+IEFOyqePTNhMFtIG9Pkb5PdZI4JBTY0AeRn/RM9+tKVmMklIxkKeQjOcYyUz8tcYu0GN0YOAQ==
X-Received: by 2002:a17:903:230a:b0:1c7:7e00:8075 with SMTP id d10-20020a170903230a00b001c77e008075mr23570340plh.66.1696957546442;
        Tue, 10 Oct 2023 10:05:46 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709027b9300b001b89536974bsm11979868pll.202.2023.10.10.10.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 10:05:45 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 6/6] RISC-V: Enable SBI based earlycon support
Date:   Tue, 10 Oct 2023 22:35:03 +0530
Message-Id: <20231010170503.657189-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010170503.657189-1-apatel@ventanamicro.com>
References: <20231010170503.657189-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Let us enable SBI based earlycon support in defconfigs for both RV32
and RV64 so that "earlycon=sbi" can be used again.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/configs/defconfig      | 1 +
 arch/riscv/configs/rv32_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ab86ec3b9eab..f82700da0056 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -132,6 +132,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 89b601e253a6..5721af39afd1 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -66,6 +66,7 @@ CONFIG_INPUT_MOUSEDEV=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
-- 
2.34.1

