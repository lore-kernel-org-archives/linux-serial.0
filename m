Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D6DCDB46E
	for <linux-serial@archiver.kernel.org>; Thu, 12 Oct 2023 05:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjJLFPV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Oct 2023 01:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJLFPV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Oct 2023 01:15:21 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04ABB7
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 22:15:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c62d61dc96so4447945ad.0
        for <linux-serial@vger.kernel.org>; Wed, 11 Oct 2023 22:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697087719; x=1697692519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xYp5d01yjoieOqk/RkEsuV4xU8mIT2wOo0WVBK9XVOw=;
        b=b2U2xlBdhLNmojbTWlKg6h/wiuEFBOwdQizMaSZpjhVJMTWnFOsEHP+Fb50ss4lvMb
         dRuHPLY1NY0g4VJYWnnjM6liqlo45EFsj5gtUyx/xTLsZW6ZJOkc6HpabmooBEU+hBlI
         oLSOw8FDL7DLp+3XhrWG3RNA6Bb2C21p8SU5G1o4WrHj5ODjEmOx0xAcdcwELl15hB7e
         Alxs6NtonfrE2TOx4iTPAymqXN2ptM/eiAx9kzLoBz9vV25srw+dvXoAc6bSHcAujstE
         xU4jp/ST3sU7ADIYxpNVDmbA16/R7uhjMFrdE4hnWINArbOhIOAgcIjgpOYX9amvO/hj
         Q3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697087719; x=1697692519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYp5d01yjoieOqk/RkEsuV4xU8mIT2wOo0WVBK9XVOw=;
        b=c/BEz86/8vdBWve8MoWHArZffRYldC4DGnaTJt/jh5AXvJ2pOpraQ110UVrTBPDlGh
         GSO3QbjmkvyJaMnhv21Hknt1GF+W7CCIhz8jn7UQfybgNYQ6p5dbxrNYHwnXNOhH429B
         aHkwHgA1wA5Lxb0JYpyiSvDzQCQFPIOqAyQE2c4edLoqgWSSLb/N3BB/AOsBTN/6b1i3
         /I4SLFXJ5eht1EsybPdt6DAnBoVu/65SpBxFhLlwxbGZCA/h0BndnhhXlN7rtl9dKzs9
         4ld6plh/MR8dkMAexD9GNFMXviWtTVMnYsuK5MKeLliloPzFQKF9KsPWo1bkASvgJYSV
         VcJg==
X-Gm-Message-State: AOJu0YzBpgjA73svwOm45KnnWMgkPi37wfSGBo/J77fM0+AFqtbvO5Js
        YX0nN88p6BoylfXB84UJ7LHh//GEJXyp+PpyVeE=
X-Google-Smtp-Source: AGHT+IHEPFFUqt3pliIbieg/aaMtAbi3pZkt/8nzFWa9PAcsbNguDQ6TUJOXLaRnVEd017jWXQ44gg==
X-Received: by 2002:a17:902:e888:b0:1c7:37e2:13fe with SMTP id w8-20020a170902e88800b001c737e213femr22891127plg.2.1697087719126;
        Wed, 11 Oct 2023 22:15:19 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090330d200b001b9d95945afsm851309plc.155.2023.10.11.22.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 22:15:18 -0700 (PDT)
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
Subject: [PATCH v2 0/8] RISC-V SBI debug console extension support
Date:   Thu, 12 Oct 2023 10:45:01 +0530
Message-Id: <20231012051509.738750-1-apatel@ventanamicro.com>
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

These patches can also be found in the riscv_sbi_dbcn_v2 branch at:
https://github.com/avpatel/linux.git

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

Anup Patel (7):
  RISC-V: Add defines for SBI debug console extension
  RISC-V: KVM: Change the SBI specification version to v2.0
  RISC-V: KVM: Allow some SBI extensions to be disabled by default
  RISC-V: KVM: Forward SBI DBCN extension to user-space
  RISC-V: Add inline version of sbi_console_putchar/getchar() functions
  tty/serial: Add RISC-V SBI debug console based earlycon
  RISC-V: Enable SBI based earlycon support

Atish Patra (1):
  tty: Add SBI debug console support to HVC SBI driver

 arch/riscv/configs/defconfig            |  1 +
 arch/riscv/configs/rv32_defconfig       |  1 +
 arch/riscv/include/asm/kvm_vcpu_sbi.h   |  7 ++-
 arch/riscv/include/asm/sbi.h            | 12 ++++
 arch/riscv/include/uapi/asm/kvm.h       |  1 +
 arch/riscv/kvm/vcpu.c                   |  6 ++
 arch/riscv/kvm/vcpu_sbi.c               | 49 +++++++++-------
 arch/riscv/kvm/vcpu_sbi_replace.c       | 32 +++++++++++
 drivers/tty/hvc/Kconfig                 |  2 +-
 drivers/tty/hvc/hvc_riscv_sbi.c         | 76 ++++++++++++++++++++++---
 drivers/tty/serial/Kconfig              |  2 +-
 drivers/tty/serial/earlycon-riscv-sbi.c | 32 +++++++++--
 12 files changed, 188 insertions(+), 33 deletions(-)

-- 
2.34.1

