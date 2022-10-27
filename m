Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9814FFA373E
	for <linux-serial@archiver.kernel.org>; Thu, 27 Oct 2022 00:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiJ0AUA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Oct 2022 20:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiJ0AT7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Oct 2022 20:19:59 -0400
Received: from gw.atmark-techno.com (gw.atmark-techno.com [13.115.124.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2959938A3F
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 17:19:52 -0700 (PDT)
Received: from gw.atmark-techno.com (localhost [127.0.0.1])
        by gw.atmark-techno.com (Postfix) with ESMTP id 427526013E
        for <linux-serial@vger.kernel.org>; Thu, 27 Oct 2022 09:19:51 +0900 (JST)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by gw.atmark-techno.com (Postfix) with ESMTPS id 4A0F46013C
        for <linux-serial@vger.kernel.org>; Thu, 27 Oct 2022 09:19:50 +0900 (JST)
Received: by mail-pg1-f199.google.com with SMTP id h2-20020a656382000000b0044b0f6c572fso8911573pgv.20
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 17:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qfZ9R7q2Lgo19/7Oj4ib2QifeanwUUpIwCxGFd3DVaM=;
        b=pvzynBd/VC0ZIrItvH/gQuU99F4s7HkPxnN63qcATXtLRnkRL/+skWxe8qDvDTNJDh
         f3TrKrDM6M7whdkgRGN2OyGMQG3+ovaqO2X+QEU4+soj8acb+WPClRgQec7aUIr70Q9B
         GGEXLQLy3Hu3wYE4FMmP1nULNq95DJM6LvX9OIhnEPPaxK1uRLbF8FTSTZJAdPMDulue
         WpUTWoZifH0WWfwB35LyCPBRI+PVjq+peryH9GwvPDZDbxWTIvSZ/U9pEM48bYMvw+Oy
         rRw3bwxFS9cjQqlaDEY5aTuQFdzDxFuxpPtNct0Lh0GvsiLUMukNh74aWaJkv+NWxkqI
         L6CQ==
X-Gm-Message-State: ACrzQf054roxC3jbe18lQJNSJrPCGvI1Ow9heg8CZPTJ2SNmCzQvTdZq
        gFCC89Tdg6qxtpDIHfYJqsLrsk6/ARGnicZUVqR09576PB5p46ZflOuZ1x7Od4xoPEuepBnw6ap
        Y/LuARXx+tB3qNJMzPzI1hJC2sJNk
X-Received: by 2002:a63:5f54:0:b0:462:1149:f3b3 with SMTP id t81-20020a635f54000000b004621149f3b3mr39853623pgb.445.1666829989362;
        Wed, 26 Oct 2022 17:19:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5XRay6tkiWUM/SfLYwR8yU9i3mUiMf0Ev2VgcUkiInEiwhxDLycmsU4guch0ZM00Uii0vM/A==
X-Received: by 2002:a63:5f54:0:b0:462:1149:f3b3 with SMTP id t81-20020a635f54000000b004621149f3b3mr39853587pgb.445.1666829988906;
        Wed, 26 Oct 2022 17:19:48 -0700 (PDT)
Received: from pc-zest.atmarktech (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id 62-20020a621541000000b0056bf6cd44cdsm3637917pfv.91.2022.10.26.17.19.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Oct 2022 17:19:48 -0700 (PDT)
Received: from martinet by pc-zest.atmarktech with local (Exim 4.96)
        (envelope-from <martinet@pc-zest>)
        id 1onqcc-002fq6-3B;
        Thu, 27 Oct 2022 09:19:46 +0900
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
Subject: [PATCH 5.15 1/2] serial: core: move RS485 configuration tasks from drivers into core
Date:   Thu, 27 Oct 2022 09:19:42 +0900
Message-Id: <20221027001943.637449-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.35.1
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

[ Upstream commit 0ed12afa5655512ee418047fb3546d229df20aa1 ]
Link: https://lkml.kernel.org/r/20221017051737.51727-1-dominique.martinet@atmark-techno.com
Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Link: https://lore.kernel.org/r/20220410104642.32195-2-LinoSanfilippo@gmx.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Daisuke Mizobuchi <mizo@atmark-techno.com>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---

5.15 version of the 5.10 backport:
https://lkml.kernel.org/r/20221017051737.51727-1-dominique.martinet@atmark-techno.com
(only build tested)


 drivers/tty/serial/serial_core.c | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 82ddbb92d07d..48dafd1e084b 100644
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
@@ -1299,8 +1304,36 @@ static int uart_set_rs485_config(struct uart_port *port,
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


