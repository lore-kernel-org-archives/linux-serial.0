Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B35C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 16 Feb 2022 16:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiBPQIZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:08:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbiBPQIZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Feb 2022 11:08:25 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B108B6C2
        for <linux-serial@vger.kernel.org>; Wed, 16 Feb 2022 08:08:12 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id e3so4351323wra.0
        for <linux-serial@vger.kernel.org>; Wed, 16 Feb 2022 08:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lt9tQQoGLRjnuysLrSe/jRLUBDMbgb/04f7vPTiQxT0=;
        b=JRahxOBdgxxSi9x0SS+V5Y1HEd8c7uumE5ynZ4OykEYot1oZkapm2pum9wVc5Lb7+e
         x5AbKPknAozqZ4Y2pqEEG9mp7tWmcdRjUBSjfakJJTWRwhUfYJt1n2a07dQvD+creT2Q
         89qtRpxT/7IME+tvm1JcXRbF6tEDHe4b1YZESgQr2URC9kaBFN8lQmZgPvAyiAtLo5YO
         gTWQmDZ7s3j7MMtn/BUEh9tZnzFUIvft7Yg5EDkOp5gBvwsNgweYXtlsQ4TFcfwm8ba5
         Uvls/O4PRhu/FMr8DOlDwL/ZVH/BaH1e7zsIIIr57lNX5rw+mwIMH9FVhHP909DV+TUR
         7gJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lt9tQQoGLRjnuysLrSe/jRLUBDMbgb/04f7vPTiQxT0=;
        b=1L0GSSd86Brf2OyTeKHUWOCypr/r3Iu6HuTXYg5OSAVfKVewSATgO+eP6eEypTiu3w
         JfDorv8IraXmb1VG22nJEqQUBmUGGwGxcCeKvDkBxiZXAwn70L8Gfm2/a+AlSyPA9S/p
         M27xI0tSRVApZrjB3JbngCenuXkREDcU31eioahgKIRdjtl6402ZM9lpziTN6DkI0kG5
         RUSVwRy/648sSXkVT0HdmM4ooddg3E4tqBHkgOsVwcdYZYnFPn+dv7FnBKplDZWOQPFJ
         Wd2onbqcUYwMZjRUJU+U/zqVbL+Bkfp9C6C2VnZTs+n56dLLEEGa1U0f5fWJwurz/zI8
         GeBA==
X-Gm-Message-State: AOAM533rAc84dGoxfdT7eg0f2oSx+YCQwu1ZzoyQtgxdHKhKYXGcQiDD
        VpfvyI/JXXtO6Uezy+No5EgTUwyrFrjV0g==
X-Google-Smtp-Source: ABdhPJwYw23AmeiDfrA+ypOCZl/tW/4e/vlnIn60AcXAe521wKZjvk3AkyVmuffpTcXcHXQHjkoYRw==
X-Received: by 2002:a5d:48d1:0:b0:1e3:2401:f229 with SMTP id p17-20020a5d48d1000000b001e32401f229mr2882347wrs.694.1645027690946;
        Wed, 16 Feb 2022 08:08:10 -0800 (PST)
Received: from buildbot.pitowers.org ([2a00:1098:3142:14:ae1f:6bff:fedd:de54])
        by smtp.gmail.com with ESMTPSA id 1sm17871638wmk.16.2022.02.16.08.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 08:08:10 -0800 (PST)
From:   Phil Elwell <phil@raspberrypi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Daniel Mack <daniel@zonque.org>, linux-serial@vger.kernel.org
Cc:     Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH v2] sc16is7xx: Fix for incorrect data being transmitted
Date:   Wed, 16 Feb 2022 16:08:02 +0000
Message-Id: <20220216160802.1026013-1-phil@raspberrypi.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

UART drivers are meant to use the port spinlock within certain
methods, to protect against reentrancy. The sc16is7xx driver does
very little locking, presumably because when added it triggers
"scheduling while atomic" errors. This is due to the use of mutexes
within the regmap abstraction layer, and the mutex implementation's
habit of sleeping the current thread while waiting for access.
Unfortunately this lack of interlocking can lead to corruption of
outbound data, which occurs when the buffer used for I2C transmission
is used simultaneously by two threads - a work queue thread running
sc16is7xx_tx_proc, and an IRQ thread in sc16is7xx_port_irq, both
of which can call sc16is7xx_handle_tx.

An earlier patch added efr_lock, a mutex that controls access to the
EFR register. This mutex is already claimed in the IRQ handler, and
all that is required is to claim the same mutex in sc16is7xx_tx_proc.

See: https://github.com/raspberrypi/linux/issues/4885

Fixes: 6393ff1c4435 ("sc16is7xx: Use threaded IRQ")
Signed-off-by: Phil Elwell <phil@raspberrypi.com>
---
v2: Add Fixes: tag.

 drivers/tty/serial/sc16is7xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 25d67b8c4db7..3a6c68e19c80 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -734,12 +734,15 @@ static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
 static void sc16is7xx_tx_proc(struct kthread_work *ws)
 {
 	struct uart_port *port = &(to_sc16is7xx_one(ws, tx_work)->port);
+	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 
 	if ((port->rs485.flags & SER_RS485_ENABLED) &&
 	    (port->rs485.delay_rts_before_send > 0))
 		msleep(port->rs485.delay_rts_before_send);
 
+	mutex_lock(&s->efr_lock);
 	sc16is7xx_handle_tx(port);
+	mutex_unlock(&s->efr_lock);
 }
 
 static void sc16is7xx_reconf_rs485(struct uart_port *port)
-- 
2.25.1

