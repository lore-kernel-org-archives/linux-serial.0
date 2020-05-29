Return-Path: <SRS0=RakX=7L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05987C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 29 May 2020 11:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D82692075A
	for <linux-serial@archiver.kernel.org>; Fri, 29 May 2020 11:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/pFoFsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgE2LGw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 May 2020 07:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2LGv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 May 2020 07:06:51 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514CEC03E969;
        Fri, 29 May 2020 04:06:51 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gl26so1637558ejb.11;
        Fri, 29 May 2020 04:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Qrt/M6ESkhAHYOhCagfsNNbU0iRRKlGQGvvz+MpDCI=;
        b=d/pFoFsJEbZkDRHl8C3A5NoY1WvxEvuXxnoEEyBlb7Ixf/1XXQyJj5Kp+eCc/gH1uk
         DapBeiWr2v5LlJoHs5ARSvFO4ZEkGzmZLq4BZKm14sBzPnw4Fs2C1SwL5amP8s8w35BL
         dtDZRejSjTrcFR/yJVeMa3E+r5X4hOgR8cyzexoaVVMCZGF1Hf3wOOkj5OskDpP3nXk0
         N3kgLQS4wbRjH83Nejs8KHTt1AMcF4WuK5UDJ+7eS3nESoy6cs0Tg+0bFJ3ysn2gT+/g
         exPruriM5g+Ia/8+48SiACXTDDo5GOBOdcou2Sekro78abWEAiJ9J2IlzLaO0fbzOa0/
         jN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Qrt/M6ESkhAHYOhCagfsNNbU0iRRKlGQGvvz+MpDCI=;
        b=N9gc94AcMoqMojiLBwAezradk3E76jTeffupxy/vdz4l1pqXdFzY0MsAgl0Tg48YuN
         sHidTt+Pdb0CL/6rTCKC51SV+ihQr6tRZiFQ+lvLCI+yesYJw1syTgzbQXBM0o7kZaNi
         RMzetRbCAQcHDtoEGcre5wcDVNf9UFTjGD/G5npJpxpjoskRs4vpGCNNpm/AIaHl5LTc
         SZQG48eX7RtLEw3JX0mPYZgvs8zpngp9SCRGv20C8+C+YqqlNCG8ajQNbTpoCnTWtJi4
         CzUVEn8exxCVRxdpHxIxOTun5DH7vz/rlCJx+FLUZ6W5BO9zJk27NgPWH87QHNIm0naV
         ixgQ==
X-Gm-Message-State: AOAM533kldtJn5MFYa0msnl2DcBoG4poQ1rOHiq+iKZnOC/IfhieFyWn
        qMIrvzUB/o0iEBTRUc8t6Z0=
X-Google-Smtp-Source: ABdhPJwSYAUA1tEGXMKk2UbE0RYx2jAbIfjeWFqmHFpDQjctaZBHpvJ2BW+4mwajo0IjUMU8Zrhgbw==
X-Received: by 2002:a17:907:9d8:: with SMTP id bx24mr7011248ejc.517.1590750409945;
        Fri, 29 May 2020 04:06:49 -0700 (PDT)
Received: from localhost.localdomain ([188.27.38.213])
        by smtp.gmail.com with ESMTPSA id 64sm6734004eda.85.2020.05.29.04.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 04:06:49 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: [PATCH 1/1] tty: serial: owl: Initialize lock before registering port
Date:   Fri, 29 May 2020 14:06:47 +0300
Message-Id: <89f6393934fc6d493f8b9e87c1a6e916642b6a18.1590749143.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Running a lockdep-enabled kernel leads to the following splat when
probing the owl-uart driver:

[    1.271784] b0124000.serial: ttyOWL2 at MMIO 0xb0124000 (irq = 22, base_baud = 1500000) is a owl-uart
[    1.281226] INFO: trying to register non-static key.
[    1.286179] the code is fine but needs lockdep annotation.
[    1.291648] turning off the locking correctness validator.
[    1.297125] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc7+ #70
[    1.303462] Hardware name: Generic DT based system
[    1.308268] [<80111d3c>] (unwind_backtrace) from [<8010c9b8>] (show_stack+0x10/0x14)
[    1.316003] [<8010c9b8>] (show_stack) from [<805016b4>] (dump_stack+0xb4/0xe0)
[    1.323218] [<805016b4>] (dump_stack) from [<80182dec>] (register_lock_class+0x25c/0x8f4)
[    1.331391] [<80182dec>] (register_lock_class) from [<8017ee34>] (__lock_acquire+0xb4/0x2ee4)
[    1.339901] [<8017ee34>] (__lock_acquire) from [<8018291c>] (lock_acquire+0x424/0x4c8)
[    1.347813] [<8018291c>] (lock_acquire) from [<808597b0>] (_raw_spin_lock_irqsave+0x54/0x68)
[    1.356242] [<808597b0>] (_raw_spin_lock_irqsave) from [<80582e94>] (uart_add_one_port+0x384/0x510)
[    1.365276] [<80582e94>] (uart_add_one_port) from [<8058b4d0>] (owl_uart_probe+0x1bc/0x248)
[    1.373621] [<8058b4d0>] (owl_uart_probe) from [<8059c0e4>] (platform_drv_probe+0x48/0x94)
[    1.381874] [<8059c0e4>] (platform_drv_probe) from [<805997c4>] (really_probe+0x200/0x470)
[    1.390123] [<805997c4>] (really_probe) from [<80599c80>] (driver_probe_device+0x16c/0x1bc)
[    1.398461] [<80599c80>] (driver_probe_device) from [<80599f18>] (device_driver_attach+0x44/0x60)
[    1.407317] [<80599f18>] (device_driver_attach) from [<8059a078>] (__driver_attach+0x144/0x14c)
[    1.416000] [<8059a078>] (__driver_attach) from [<805978ac>] (bus_for_each_dev+0x5c/0xb4)
[    1.424162] [<805978ac>] (bus_for_each_dev) from [<8059896c>] (bus_add_driver+0x118/0x204)
[    1.432410] [<8059896c>] (bus_add_driver) from [<8059ae6c>] (driver_register+0xbc/0xf8)
[    1.440405] [<8059ae6c>] (driver_register) from [<80c1fd24>] (owl_uart_init+0x20/0x40)
[    1.448313] [<80c1fd24>] (owl_uart_init) from [<801021d8>] (do_one_initcall+0x184/0x3a4)
[    1.456399] [<801021d8>] (do_one_initcall) from [<80c01100>] (kernel_init_freeable+0x264/0x2e4)
[    1.465085] [<80c01100>] (kernel_init_freeable) from [<80850a88>] (kernel_init+0x8/0x110)
[    1.473249] [<80850a88>] (kernel_init) from [<80100114>] (ret_from_fork+0x14/0x20)
[    1.480800] Exception stack(0xee8bdfb0 to 0xee8bdff8)
[    1.485841] dfa0:                                     00000000 00000000 00000000 00000000
[    1.494002] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.502162] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.508914] printk: console [ttyOWL2] enabled

The locking issue occurs in uart_configure_port() when trying to
guard the call to set_mctrl().

uart_add_one_port() should normally initialize the spinlock via
uart_port_spin_lock_init(), but it never happens because the port is
detected as a console and, as a consequence, the spinlock is expected
to be already initialized.

The commit a3cb39d258ef
("serial: core: Allow detach and attach serial device for console")
changed the lock initialization logic to assume the spinlock is
initialized even if the console is not enabled.

Therefore, initialize the lock explicitly in owl_uart_probe(), before
attempting to invoke uart_add_one_port().

Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/tty/serial/owl-uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index c149f8c30007..c2fa2f15d50a 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -705,6 +705,8 @@ static int owl_uart_probe(struct platform_device *pdev)
 	owl_uart_ports[pdev->id] = owl_port;
 	platform_set_drvdata(pdev, owl_port);
 
+	spin_lock_init(&owl_port->port.lock);
+
 	ret = uart_add_one_port(&owl_uart_driver, &owl_port->port);
 	if (ret)
 		owl_uart_ports[pdev->id] = NULL;
-- 
2.26.2

