Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01B8C433E0
	for <linux-serial@archiver.kernel.org>; Mon,  8 Feb 2021 18:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8021864E37
	for <linux-serial@archiver.kernel.org>; Mon,  8 Feb 2021 18:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhBHSSS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Feb 2021 13:18:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38264 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbhBHSRB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Feb 2021 13:17:01 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612808179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aAOeh/UEafg/7gs/6xSxr5aMoL1OxSaiaEyaby4zaA0=;
        b=a99/7wx7a7ID2VNjNLv6GCMy7CYRqlCCtMIP6ebPLplD1Q91Jel7Am7hvv7fCzs+St+nl2
        oQVAFWhjDmkNBlHWE1u4XkJjaQJi58+o22vTiY07Fl9o/TwOM3i9S6oQ4zDaS3aNhodZ2R
        Z4f9xevrol/vjfSJ+w5qKc9hSs7iOqlXL7GiYJ3fA+3ujfEfA9sPjCYJV3HtrUdn1/DW4e
        rZ/FTZbpfcXWERon29ty8s/ejy3zP0zD6aAFrqudLMdAkQZwYNyG5iRamYTnTHGOF8yWFj
        /3q2Znn3j9RV/wpuNfQw0+eV0iHdjLx5Vv09pgxVxghMRHyXA8Zk4o9Dpimgzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612808179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aAOeh/UEafg/7gs/6xSxr5aMoL1OxSaiaEyaby4zaA0=;
        b=nVAmg5IRmzl8yx2pVLIe6R42U/H9cKeUXUejA9xeYSzQuhFChvI7oAYss9M4PONHRczzsN
        3gq3m6BYoxerwZBQ==
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] serial: core: Remove BUG_ON(in_interrupt()) check
Date:   Mon,  8 Feb 2021 19:16:15 +0100
Message-Id: <20210208181615.381861-3-bigeasy@linutronix.de>
In-Reply-To: <20210208181615.381861-1-bigeasy@linutronix.de>
References: <20210208181615.381861-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: "Ahmed S. Darwish" <a.darwish@linutronix.de>

The usage of in_interrupt() in drivers is phased out for various
reasons.

In both exported functions where BUG_ON(in_interrupt()) is invoked,
there is a mutex_lock() afterwards. mutex_lock() contains a
might_sleep() which will already trigger a stack trace if the target
functions is called from atomic context.

Remove the BUG_ON() and add a "Context: " in the kernel-doc instead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/serial_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_c=
ore.c
index 7dacdb6a85345..62dc7b5cd60c6 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2848,6 +2848,8 @@ static const struct attribute_group tty_dev_attr_grou=
p =3D {
  *	@drv: pointer to the uart low level driver structure for this port
  *	@uport: uart port structure to use for this port.
  *
+ *	Context: task context, might sleep
+ *
  *	This allows the driver to register its own uart_port structure
  *	with the core driver.  The main purpose is to allow the low
  *	level uart drivers to expand uart_port, rather than having yet
@@ -2861,8 +2863,6 @@ int uart_add_one_port(struct uart_driver *drv, struct=
 uart_port *uport)
 	struct device *tty_dev;
 	int num_groups;
=20
-	BUG_ON(in_interrupt());
-
 	if (uport->line >=3D drv->nr)
 		return -EINVAL;
=20
@@ -2951,6 +2951,8 @@ int uart_add_one_port(struct uart_driver *drv, struct=
 uart_port *uport)
  *	@drv: pointer to the uart low level driver structure for this port
  *	@uport: uart port structure for this port
  *
+ *	Context: task context, might sleep
+ *
  *	This unhooks (and hangs up) the specified port structure from the
  *	core driver.  No further calls will be made to the low-level code
  *	for this port.
@@ -2963,8 +2965,6 @@ int uart_remove_one_port(struct uart_driver *drv, str=
uct uart_port *uport)
 	struct tty_struct *tty;
 	int ret =3D 0;
=20
-	BUG_ON(in_interrupt());
-
 	mutex_lock(&port_mutex);
=20
 	/*
--=20
2.30.0

