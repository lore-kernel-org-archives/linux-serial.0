Return-Path: <SRS0=pdp3=6O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28561C4724C
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0067F208C3
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 16:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+ltUI3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgD3QQj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726405AbgD3QQi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 12:16:38 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92165C035494;
        Thu, 30 Apr 2020 09:16:38 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 188so1706567lfa.10;
        Thu, 30 Apr 2020 09:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4TIH8T2iwoy55Ek+4uzhpC1K3VxmoO9RghZLrsLIIU=;
        b=f+ltUI3klX7y7558UAfiJcLaATEoefw+BMqDr8OH8fF8pzj+J2m70msHpKH57IMN/G
         CeFOpjAq9DVo8HCD85cPTH1DNF/I1uGD2I4dSPwfDg9FZVFOF8CPw3PQqKYM4RLjavnU
         SVeUbxBJiXKOKzdIkvmfdLeFLEjE4UjMRoyzzP8nAMdD0St8Ge5acgahuYKIAgNnXqxG
         u1Wyrl/CU7E7J0lgVSfiGGxSNsvA7RncjakrnyQEoaaVu9xIDTem5xeJj/cZcH+cDABx
         VIMA2YSzihLF6GVMffFXG8Tkq+EJfXpesZnUK/avHiN/rXxGlskNz86CVExnyw27nXPX
         Cmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4TIH8T2iwoy55Ek+4uzhpC1K3VxmoO9RghZLrsLIIU=;
        b=BK9aCU4m9bdB+RMlX5sH0ZfjLzwjNG2PLLQnehWTNKO0n1rEuoY33b45E0kh8n+8QP
         Asoadwi2K9zUWeSWIthiaTUZHS/seJJpYPmMIbm3xJgU5ZG0KnnT73Z9tfxi6XmX0ryY
         5QoPQ2PhdSo7/xWffybdb7AcMWzMGsEr/yn9uB3akCn76pVUPEyDeGA9jUetUj9ftTVg
         iQKMfLWh2GLHXaRHlr17AdhyiYRd4LWPoFGuKbTmcmiF48rHeIj52cYCJxt8y4eaqkv8
         askkkVm0dLzO7Vh9oMVz4sGOdx9ghY/RGL0HMrkVxPMhYe6RLq86G2NHwIDHu9tOj2+y
         /xdg==
X-Gm-Message-State: AGi0PuayqloJvd8mJVbj1UT44HJPxXDEth3205SMVS3pt7wq3SACnCxV
        1EesYrWcNqBOWR8icTUxBKY=
X-Google-Smtp-Source: APiQypKW0OOMGsBaRso8KpIF88W8pneAiyKgyjSDkdDS+lc6s6+VB6QTd8CG5k93j4XxhkCbFMDS7g==
X-Received: by 2002:ac2:4105:: with SMTP id b5mr2763461lfi.94.1588263397052;
        Thu, 30 Apr 2020 09:16:37 -0700 (PDT)
Received: from localhost.localdomain ([178.233.178.9])
        by smtp.gmail.com with ESMTPSA id k6sm60638lfm.91.2020.04.30.09.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 09:16:36 -0700 (PDT)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     linux-serial@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Eric Biggers <ebiggers@google.com>,
        Grzegorz Halat <ghalat@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Nicolas Pitre <nico@fluxnic.net>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [RFC PATCH v2 2/3] vt: Set as preferred console when a non-dummy backend is bound
Date:   Thu, 30 Apr 2020 19:14:36 +0300
Message-Id: <20200430161438.17640-3-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430161438.17640-1-alpernebiyasak@gmail.com>
References: <20200430161438.17640-1-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When a machine's device-tree has a "chosen" node with a "stdout-path"
property that specified console is added as the preferred console by
of_console_check via an add_preferred_console call. The property is
quite common in kernel device-tree definitions. As far as I can tell, it
is set to provide a reasonable default value for earlycon, and the
(usually serial) console is set as preferred to avoid output going to
VT's dummy backend instead of a working console.

However, a chosen stdout-path property is included even in device-trees
of systems that are designed to be used with a built-in display, e.g.
several ARM Chromebooks. In these cases where CONFIG_VT_CONSOLE is
enabled and no console argument is given on the kernel commandline, tty0
is still registered (presumably based on the order of of_console_check
and vt's register_console calls) but ends up not being the preferred
console.

As a result, it is possible for early userspace prompts (encryption
passphrase requests, emergency shells) to end up in a console that the
user doesn't expect or even have access to.

This patch tries to set tty0 as the /dev/console whenever a non-dummy
backend tries to register as its default, unless the preferred console
was set from the kernel commandline arguments.

On a Samsung Chromebook Plus (Google Kevin, rk3399-gru-kevin.dts), boot
messages are still visible on the framebuffer without this patch, but it
isn't the preferred console due to the device-tree having a stdout-path
property (from rk3399-gru.dtsi):

	# Without earlycon:
	$ sudo dmesg | grep -i "console\|printk\|tty[0-9a-z]" | grep -v systemd
	[    0.001447] Console: colour dummy device 80x25
	[    0.001820] printk: console [tty0] enabled
	[    3.012303] ff1a0000.serial: ttyS2 at MMIO 0xff1a0000 (irq = 39, base_baud = 1500000) is a 16550A
	[    4.326549] printk: console [ttyS2] enabled
	[    5.521780] dw-apb-uart ff1a0000.serial: forbid DMA for kernel console
	[    6.359706] Console: switching to colour frame buffer device 300x100

	$ cat /proc/consoles
	ttyS2                -W- (EC p a)    4:66
	tty0                 -WU (E  p  )    4:7

	# With earlycon:
	$ sudo dmesg | grep -i "console\|printk\|tty[0-9a-z]" | grep -v systemd
	[    0.000000] printk: bootconsole [uart0] enabled
	[    0.010257] Console: colour dummy device 80x25
	[    0.015131] printk: console [tty0] enabled
	[    0.019625] printk: bootconsole [uart0] disabled
	[    3.034305] ff1a0000.serial: ttyS2 at MMIO 0xff1a0000 (irq = 39, base_baud = 1500000) is a 16550A
	[    4.367601] printk: console [ttyS2] enabled
	[    5.576519] dw-apb-uart ff1a0000.serial: forbid DMA for kernel console
	[    6.435612] Console: switching to colour frame buffer device 300x100

	$ cat /proc/consoles
	ttyS2                -W- (EC p a)    4:66
	tty0                 -WU (E     )    4:7

And on the same machine, with this patch:

	# Without earlycon:
	$ sudo dmesg | grep -i "console\|printk\|tty[0-9a-z]" | grep -v systemd
	[    0.001451] Console: colour dummy device 80x25
	[    0.001821] printk: console [tty0] enabled
	[    3.013821] ff1a0000.serial: ttyS2 at MMIO 0xff1a0000 (irq = 39, base_baud = 1500000) is a 16550A
	[    4.328053] printk: console [ttyS2] enabled
	[    5.509658] dw-apb-uart ff1a0000.serial: forbid DMA for kernel console
	[    6.309330] Console: switching to colour frame buffer device 300x100
	[    6.378862] printk: switching to console [tty0]

	$ cat /proc/consoles
	tty0                 -WU (EC p  )    4:7
	ttyS2                -W- (E  p a)    4:66

	# With earlycon:
	$ sudo dmesg | grep -i "console\|printk\|tty[0-9a-z]" | grep -v systemd
	[    0.000000] printk: bootconsole [uart0] enabled
	[    0.010259] Console: colour dummy device 80x25
	[    0.015135] printk: console [tty0] enabled
	[    0.019628] printk: bootconsole [uart0] disabled
	[    3.037677] ff1a0000.serial: ttyS2 at MMIO 0xff1a0000 (irq = 39, base_baud = 1500000) is a 16550A
	[    4.370985] printk: console [ttyS2] enabled
	[    5.549226] dw-apb-uart ff1a0000.serial: forbid DMA for kernel console
	[    6.364818] Console: switching to colour frame buffer device 300x100
	[    6.417589] printk: switching to console [tty0]

	$ cat /proc/consoles
	tty0                 -WU (EC    )    4:7
	ttyS2                -W- (E  p a)    4:66

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

---

Changes in v2:
- Refresh dmesg outputs with/without earlycon for next-20200430

 drivers/tty/vt/vt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e5ffed795e4c..218171dca711 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3588,6 +3588,13 @@ static int do_bind_con_driver(const struct consw *csw, int first, int last,
 		pr_cont("to %s\n", desc);
 	}
 
+#ifdef CONFIG_VT_CONSOLE
+	if (!console_set_on_cmdline && deflt && conswitchp != &dummy_con) {
+		add_preferred_console("tty", 0, NULL);
+		update_console_to_preferred();
+	}
+#endif
+
 	retval = 0;
 err:
 	module_put(owner);
-- 
2.26.2

