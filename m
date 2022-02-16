Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E32C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 16 Feb 2022 15:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiBPPJT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:09:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiBPPJS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Feb 2022 10:09:18 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23820204D82
        for <linux-serial@vger.kernel.org>; Wed, 16 Feb 2022 07:09:06 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v12so4005152wrv.2
        for <linux-serial@vger.kernel.org>; Wed, 16 Feb 2022 07:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fkd7++A5MRcavHatrd5O2+MvruhQWByLsLjOVwU5ABU=;
        b=c8j2gTLCUB6r+qgXI36CTSH8a76rH+BFUTQ41YYl3Mu2MgunFZS//a4ioxnPvJTwy2
         KvxMCQxpMoFZN6axI39pEqqDblCbTyQwrfwvuPOXrCld5EFxvDP1E4qCDQRXN/MaeGuT
         4RavpUmpwHU56fHPoVwPwPee1GEj9fsSDInZEzVdsdFH34zcsYZs/h5lnMK6TERKgbQm
         XE/LHfgCCZ7nmOvdQ+2x2sEAK16G0m0wpypxv0k6qc1AnOESfv0tc2hZCmnflyMFT64X
         0daW/QOkffC8T62DSvlCJeR/ic3eF9xjAiuT29Y1gbBCFu8HHRnWkYXuoiqU307PLAPU
         JZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fkd7++A5MRcavHatrd5O2+MvruhQWByLsLjOVwU5ABU=;
        b=yuz9T1gbVSC/BcGd396fsNf0ykO+DyxF+cvu3Bu+O5qUZo/cx4MCQhyoKnzDMFDhNB
         DK+bUemj2lB1WfwB5ynQyA0pBWZ/q8BdY2AoJQ+DhsJXT+rXJmQfYucKQ7XH9m/qQHhv
         OjXnw4ZNFAvD7LfP8W7XR3eEJNSTN2BzEnbPiqPvcpCLn/Keyu2D3xHIockbz/XvldwU
         /pC+aT5gSi+BDeBdCIofK/zs43lqCsQEQooIX4llFGx470TDbY9Tb9evRGl9U3p+fgB2
         aULhT7pJjVKt2GjCWORSGFHN0itKVPmrxxHxvD1Mmj1NIRETAkSaElaF7muIMQkOcefl
         Lugw==
X-Gm-Message-State: AOAM531CuohkW7MHSmY+oEQE66Rrz7MyPi5KCNSQ1YSxPuQu3/pCly3U
        ZS+W8gZZ7r3+Ff4KEeTAYloMiXNaxc6AOQ==
X-Google-Smtp-Source: ABdhPJxtGk6HvntPFUY6QgMfQiKIjEf7D01VeCGXOUHXdhDp4115lsySnz6VGeNExao8yUF6STLVMw==
X-Received: by 2002:a5d:4d0c:0:b0:1e3:364a:c95f with SMTP id z12-20020a5d4d0c000000b001e3364ac95fmr2738564wrt.115.1645024144663;
        Wed, 16 Feb 2022 07:09:04 -0800 (PST)
Received: from buildbot.pitowers.org ([2a00:1098:3142:14:ae1f:6bff:fedd:de54])
        by smtp.gmail.com with ESMTPSA id e9sm17753080wme.12.2022.02.16.07.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 07:09:03 -0800 (PST)
From:   Phil Elwell <phil@raspberrypi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH] sc16is7xx: Fix for incorrect data being transmitted
Date:   Wed, 16 Feb 2022 15:08:58 +0000
Message-Id: <20220216150858.1016784-1-phil@raspberrypi.com>
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

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
---
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

