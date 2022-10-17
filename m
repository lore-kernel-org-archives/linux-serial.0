Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99ACC433FE
	for <linux-serial@archiver.kernel.org>; Mon, 17 Oct 2022 01:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJQBjZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 16 Oct 2022 21:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJQBjY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 16 Oct 2022 21:39:24 -0400
Received: from gw.atmark-techno.com (gw.atmark-techno.com [13.115.124.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6F3BA6
        for <linux-serial@vger.kernel.org>; Sun, 16 Oct 2022 18:39:21 -0700 (PDT)
Received: from gw.atmark-techno.com (localhost [127.0.0.1])
        by gw.atmark-techno.com (Postfix) with ESMTP id C6D186010D
        for <linux-serial@vger.kernel.org>; Mon, 17 Oct 2022 10:39:20 +0900 (JST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by gw.atmark-techno.com (Postfix) with ESMTPS id 9FD766010C
        for <linux-serial@vger.kernel.org>; Mon, 17 Oct 2022 10:39:19 +0900 (JST)
Received: by mail-pg1-f200.google.com with SMTP id 83-20020a630156000000b0046b208f6ae3so4516065pgb.16
        for <linux-serial@vger.kernel.org>; Sun, 16 Oct 2022 18:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kG7//arFpFAwMfnhlax+scf/1fpMFahAT0i4COuQlG0=;
        b=eVivJlyCYVeVHO5pG2K0Yo81GuuV74dq34YLDwDX+KfXvMihwi5Iz8O14MOMxterY7
         WJ+REZmTzPJJgVxSA8fBMTPy3mwdTPXyS8jtdPwFTzop4kNF3urN+ffO/Md0jfSzN8qO
         h50Yn9r2TN3fNoy3yYqjxMqMt1gX69XY3KkBDqiyDsmdnldWPJ8boluIN8+jkWIBbtE8
         b7Qznv9J9LhkcUFjEbhnHZHQ1TVfZkH+6m2W+Gaq7esOJagWRsrQ5g0ff1Ysc8Y8E+mt
         XhMt/mYzPU4d1F09A84DHw+EBegiTfcNwOeNNWLkwhFRm1/P7qjGf4IOl21doGt9JbKu
         U5kw==
X-Gm-Message-State: ACrzQf0XouWiCWz77zMMnMDspUqNPrTD7HVM5EJCkBPuK5srHPuzc9yq
        CdwKv6NSms2+nXZdzBnjPRDiJQuV93HMNS2CUv9EGjsnUlF5q2kze92jHCOhCIQcU9ZuD2/xJXv
        3mRR84XsVr0hexpk94d5Sll3ydKSK
X-Received: by 2002:a05:6a00:1796:b0:563:723f:7909 with SMTP id s22-20020a056a00179600b00563723f7909mr9933847pfg.76.1665970758713;
        Sun, 16 Oct 2022 18:39:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM78cE8arQ8BBYF3JBLtVFIFRsOB2Aeu5g6Pre4yrN9MIlfXjp1N8WAC6ktKyUV7mm55KevWnw==
X-Received: by 2002:a05:6a00:1796:b0:563:723f:7909 with SMTP id s22-20020a056a00179600b00563723f7909mr9933827pfg.76.1665970758426;
        Sun, 16 Oct 2022 18:39:18 -0700 (PDT)
Received: from pc-0115 (76.125.194.35.bc.googleusercontent.com. [35.194.125.76])
        by smtp.gmail.com with ESMTPSA id m34-20020a634c62000000b004561e7569f8sm5037807pgl.8.2022.10.16.18.39.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Oct 2022 18:39:18 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.96)
        (envelope-from <martinet@pc-0115>)
        id 1okF63-00093d-2q;
        Mon, 17 Oct 2022 10:39:15 +0900
From:   Dominique Martinet <dominique.martinet@atmark-techno.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Roosen Henri <Henri.Roosen@ginzinger.com>,
        linux-serial@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Daisuke Mizobuchi <mizo@atmark-techno.com>,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH 5.10 1/2] serial: core: move RS485 configuration tasks from drivers into core
Date:   Mon, 17 Oct 2022 10:39:08 +0900
Message-Id: <20221017013908.34770-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017013807.34614-1-dominique.martinet@atmark-techno.com>
References: <20221017013807.34614-1-dominique.martinet@atmark-techno.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Lino Sanfilippo <LinoSanfilippo@gmx.de>

Several drivers that support setting the RS485 configuration via userspace
implement one or more of the following tasks:

- in case of an invalid RTS configuration (both RTS after send and RTS on
  send set or both unset) fall back to enable RTS on send and disable RTS
  after send

- nullify the padding field of the returned serial_rs485 struct

- copy the configuration into the uart port struct

- limit RTS delays to 100 ms

Move these tasks into the serial core to make them generic and to provide
a consistent behaviour among all drivers.

Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Link: https://lore.kernel.org/r/20220410104642.32195-2-LinoSanfilippo@gmx.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Upstream commit 0ed12afa5655512ee418047fb3546d229df20aa1 ]
Signed-off-by: Daisuke Mizobuchi <mizo@atmark-techno.com>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---

This has been picked up as it makes the next patch easier to apply

 drivers/tty/serial/serial_core.c | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b578f7090b63..6cc909d44a81 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -42,6 +42,11 @@ static struct lock_class_key port_lock_key;
 
 #define HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
 
+/*
+ * Max time with active RTS before/after data is sent.
+ */
+#define RS485_MAX_RTS_DELAY	100 /* msecs */
+
 static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 					struct ktermios *old_termios);
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout);
@@ -1326,8 +1331,36 @@ static int uart_set_rs485_config(struct uart_port *port,
 	if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
 		return -EFAULT;
 
+	/* pick sane settings if the user hasn't */
+	if (!(rs485.flags & SER_RS485_RTS_ON_SEND) ==
+	    !(rs485.flags & SER_RS485_RTS_AFTER_SEND)) {
+		dev_warn_ratelimited(port->dev,
+			"%s (%d): invalid RTS setting, using RTS_ON_SEND instead\n",
+			port->name, port->line);
+		rs485.flags |= SER_RS485_RTS_ON_SEND;
+		rs485.flags &= ~SER_RS485_RTS_AFTER_SEND;
+	}
+
+	if (rs485.delay_rts_before_send > RS485_MAX_RTS_DELAY) {
+		rs485.delay_rts_before_send = RS485_MAX_RTS_DELAY;
+		dev_warn_ratelimited(port->dev,
+			"%s (%d): RTS delay before sending clamped to %u ms\n",
+			port->name, port->line, rs485.delay_rts_before_send);
+	}
+
+	if (rs485.delay_rts_after_send > RS485_MAX_RTS_DELAY) {
+		rs485.delay_rts_after_send = RS485_MAX_RTS_DELAY;
+		dev_warn_ratelimited(port->dev,
+			"%s (%d): RTS delay after sending clamped to %u ms\n",
+			port->name, port->line, rs485.delay_rts_after_send);
+	}
+	/* Return clean padding area to userspace */
+	memset(rs485.padding, 0, sizeof(rs485.padding));
+
 	spin_lock_irqsave(&port->lock, flags);
 	ret = port->rs485_config(port, &rs485);
+	if (!ret)
+		port->rs485 = rs485;
 	spin_unlock_irqrestore(&port->lock, flags);
 	if (ret)
 		return ret;
-- 
2.35.1


