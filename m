Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF30C4332B
	for <linux-serial@archiver.kernel.org>; Mon,  8 Feb 2021 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D1760232
	for <linux-serial@archiver.kernel.org>; Mon,  8 Feb 2021 18:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbhBHSSO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Feb 2021 13:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbhBHSRB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Feb 2021 13:17:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A87C06178B;
        Mon,  8 Feb 2021 10:16:21 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612808179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h9RwiLyf2em69GyCK8lGeGYJ1Y/gUkmVKaMZzVQiryk=;
        b=y+Frn1ImupaWzvVR+wH4xQRp9VnHJ3v9rZv+STLcPwAzxSvaXv7c7gS4TWzjgtdpqF9Qof
        1MDgJUzb8tMYMkmSQdEFOYw4oArMW9+02S43byFHBkj99gBogFB1xiEKua4A0mQ8vbNP8T
        9eX8RZyb+fg2dCDGwK4B7jBklRJAxPPk3tvG0rYhfxGhyhQA+fSKkFu2Wdp6P15mIJKN/y
        2pwU2ylr+LSfuHO/QmpYXHyEzvBbVM86154AkPF0LhBWfIVP33S6loRaLxf4fkEVLjx7P0
        F6bUZ1AEq+6SmPhwAfo2EEGOv3GoOOcQcbXS7nkr/Drv4p8CGbcsK3S0k6OAAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612808179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h9RwiLyf2em69GyCK8lGeGYJ1Y/gUkmVKaMZzVQiryk=;
        b=qaAt72MKc5g9qCDVwucweGQmqiexkXwYZexT4piTNB2oaUo5QNxcEK8YojDS5PaLHNHu2y
        s1sG7qfg+l5vZpCQ==
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] vt_ioctl: Remove in_interrupt() check
Date:   Mon,  8 Feb 2021 19:16:14 +0100
Message-Id: <20210208181615.381861-2-bigeasy@linutronix.de>
In-Reply-To: <20210208181615.381861-1-bigeasy@linutronix.de>
References: <20210208181615.381861-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: "Ahmed S. Darwish" <a.darwish@linutronix.de>

reset_vc() uses a "!in_interrupt()" conditional before resetting the
palettes, which is a blocking operation. Since commit
   8b6312f4dcc1e ("[PATCH] vt: refactor console SAK processing")

all calls are invoked from a workqueue process context, with the
blocking console lock always acquired.

Remove the "!in_interrupt()" check.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/vt/vt_ioctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 4a4cbd4a5f37a..89aeaf3c1bca6 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -930,8 +930,7 @@ void reset_vc(struct vc_data *vc)
 	put_pid(vc->vt_pid);
 	vc->vt_pid =3D NULL;
 	vc->vt_newvt =3D -1;
-	if (!in_interrupt())    /* Via keyboard.c:SAK() - akpm */
-		reset_palette(vc);
+	reset_palette(vc);
 }
=20
 void vc_SAK(struct work_struct *work)
--=20
2.30.0

