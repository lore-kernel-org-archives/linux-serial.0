Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEBEC83004
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 18:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DB3420575
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 18:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q5vsKd5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbgD1SqI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731254AbgD1Sne (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 14:43:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63284C03C1AB
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 11:43:34 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x26so10843478pgc.10
        for <linux-serial@vger.kernel.org>; Tue, 28 Apr 2020 11:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BW+Um+UGb0iUWkx+XSMpz8/xZvRFEsv5sCv53qINszQ=;
        b=q5vsKd5z2Id3W7Fztqh0E0KsZBfS2jaMH+m9IqvY5E+w0VAtx7AEp3igY7i3HqRnbI
         j66bawXeiZVpGfJ0diArxfrCn2uVdtb2ODXktvZPdenVlHpWTm/s4lj85iUvVTnY1R/J
         uwgHnXg66485vsrnvo2MFuGxQIW0fcgjkbBmAymEj1eez8kdDMQ1AnIlri5gy9TnZDMQ
         sZ5VldUlSmC2JvVvMqWgKcNlZuVu/JEHIa0UcmBjWDp0nkJiJ6KlG2c8h5gpmS4pB5T+
         8y+k1Zl6yA6bCaCiWR4vWRGvQXvD2n473D48gHqMt7F+E1R2y0AhRIGWrzg4mLM8lQdl
         wjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BW+Um+UGb0iUWkx+XSMpz8/xZvRFEsv5sCv53qINszQ=;
        b=gMm7RmB4Tlbnub+DiFDJTA+aE5KgnKsG2ivMxId42bKZLqPV+eZMMP13ZAyMv6zQpM
         Ao/gJMRELqhCbz/h7kAM2DxXGhl4N28Tk8X82BJt8zDP0W2yihCgwlSP6yWwanumATJC
         ffoQ7KXOVLHsFGHwOF20ttMoq2sWKajBh27tbD+lpdP/RfnkLZLWXxSkBFkt8v8roVHn
         8aRp8qmFQ9oqful+aeLdMtt6njpgEbPxfhcw/9Il74kdU/0MHv24nd6nlJEGmDXP21+1
         16wTYhVvmoqQ+XdHLcG2KDijnxL3jY9jPaJ95eBT8WZPRz/DDfxwSjWvOEo6MgoBXZzE
         fNMw==
X-Gm-Message-State: AGi0PuaUVQBE3PwgszjYsJL8up/1NJt4psk+9e1TASWoNu1pNerNlCAQ
        4Tm27yOtaupUm4TYbRMlzMKNFA==
X-Google-Smtp-Source: APiQypIpotlBs1YsvBB8S5sO68j1K3mpsjTEMOhodWnMmqbJpZWED/LQQvJzTabxyGRXRckGHoEmTA==
X-Received: by 2002:a62:158f:: with SMTP id 137mr28936022pfv.219.1588099413768;
        Tue, 28 Apr 2020 11:43:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id v133sm15780763pfc.113.2020.04.28.11.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 11:43:33 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [PATCH v2] serial: amba-pl011: Make sure we initialize the port.lock spinlock
Date:   Tue, 28 Apr 2020 18:40:50 +0000
Message-Id: <20200428184050.6501-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Valentine reported seeing:

[    3.626638] INFO: trying to register non-static key.
[    3.626639] the code is fine but needs lockdep annotation.
[    3.626640] turning off the locking correctness validator.
[    3.626644] CPU: 7 PID: 51 Comm: kworker/7:1 Not tainted 5.7.0-rc2-00115-g8c2e9790f196 #116
[    3.626646] Hardware name: HiKey960 (DT)
[    3.626656] Workqueue: events deferred_probe_work_func
[    3.632476] sd 0:0:0:0: [sda] Optimal transfer size 8192 bytes not a multiple of physical block size (16384 bytes)
[    3.640220] Call trace:
[    3.640225]  dump_backtrace+0x0/0x1b8
[    3.640227]  show_stack+0x20/0x30
[    3.640230]  dump_stack+0xec/0x158
[    3.640234]  register_lock_class+0x598/0x5c0
[    3.640235]  __lock_acquire+0x80/0x16c0
[    3.640236]  lock_acquire+0xf4/0x4a0
[    3.640241]  _raw_spin_lock_irqsave+0x70/0xa8
[    3.640245]  uart_add_one_port+0x388/0x4b8
[    3.640248]  pl011_register_port+0x70/0xf0
[    3.640250]  pl011_probe+0x184/0x1b8
[    3.640254]  amba_probe+0xdc/0x180
[    3.640256]  really_probe+0xe0/0x338
[    3.640257]  driver_probe_device+0x60/0xf8
[    3.640259]  __device_attach_driver+0x8c/0xd0
[    3.640260]  bus_for_each_drv+0x84/0xd8
[    3.640261]  __device_attach+0xe4/0x140
[    3.640263]  device_initial_probe+0x1c/0x28
[    3.640265]  bus_probe_device+0xa4/0xb0
[    3.640266]  deferred_probe_work_func+0x7c/0xb8
[    3.640269]  process_one_work+0x2c0/0x768
[    3.640271]  worker_thread+0x4c/0x498
[    3.640272]  kthread+0x14c/0x158
[    3.640275]  ret_from_fork+0x10/0x1c

Which seems to be due to the fact that after allocating the uap
structure, nothing initializes the spinlock.

Its a little confusing, as uart_port_spin_lock_init() is one
place where the lock is supposed to be initialized, but it has
an exception for the case where the port is a console.

This makes it seem like a deeper fix is needed to properly
register the console, but I'm not sure what that entails, and
Andy suggested that this approach is less invasive.

Thus, this patch resolves the issue by initializing the spinlock
in the driver, and resolves the resulting warning.

Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Reported-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Added extra context in the commit message
---
 drivers/tty/serial/amba-pl011.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 2296bb0f9578..458fc3d9d48c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2575,6 +2575,7 @@ static int pl011_setup_port(struct device *dev, struct uart_amba_port *uap,
 	uap->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_AMBA_PL011_CONSOLE);
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = index;
+	spin_lock_init(&uap->port.lock);
 
 	amba_ports[index] = uap;
 
-- 
2.17.1

