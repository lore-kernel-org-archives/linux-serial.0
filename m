From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: KS8695: enable console
Date: Wed, 03 Mar 2010 12:49:13 +0100
Message-ID: <4B8E4CB9.1020403@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hhlx01.visionsystems.de ([62.145.30.242]:45323 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab0CCMQU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Mar 2010 07:16:20 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.visionsystems.de (Postfix) with ESMTP id DD19821035C
	for <linux-serial@vger.kernel.org>; Wed,  3 Mar 2010 12:49:03 +0100 (CET)
Received: from mail.visionsystems.de ([127.0.0.1])
 by localhost (mail.visionsystems.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 15240-06 for <linux-serial@vger.kernel.org>;
 Wed,  3 Mar 2010 12:48:58 +0100 (CET)
Received: from visionsystems.de (kallisto.visionsystems.local [192.168.1.3])
	by mail.visionsystems.de (Postfix) with ESMTP id 3083B21035B
	for <linux-serial@vger.kernel.org>; Wed,  3 Mar 2010 12:48:58 +0100 (CET)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

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

