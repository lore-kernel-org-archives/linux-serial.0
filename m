Return-Path: <SRS0=HBWv=6H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652D9C54FCB
	for <linux-serial@archiver.kernel.org>; Thu, 23 Apr 2020 22:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C3720780
	for <linux-serial@archiver.kernel.org>; Thu, 23 Apr 2020 22:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZYPUz1gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgDWWBA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Apr 2020 18:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgDWWBA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Apr 2020 18:01:00 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21996C09B042
        for <linux-serial@vger.kernel.org>; Thu, 23 Apr 2020 15:01:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so2909404plo.7
        for <linux-serial@vger.kernel.org>; Thu, 23 Apr 2020 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hSobCRVgJYv8jTPKwKrXDNHzB+BBFkTsELb63uGxAd8=;
        b=ZYPUz1gxAH/HgbgmZdKnWT/BQKippmQ+YUiRwZlCEZGBIAMYAtCRpmhtYm1WAA+3Z6
         U1KQ9iddQi7ivCKuN3vwSYdtP/7DdE+9cBZyU6V6I7bXxi3hFy/7Ov7+q+bNHt1WO57r
         WmK4XRUeHrLsaiBE+XYsZeTSdEGxq/H9jsu2TR8r997KWGr1IeYNZmZ/hE0tQtlY7QVL
         pGr4lPo/0j7LglSY9w98a2sZKmMz97Wvf1L7i8fSQqqKK9Xm5dJuPmo+49Tj2iDpjtNY
         Q2qwqDQOFBmZGG0xQBrr/IWmjKA+M1Bs4v1ChRFCyGwuvhSapsQZzxxfpYJIoHPuo6an
         CeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hSobCRVgJYv8jTPKwKrXDNHzB+BBFkTsELb63uGxAd8=;
        b=jzt1G3NQbnAlEYP7H4kIv/j2zTHu4lnHeWh9UxbVPIyLjpupSa8lCzKjCfh+pCyyCI
         zNn6RWX11ZzU94LYVb5aWhuXaFFNAsbREeMb4xbVpvkrwW9L4oRCwGvt8tWPUcTET/MQ
         3v2vu90PVBKRLv/PI3ErLvZYodFvFO1x9VOIM+Zidc6gOyOJy+Sz8V2tq4RtEtaR0XRc
         bYYIE0Sm+wWGnloVGDZuhbfsM70aMB0LZicuhn0+rt6CcgcIWSoVDtdmpK7Egz3Or0jf
         K2pCYQHDoSwrFmyZM0hel52Eu1ULdaOBImNjBM8LL0BEGmAqLhAd1GSTuRCNpyv9GGeK
         AtiQ==
X-Gm-Message-State: AGi0PubeG5vt1CqyrroKMy8oMHU4Vkai33r3vCGOlkXYo3+QQWzR2/Dc
        lvqcuvfOXgEmybPnS+J80m1ing==
X-Google-Smtp-Source: APiQypISQERDQ57ZtP48t/sQ5TT49fdM+AomovaRvC1c3Qrxqba75fl6A5M6o5QVA3yDOF0AVnK91Q==
X-Received: by 2002:a17:90a:f985:: with SMTP id cq5mr2866956pjb.193.1587679259332;
        Thu, 23 Apr 2020 15:00:59 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id 135sm3515843pfu.125.2020.04.23.15.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 15:00:58 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: [RFC][PATCH] serial: amba-pl011: Make sure we initialize the port.lock spinlock
Date:   Thu, 23 Apr 2020 22:00:56 +0000
Message-Id: <20200423220056.29450-1-john.stultz@linaro.org>
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
structure, the pl011 code doesn't initialize the spinlock.

This patch fixes it by initializing the spinlock and the warning
has gone away.

CC: Valentin Schneider <valentin.schneider@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Reported-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
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

