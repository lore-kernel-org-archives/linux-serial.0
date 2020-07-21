Return-Path: <SRS0=EuFA=BA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A6DC433E0
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 12:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4C7206E9
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 12:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcbCCb7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgGUMKt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgGUMKs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jul 2020 08:10:48 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E6AC061794
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 05:10:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gc15so1347186pjb.0
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 05:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DUhxoUHdk/G5hcIoHHmedsybYx4YWFvLP5ZmToBFcQA=;
        b=jcbCCb7hQJlHIsdcZ51dQFHY/9ZAio9o8npqoAFikBjrRS5rSX8azSndpIfoxx4pB+
         36zJ9XHfNsZaRy7DSN1DP/aiQPS1wdywIz2HH7ZUeQPS9pMnDDMBFScXUX8tkATs9D3Q
         AgbIybVi4CKkW8frVqni9KeOc3TfJHu2wgPhSRbqmU1CzyLw2BnPvo3mq5J7vWHydhVG
         ykZd7ucwFth+Pedeigm9B3p8zNkoO+gfshaZ2vqKoy3ykznGytstafoT6n4A86ml+rYT
         oMyEtsd0jdPbtn+jYCfaazIcKecvvJ9MCT/0T4bbqk2TDYe3Ou5Vdbc5vVEP2p1XGntN
         aHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DUhxoUHdk/G5hcIoHHmedsybYx4YWFvLP5ZmToBFcQA=;
        b=TO534wPAc//wilw3xzNRo1NOBtf7KjZe3thy7UHtAUGNslQsN+EaVqFhZ4Lz+v3EEz
         fI624/Qavq3iDk8xj7P6SOY/Z7c+tKNcM/YHP0uimTtshtb9HnClrsfncx1pFwfPRi6q
         ferRng64tYpXe5y2p8tw8NooxIAaPbxa2z8NQV0MQVoPluXgjiR3ogDsU0ng8wkI6TYL
         WRvTJKg2KzrviyH5V92k+52ggdm9vIQZ01wsK8mLKMzogGw6wYK0NSyquoQj5yvUyhcQ
         /ZJeMO59cH6oWeIZVwPTxBlH7EpKjdk7Tz44sb7u6aSWGTzuOHxRL66D1CmyK84hp6jS
         rwMQ==
X-Gm-Message-State: AOAM531ysksFHLUNo6uCHgy2sgojXb6uVeJAf+S6z7Mf7LbYhd2ELgVR
        dvoyE7mcvJUNCz5YlfMpnnEWuQ==
X-Google-Smtp-Source: ABdhPJyRExe3Qfy877FM+lq0KPlLWXAqsMqBIE5QqFOrqY5bkLpSCnvsNe2TWxlOTPk4HSLRIyix+g==
X-Received: by 2002:a17:902:d698:: with SMTP id v24mr21585075ply.163.1595333447996;
        Tue, 21 Jul 2020 05:10:47 -0700 (PDT)
Received: from localhost.localdomain ([117.210.211.74])
        by smtp.gmail.com with ESMTPSA id w9sm20601992pfq.178.2020.07.21.05.10.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 05:10:47 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     gregkh@linuxfoundation.org, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-serial@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net
Cc:     jslaby@suse.com, linux@armlinux.org.uk, jason.wessel@windriver.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC 0/5] Introduce NMI aware serial drivers
Date:   Tue, 21 Jul 2020 17:40:08 +0530
Message-Id: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Make it possible for UARTs to trigger magic sysrq from an NMI. With the
advent of pseudo NMIs on arm64 it became quite generic to request serial
device interrupt as an NMI rather than IRQ. And having NMI driven serial
RX will allow us to trigger magic sysrq as an NMI and hence drop into
kernel debugger in NMI context.

The major use-case is to add NMI debugging capabilities to the kernel
in order to debug scenarios such as:
- Primary CPU is stuck in deadlock with interrupts disabled and hence
  doesn't honor serial device interrupt. So having magic sysrq triggered
  as an NMI is helpful for debugging.
- Always enabled NMI based magic sysrq irrespective of whether the serial
  TTY port is active or not.

Currently there is an existing kgdb NMI serial driver which provides
partial implementation in upstream to have a separate ttyNMI0 port but
that remained in silos with the serial core/drivers which made it a bit
odd to enable using serial device interrupt and hence remained unused. It
seems to be clearly intended to avoid almost all custom NMI changes to
the UART driver.

But this patch-set allows the serial core/drivers to be NMI aware which
in turn provides NMI debugging capabilities via magic sysrq and hence
there is no specific reason to keep this special driver. So remove it
instead.

Approach:
---------

The overall idea is to intercept serial RX characters in NMI context, if
those are specific to magic sysrq then allow corresponding handler to run
in NMI context. Otherwise, defer all other RX and TX operations onto IRQ
work queue in order to run those in normal interrupt context.

This approach is demonstrated using amba-pl011 driver.

Patch-wise description:
-----------------------

Patch #1 prepares magic sysrq handler to be NMI aware.
Patch #2 adds NMI framework to serial core.
Patch #3 and #4 demonstrates NMI aware uart port using amba-pl011 driver.
Patch #5 removes kgdb NMI serial driver.

Goal of this RFC:
-----------------

My main reason for sharing this as an RFC is to help decide whether or
not to continue with this approach. The next step for me would to port
the work to a system with an 8250 UART.

Usage:
------

This RFC has been developed on top of 5.8-rc3 and if anyone is interested
to give this a try on QEMU, just enable following config options
additional to arm64 defconfig:

CONFIG_KGDB=y
CONFIG_KGDB_KDB=y
CONFIG_ARM64_PSEUDO_NMI=y

Qemu command line to test:

$ qemu-system-aarch64 -nographic -machine virt,gic-version=3 -cpu cortex-a57 \
  -smp 2 -kernel arch/arm64/boot/Image -append 'console=ttyAMA0,38400 \
  keep_bootcon root=/dev/vda2 irqchip.gicv3_pseudo_nmi=1 kgdboc=ttyAMA0' \
  -initrd rootfs-arm64.cpio.gz

NMI entry into kgdb via sysrq:
- Ctrl a + b + g

Reference:
----------

For more details about NMI/FIQ debugger, refer to this blog post [1].

[1] https://www.linaro.org/blog/debugging-arm-kernels-using-nmifiq/

I do look forward to your comments and feedback.

Sumit Garg (5):
  tty/sysrq: Make sysrq handler NMI aware
  serial: core: Add framework to allow NMI aware serial drivers
  serial: amba-pl011: Re-order APIs definition
  serial: amba-pl011: Enable NMI aware uart port
  serial: Remove KGDB NMI serial driver

 drivers/tty/serial/Kconfig       |  19 --
 drivers/tty/serial/Makefile      |   1 -
 drivers/tty/serial/amba-pl011.c  | 232 +++++++++++++++++-------
 drivers/tty/serial/kgdb_nmi.c    | 383 ---------------------------------------
 drivers/tty/serial/kgdboc.c      |   8 -
 drivers/tty/serial/serial_core.c | 120 +++++++++++-
 drivers/tty/sysrq.c              |  33 +++-
 include/linux/kgdb.h             |  10 -
 include/linux/serial_core.h      |  67 +++++++
 include/linux/sysrq.h            |   1 +
 kernel/debug/debug_core.c        |   1 +
 11 files changed, 386 insertions(+), 489 deletions(-)
 delete mode 100644 drivers/tty/serial/kgdb_nmi.c

-- 
2.7.4

