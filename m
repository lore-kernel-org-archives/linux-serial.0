Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7D4C4167B
	for <linux-serial@archiver.kernel.org>; Fri,  9 Dec 2022 15:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiLIPFP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 9 Dec 2022 10:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiLIPFO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Dec 2022 10:05:14 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D591E2189C;
        Fri,  9 Dec 2022 07:05:12 -0800 (PST)
X-QQ-mid: bizesmtp89t1670598279tf8ekbj4
Received: from ubuntu.. ( [111.196.135.79])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 09 Dec 2022 23:04:37 +0800 (CST)
X-QQ-SSF: 01200000002000B0C000B00A0000000
X-QQ-FEAT: 7bD38UErqBMse/wQvkTTMEyob1uRl85oGpxpBEZmiEMslPZLCL+kkKP6NtbX2
        gPc0PSkUeyw56O8ET95uXwx6vMo+BhrnioINwoXo4H2tTnglrQ/7WRNrtlQxK7ZQxSzw4ba
        ZeYLrpHEC9pG4k7/gbKQgezfWTytqnhFV+jA16UgOb0XV+eGbyAAhyEZQ7gB/3fFm0ivwFx
        bdP+CFTqDOLadz2kycFslFhdoxQFI4FDYuWQVzMVw3ReGwgKnFOt8f3+eihWRjuFqXfIje2
        KdVb9RsMmhoL4ikneZlRSDmfernerWgzDol1vR6cutPf4eSN8cTqRMCFNRjhWwlE0OvFo4z
        hbLJM6xeg60PoRG+FB96PPSALEiAg==
X-QQ-GoodBg: 0
From:   Bin Meng <bmeng@tinylab.org>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/3] serial: Add RISC-V support to the earlycon semihost driver
Date:   Fri,  9 Dec 2022 23:04:34 +0800
Message-Id: <20221209150437.795918-1-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvr:qybglogicsvr3
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


RISC-V semihosting spec [1] is built on top of the existing Arm one;
we can add RISC-V earlycon semihost driver easily.

This series refactors the existing driver a little bit, to move smh_putc()
variants in respective arch's semihost.h, then we can implement RISC-V's
version in the riscv arch directory.

Link: https://github.com/riscv/riscv-semihosting-spec/blob/main/riscv-semihosting-spec.adoc [1]

Changes in v3:
- add #ifdef in the header to prevent from multiple inclusion
- add forward-declare struct uart_port
- add a Link tag in the commit message

Changes in v2:
- new patch: "serial: earlycon-arm-semihost: Move smh_putc() variants in respective arch's semihost.h"
- Move the RISC-V implementation to semihost.h

Bin Meng (3):
  serial: earlycon-arm-semihost: Move smh_putc() variants in respective
    arch's semihost.h
  riscv: Implement semihost.h for earlycon semihost driver
  serial: Rename earlycon semihost driver

 arch/arm/include/asm/semihost.h               | 30 +++++++++++++++++++
 arch/arm64/include/asm/semihost.h             | 24 +++++++++++++++
 arch/riscv/include/asm/semihost.h             | 26 ++++++++++++++++
 drivers/tty/serial/Kconfig                    | 14 ++++-----
 drivers/tty/serial/Makefile                   |  2 +-
 ...con-arm-semihost.c => earlycon-semihost.c} | 25 +---------------
 6 files changed, 89 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/include/asm/semihost.h
 create mode 100644 arch/arm64/include/asm/semihost.h
 create mode 100644 arch/riscv/include/asm/semihost.h
 rename drivers/tty/serial/{earlycon-arm-semihost.c => earlycon-semihost.c} (57%)

-- 
2.34.1

