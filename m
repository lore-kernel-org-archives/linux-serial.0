From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [1/1] stallion.c: "fix" initialisation path.
Date: Mon, 13 Jun 2005 22:58:33 +0400
Message-ID: <20050613225833.08afa8ff@zanzibar.2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from relay.2ka.mipt.ru ([194.85.82.65]:38029 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S261190AbVFMS43 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 13 Jun 2005 14:56:29 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org

Driver with such IRQ hacks inside looks really scary.
I do not have neither hardware nor deep knowledge about it,
just found a bug report from kerneltrap maillist.
That code really requires some changes.

--- ./drivers/char/stallion.c.orig	2005-06-13 22:56:44.000000000 +0400
+++ ./drivers/char/stallion.c	2005-06-13 22:56:47.000000000 +0400
@@ -749,10 +749,7 @@
 	printk("init_module()\n");
 #endif
 
-	save_flags(flags);
-	cli();
 	stl_init();
-	restore_flags(flags);
 
 	return(0);
 }


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
