Return-Path: <SRS0=eb60=62=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AF2C54E8B
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 12:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8183C206F5
	for <linux-serial@archiver.kernel.org>; Tue, 12 May 2020 12:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgELMrj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 May 2020 08:47:39 -0400
Received: from mailout1.hostsharing.net ([83.223.95.204]:43619 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729917AbgELMri (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 May 2020 08:47:38 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 May 2020 08:47:37 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 5A5A610039A57;
        Tue, 12 May 2020 14:41:59 +0200 (CEST)
Received: from localhost (pd95be530.dip0.t-ipconnect.de [217.91.229.48])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 01750627549D;
        Tue, 12 May 2020 14:41:58 +0200 (CEST)
X-Mailbox-Line: From b4a072013ee1a1d13ee06b4325afb19bda57ca1b Mon Sep 17 00:00:00 2001
Message-Id: <b4a072013ee1a1d13ee06b4325afb19bda57ca1b.1589285873.git.lukas@wunner.de>
In-Reply-To: <cover.1589285873.git.lukas@wunner.de>
References: <cover.1589285873.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Tue, 12 May 2020 14:40:01 +0200
Subject: [PATCH v2 1/4] serial: 8250: Avoid error message on reprobe
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If the call to uart_add_one_port() in serial8250_register_8250_port()
fails, a half-initialized entry in the serial_8250ports[] array is left
behind.

A subsequent reprobe of the same serial port causes that entry to be
reused.  Because uart->port.dev is set, uart_remove_one_port() is called
for the half-initialized entry and bails out with an error message:

bcm2835-aux-uart 3f215040.serial: Removing wrong port: (null) != (ptrval)

The same happens on failure of mctrl_gpio_init() since commit
4a96895f74c9 ("tty/serial/8250: use mctrl_gpio helpers").

Fix by zeroing the uart->port.dev pointer in the probe error path.

The bug was introduced in v2.6.10 by historical commit befff6f5bf5f
("[SERIAL] Add new port registration/unregistration functions."):
https://git.kernel.org/tglx/history/c/befff6f5bf5f

The commit added an unconditional call to uart_remove_one_port() in
serial8250_register_port().  In v3.7, commit 835d844d1a28 ("8250_pnp:
do pnp probe before legacy probe") made that call conditional on
uart->port.dev which allows me to fix the issue by zeroing that pointer
in the error path.  Thus, the present commit will fix the problem as far
back as v3.7 whereas still older versions need to also cherry-pick
835d844d1a28.

Fixes: 835d844d1a28 ("8250_pnp: do pnp probe before legacy probe")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v2.6.10
Cc: stable@vger.kernel.org # v2.6.10: 835d844d1a28: 8250_pnp: do pnp probe before legacy
---
Changes v1 -> v2:
* Drop unnecessary "else" after "if ... goto" statement. (Andy)
* Document applicability to older kernels in commit message. (Andy)
* Add Fixes tag. (Andy)

 drivers/tty/serial/8250/8250_core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 45d9117cab68..9548d3f8fc8e 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1040,7 +1040,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 			gpios = mctrl_gpio_init(&uart->port, 0);
 			if (IS_ERR(gpios)) {
 				ret = PTR_ERR(gpios);
-				goto out_unlock;
+				goto err;
 			} else {
 				uart->gpios = gpios;
 			}
@@ -1089,8 +1089,10 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 			serial8250_apply_quirks(uart);
 			ret = uart_add_one_port(&serial8250_reg,
 						&uart->port);
-			if (ret == 0)
-				ret = uart->port.line;
+			if (ret)
+				goto err;
+
+			ret = uart->port.line;
 		} else {
 			dev_info(uart->port.dev,
 				"skipping CIR port at 0x%lx / 0x%llx, IRQ %d\n",
@@ -1112,10 +1114,14 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		}
 	}
 
-out_unlock:
 	mutex_unlock(&serial_mutex);
 
 	return ret;
+
+err:
+	uart->port.dev = NULL;
+	mutex_unlock(&serial_mutex);
+	return ret;
 }
 EXPORT_SYMBOL(serial8250_register_8250_port);
 
-- 
2.26.2

