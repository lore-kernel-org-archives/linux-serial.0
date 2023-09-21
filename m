Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A73E7D0A2
	for <linux-serial@archiver.kernel.org>; Thu, 21 Sep 2023 18:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjIUSih (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Sep 2023 14:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjIUSiJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Sep 2023 14:38:09 -0400
X-Greylist: delayed 4199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Sep 2023 11:31:08 PDT
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF5ED9D31
        for <linux-serial@vger.kernel.org>; Thu, 21 Sep 2023 11:31:08 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout3.hostsharing.net (Postfix) with ESMTPS id F3415102CCA20;
        Thu, 21 Sep 2023 16:53:09 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id A5D6060DC7CD;
        Thu, 21 Sep 2023 16:53:09 +0200 (CEST)
X-Mailbox-Line: From f3a35967c28b32f3c6432d0aa5936e6a9908282d Mon Sep 17 00:00:00 2001
Message-Id: <f3a35967c28b32f3c6432d0aa5936e6a9908282d.1695307688.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Thu, 21 Sep 2023 16:52:33 +0200
Subject: [PATCH tty-linus] serial: Reduce spinlocked portion of
 uart_rs485_config()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 44b27aec9d96 ("serial: core, 8250: set RS485 termination GPIO in
serial core") enabled support for RS485 termination GPIOs behind i2c
expanders by setting the GPIO outside of the critical section protected
by the port spinlock.  Access to the i2c expander may sleep, which
caused a splat with the port spinlock held.

Commit 7c7f9bc986e6 ("serial: Deassert Transmit Enable on probe in
driver-specific way") erroneously regressed that by spinlocking the
GPIO manipulation again.

Fix by moving uart_rs485_config() (the function manipulating the GPIO)
outside of the spinlocked section and acquiring the spinlock inside of
uart_rs485_config() for the invocation of ->rs485_config() only.

This gets us one step closer to pushing the spinlock down into the
->rs485_config() callbacks which actually need it.  (Some callbacks
do not want to be spinlocked because they perform sleepable register
accesses, see e.g. sc16is7xx_config_rs485().)

Stack trace for posterity:

 Voluntary context switch within RCU read-side critical section!
 WARNING: CPU: 0 PID: 56 at kernel/rcu/tree_plugin.h:318 rcu_note_context_switch
 Call trace:
 rcu_note_context_switch
 __schedule
 schedule
 schedule_timeout
 wait_for_completion_timeout
 bcm2835_i2c_xfer
 __i2c_transfer
 i2c_transfer
 i2c_transfer_buffer_flags
 regmap_i2c_write
 _regmap_raw_write_impl
 _regmap_bus_raw_write
 _regmap_write
 _regmap_update_bits
 regmap_update_bits_base
 pca953x_gpio_set_value
 gpiod_set_raw_value_commit
 gpiod_set_value_nocheck
 gpiod_set_value_cansleep
 uart_rs485_config
 uart_add_one_port
 pl011_register_port
 pl011_probe

Fixes: 7c7f9bc986e6 ("serial: Deassert Transmit Enable on probe in driver-specific way")
Suggested-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v6.1+
---
 drivers/tty/serial/serial_core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7bdc21d5e13b..ca26a8aef2cb 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1404,12 +1404,18 @@ static void uart_set_rs485_termination(struct uart_port *port,
 static int uart_rs485_config(struct uart_port *port)
 {
 	struct serial_rs485 *rs485 = &port->rs485;
+	unsigned long flags;
 	int ret;
 
+	if (!(rs485->flags & SER_RS485_ENABLED))
+		return 0;
+
 	uart_sanitize_serial_rs485(port, rs485);
 	uart_set_rs485_termination(port, rs485);
 
+	spin_lock_irqsave(&port->lock, flags);
 	ret = port->rs485_config(port, NULL, rs485);
+	spin_unlock_irqrestore(&port->lock, flags);
 	if (ret)
 		memset(rs485, 0, sizeof(*rs485));
 
@@ -2474,11 +2480,10 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			if (ret == 0) {
 				if (tty)
 					uart_change_line_settings(tty, state, NULL);
+				uart_rs485_config(uport);
 				spin_lock_irq(&uport->lock);
 				if (!(uport->rs485.flags & SER_RS485_ENABLED))
 					ops->set_mctrl(uport, uport->mctrl);
-				else
-					uart_rs485_config(uport);
 				ops->start_tx(uport);
 				spin_unlock_irq(&uport->lock);
 				tty_port_set_initialized(port, true);
@@ -2587,10 +2592,10 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		port->mctrl &= TIOCM_DTR;
 		if (!(port->rs485.flags & SER_RS485_ENABLED))
 			port->ops->set_mctrl(port, port->mctrl);
-		else
-			uart_rs485_config(port);
 		spin_unlock_irqrestore(&port->lock, flags);
 
+		uart_rs485_config(port);
+
 		/*
 		 * If this driver supports console, and it hasn't been
 		 * successfully registered yet, try to re-register it.
-- 
2.40.1

