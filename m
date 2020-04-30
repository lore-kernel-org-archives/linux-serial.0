Return-Path: <SRS0=pdp3=6O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5661EC47247
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CFF720873
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ut+QscvU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgD3QQo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726405AbgD3QQo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 12:16:44 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9976C035494;
        Thu, 30 Apr 2020 09:16:43 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f18so7082972lja.13;
        Thu, 30 Apr 2020 09:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8h7c5xM9KdrcmFCqTV2onQc6DhtZm7K0Uq18xje81Wc=;
        b=ut+QscvUUbBbBNa/WL+wGEGeS6FwdRtAH9e4SF8KFy4VBSOrFqJ7zF/QgHmMzpquyc
         7CR59WjbtwZirwn2GLq2Wz6GF4iMjx9ppczRswAzNIMwPkj47IDPxOTuo7nq8G2mlScm
         T9FwkRpWpepH2OiJr4yWdMyxWG/LaBUF9uL/fX66XeNyl0OTjgguO4n1Hmv7LvqxZHMA
         Vb6aIV4J7iOtlCX7z0bV+4neuEiA3GZ0D6BLmZEkDyOXcPEONZe0+m/vdScwgOjsqJrl
         LIYQjWZ63bLItDsp59jL9XwLoR9O8yLfuSLPU6F7gLJml0zo9qWzMqOQxtCMg1/sj+K2
         BHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8h7c5xM9KdrcmFCqTV2onQc6DhtZm7K0Uq18xje81Wc=;
        b=nZBOw927Bv4PHOHPWiq0rkRVEoD0Dl6pl3jU4eUQsG/hvphZq9vkS65Mq1YZWHpgwP
         yFZK6ou4fDrl+XJ1mIt1Lgd2h0wC9r2ggehvhxN3/o+6nauiAySfqEmUTuHTSw2pljTe
         tQD87Ql8mAwvi/jGvyLn8O4U5O2ffCcCAY4vWeSkngR0bFj20ixwAPX7sNlrmzn/VMAf
         bAVIAVU3rprZsg8LqWZyagzpy+ngh5zVLQg2sVjOTUwAzkduOs9rGsf86HQCgX82fA18
         0oyZlJaFKhusYWejW5YJOcXX4eBVga3HXYcZnRSMpsni/zKUnfyFeoZrpAJFC6mt9aRT
         Ihyw==
X-Gm-Message-State: AGi0PuZl+1O0wZK8lW6j7W0oVC8LqT8YzJIUi+Zi0us7nn53xXeSdrAu
        7L+6xv1MyDei+ntAKmVPbGQ=
X-Google-Smtp-Source: APiQypLVsApo9iHgMhuxkN2ZlgYWUMp4fhV4J7W4bsnT2jgzRR8RuWaxI89+qS7fAKHE8DyFsSWe0Q==
X-Received: by 2002:a2e:96cd:: with SMTP id d13mr18383ljj.219.1588263402185;
        Thu, 30 Apr 2020 09:16:42 -0700 (PDT)
Received: from localhost.localdomain ([178.233.178.9])
        by smtp.gmail.com with ESMTPSA id k6sm60638lfm.91.2020.04.30.09.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 09:16:41 -0700 (PDT)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/3] printk: Preset tty0 as a pseudo-preferred console
Date:   Thu, 30 Apr 2020 19:14:37 +0300
Message-Id: <20200430161438.17640-4-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430161438.17640-1-alpernebiyasak@gmail.com>
References: <20200430161438.17640-1-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The ACPI SPCR (Serial Port Console Redirection) table from a machine's
firmware can specify a serial console which can be used for earlycon.
However, in at least ARM64 systems the same device is also set up as the
preferred console.  Presumably due to the order of acpi_parse_spcr and
VT's register_device calls, setting the specified console as the
preferred one can prevent registering VT as a console.

This might look appropriate for machines which do not have or need
working graphics and whose users most likely have access to a serial
port. However, the use of SPCR tables may not be limited these. For
example, ARM64 QEMU virtual machines include a SPCR table regardless of
the existence of a graphics output or even the nonexistence of a serial
console. Or server hardware which has a SPCR table can be repurposed
into a workstation with the addition of a graphics card. As a result,
boot messages and early userspace prompts can go to an unexpected
console.

This patch presets tty0 as a pseudo-preferred console at compile-time to
ensure that CONFIG_VT_CONSOLE always results in the VT console getting
registered. With this, VT can get registered, these other consoles are
preferred when VT is a dummy, but we can also bump up VTs preference
when working graphics are available.

Without this patch, an ARM64 QEMU virtual machine has roughly the
following order of console events and consoles:

	# Without earlycon:
	$ sudo dmesg | grep -i "console\|printk\|tty[0-9a-z]" | grep -v systemd
	[    0.000000] ACPI: SPCR: console: pl011,mmio,0x9000000,9600
	[    0.000250] Console: colour dummy device 80x25
	[    0.140955] ARMH0011:00: ttyAMA0 at MMIO 0x9000000 (irq = 4, base_baud = 0) is a SBSA
	[    0.317189] printk: console [ttyAMA0] enabled
	[    3.540272] Console: switching to colour frame buffer device 150x42

	$ cat /proc/consoles
	ttyAMA0              -W- (EC p a)  204:64

	# With earlycon:
	$ sudo dmesg | grep -i "console\|printk\|tty[0-9a-z]" | grep -v systemd
	[    0.000000] ACPI: SPCR: console: pl011,mmio,0x9000000,9600
	[    0.000000] printk: bootconsole [pl11] enabled
	[    0.002064] Console: colour dummy device 80x25
	[    0.324415] ARMH0011:00: ttyAMA0 at MMIO 0x9000000 (irq = 4, base_baud = 0) is a SBSA
	[    0.327047] printk: console [ttyAMA0] enabled
	[    0.329139] printk: bootconsole [pl11] disabled
	[    3.704937] Console: switching to colour frame buffer device 150x42

	$ cat /proc/consoles
	ttyAMA0              -W- (EC   a)  204:64

In addition, boot messages aren't printed to the framebuffer (as tty0 is
not registered). With this patch, boot messages are visible on the
framebuffer and the information above becomes:

	# Without earlycon:
	$ sudo dmesg | grep -i "console\|printk\|tty[0-9a-z]" | grep -v systemd
	[    0.000000] ACPI: SPCR: console: pl011,mmio,0x9000000,9600
	[    0.000058] Console: colour dummy device 80x25
	[    0.000266] printk: console [tty0] enabled
	[    0.144615] ARMH0011:00: ttyAMA0 at MMIO 0x9000000 (irq = 4, base_baud = 0) is a SBSA
	[    0.299031] printk: console [ttyAMA0] enabled
	[    3.320333] Console: switching to colour frame buffer device 150x42
	[    3.329386] printk: switching to console [tty0]

	$ cat /proc/consoles
	tty0                 -WU (EC p  )    4:7
	ttyAMA0              -W- (E  p a)  204:64

	# With earlycon:
	$ sudo dmesg | grep -i "console\|printk\|tty[0-9a-z]" | grep -v systemd
	[    0.000000] ACPI: SPCR: console: pl011,mmio,0x9000000,9600
	[    0.000000] printk: bootconsole [pl11] enabled
	[    0.002326] Console: colour dummy device 80x25
	[    0.003545] printk: console [tty0] enabled
	[    0.236824] ARMH0011:00: ttyAMA0 at MMIO 0x9000000 (irq = 4, base_baud = 0) is a SBSA
	[    0.239243] printk: console [ttyAMA0] enabled
	[    0.241324] printk: bootconsole [pl11] disabled
	[    3.715086] Console: switching to colour frame buffer device 150x42
	[    3.742923] printk: switching to console [tty0]

	$ cat /proc/consoles
	tty0                 -WU (EC p  )    4:7
	ttyAMA0              -W- (E    a)  204:64

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

---

Changes in v2:
- Fix #elif to #else (Reported-by: kbuild test robot <lkp@intel.com>)
- Refresh dmesg outputs with/without earlycon for next-20200430

 kernel/printk/printk.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index efda422203e4..aa9f9f16860f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -277,7 +277,19 @@ static struct console *exclusive_console;
 
 #define MAX_CMDLINECONSOLES 8
 
+/*
+ * The preferred_console and has_preferred_console variables are
+ * intentionally not modified to reflect this so that the first
+ * registered console is still used as the preferred console.
+ */
+#ifdef CONFIG_VT_CONSOLE
+static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES] = {
+	[0].name = "tty",
+	[0].index = 0,
+};
+#else
 static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
+#endif
 
 static int preferred_console = -1;
 static bool has_preferred_console;
-- 
2.26.2

