From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: [PATCH] KS8695: enable console
Date: Wed, 24 Mar 2010 14:44:12 +0100
Message-ID: <4BAA172C.2070404@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ns.vscom.de ([62.145.30.242]:46706 "EHLO mail.visionsystems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755404Ab0CXNoV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Mar 2010 09:44:21 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, arm-linux <linux-arm-kernel@lists.infradead.org>
Cc: Andrew Victor <avictor.za@gmail.com>

KS8695: enable console

Add add_preferred_console() to ks8695_console_init() to
enable the console

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Index: linux-2.6/drivers/serial/serial_ks8695.c
===================================================================
--- linux-2.6.orig/drivers/serial/serial_ks8695.c
+++ linux-2.6/drivers/serial/serial_ks8695.c
@@ -650,6 +650,7 @@ static struct console ks8695_console = {
 
 static int __init ks8695_console_init(void)
 {
+	add_preferred_console(SERIAL_KS8695_DEVNAME, 0, NULL);
 	register_console(&ks8695_console);
 	return 0;
 }


