Return-Path: <SRS0=pdp3=6O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9C3C4724C
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A2AD20661
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay5tSMlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgD3QQ1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726405AbgD3QQ0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 12:16:26 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0303CC035494;
        Thu, 30 Apr 2020 09:16:25 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b20so1437430lff.2;
        Thu, 30 Apr 2020 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHCcWfIEICV286PlzrlDhon26egExA0EzSmCUey5zx8=;
        b=ay5tSMlwbsTytMC7115ZGRlTIa6ajZl389PdP5rwRFjVdI2WdoqyVsj71qOrQeG4+3
         UKYJyxd/cA0ur6rCIOqf1Ews+8L98JgIF6F+ljKM85bXDLpHp+CnOLJjuE3bBFLuyRnY
         o/O3wePvR7bcNfq9OBC9q5xozmSaVSjKIlBgWdN5mX7JueVbkl63GNBkBR1NGUwfwGMM
         g4ub0uMZ3dn7BqOxtEc7rOu5zDyTR2VThEy7nizswgYtakMsJQ4tP2QAPHFiUMLbw9aA
         wTlUdDTBuWbEL4G2S75g8ppTLzaeLz5Uf3/9Nh/6mK2rkLJt7KevDilZvGEh3nYSuwNd
         Mh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vHCcWfIEICV286PlzrlDhon26egExA0EzSmCUey5zx8=;
        b=RaVoHYHtIe4x/pDbYrAC43INUVHlLQ1ynZLoe1me9JNXS+UMcea6aE8bwQTFK9eYBB
         xUV4dI7Cis8lx74sk2KPl239A3lKf8f1eFTptrWvO3mHL8wMVq3A4jjb6o0LerlAdZZC
         qYfWtS4wNOMuk+xZat54d7CaXoAL4MFake34JA0Xs1b/tJ2aWZW8k+9nYiVyw8tIjw9o
         tI/XSZl5q7e93QeVQO75taZjaoVY8TiBsyVD1n+bkGx0isfg7Nuz8mfV0BPlv1DYsMoM
         HlOwOGDyIsdC2/2lE8ohSbg9fcXDIqaD1qfRHgq4iuMYTvQsqfux463QPRAnZ350VlZc
         xs4g==
X-Gm-Message-State: AGi0PuY41hKhUhI8A3RDN+21EXC/ErS1rX+1pQYLnXfbC8oUEXH+CJXF
        zrPuaQHLuQf6ARxM1+a/YGQ=
X-Google-Smtp-Source: APiQypI8ZN0KyOTXyMoykSTjnNSFhzlj/ggy7e3jSEAEM/HOQ9fxPmeQ5Yrj2uqnv4+yAUnZjlL2sg==
X-Received: by 2002:ac2:489b:: with SMTP id x27mr2746373lfc.60.1588263383459;
        Thu, 30 Apr 2020 09:16:23 -0700 (PDT)
Received: from localhost.localdomain ([178.233.178.9])
        by smtp.gmail.com with ESMTPSA id k6sm60638lfm.91.2020.04.30.09.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 09:16:22 -0700 (PDT)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Grzegorz Halat <ghalat@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [RFC PATCH v2 0/3] Prefer working VT console over SPCR and device-tree chosen stdout-path
Date:   Thu, 30 Apr 2020 19:14:34 +0300
Message-Id: <20200430161438.17640-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I recently experienced some trouble with setting up an encrypted-root
system, my Chromebook Plus (rk3399-gru-kevin, ARM64) would appear to
hang where it should have asked for an encryption passphrase; and I
eventually figured out that the kernel preferred the serial port
(inaccessible to me) over the built-in working display/keyboard and was
probably asking there.

Running plymouth in the initramfs solves that specific problem, but
both the documentation and tty-related kconfig descriptions imply that
/dev/console should be tty0 if graphics are working, CONFIG_VT_CONSOLE
is enabled and no explicit console argument is given in the kernel
commandline.

However, I'm seeing different behaviour on systems with SPCR (as in QEMU
aarch64 virtual machines) and/or a device-tree chosen stdout-path node
(as in most arm/arm64 devices). On these machines, depending on the
console argument, the contents of the /proc/consoles file are:

                    |     "console=tty0"    |    (no console arg)   |
  ------------------+-----------------------+-----------------------+
  QEMU VM           | tty0     -WU (EC p  ) | ttyAMA0  -W- (EC   a) |
  (w/ SPCR)         | ttyAMA0  -W- (E    a) |                       |
  ------------------+-----------------------+-----------------------+
  Chromebook Plus   | tty0     -WU (EC p  ) | ttyS2    -W- (EC p a) |
  (w/ stdout-path)  |                       | tty0     -WU (E     ) |
  ------------------+-----------------------+-----------------------+
  Chromebook Plus   | tty0     -WU (EC p  ) | tty0     -WU (EC p  ) |
  (w/o either)      |                       |                       |
  ------------------+-----------------------+-----------------------+

This patchset tries to ensure that VT is preferred in those conditions
even in the presence of firmware-mandated serial consoles. These should
cleanly apply onto next-20200430.

More discussion due to or about the console confusion on ARM64:
- My Debian bug report about the initramfs prompts [0]
- Fedora test issue arising from ARM64 QEMU machines having SPCR [1]
- Debian-installer discussion on what to do with multiple consoles [2]

[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=952452
[1] https://bugzilla.redhat.com/show_bug.cgi?id=1661288
[2] https://lists.debian.org/debian-boot/2019/01/msg00184.html

Changes in v2:
- Fix #elif to #else (Reported-by: kbuild test robot <lkp@intel.com>)
- Refresh dmesg outputs with/without earlycon for next-20200430
- Use the correct format when referencing a commit

Alper Nebi Yasak (3):
  printk: Add function to set console to preferred console's driver
  vt: Set as preferred console when a non-dummy backend is bound
  printk: Preset tty0 as a pseudo-preferred console

 drivers/tty/vt/vt.c     |  7 +++++
 include/linux/console.h |  1 +
 kernel/printk/printk.c  | 68 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

-- 
2.26.2

