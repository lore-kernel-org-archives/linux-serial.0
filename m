From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: [atmel-serial] Fix compilation error caused by BUILD_BUG_ON() in
 2.6.32-rc2 kernel
Date: Wed, 30 Sep 2009 10:25:33 +0200
Message-ID: <4AC315FD.4060408@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:58566 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbZI3IoO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Sep 2009 04:44:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.visionsystems.de (Postfix) with ESMTP id 116B31DB290
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2009 10:25:39 +0200 (CEST)
Received: from mail.visionsystems.de ([127.0.0.1])
 by localhost (mail.visionsystems.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 24775-04 for <linux-serial@vger.kernel.org>;
 Wed, 30 Sep 2009 10:25:34 +0200 (CEST)
Received: from visionsystems.de (kallisto.visionsystems.local [192.168.1.3])
	by mail.visionsystems.de (Postfix) with ESMTP id A06AF1DB28B
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2009 10:25:34 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Fix compilation error caused by BUILD_BUG_ON() in 2.6.32-rc2 kernel.

Add ring buffer size requirements to the macro definition instead of calling
BUILD_BUG_ON().

See the following thread for details:
http://www.gossamer-threads.com/lists/linux/kernel/1118447?page=last

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Index: linus2/drivers/serial/atmel_serial.c
===================================================================
--- linus2.orig/drivers/serial/atmel_serial.c
+++ linus2/drivers/serial/atmel_serial.c
@@ -123,6 +123,7 @@ struct atmel_uart_char {
 	u16		ch;
 };
 
+/* the ring buffer size must be the power of 2 */
 #define ATMEL_SERIAL_RINGSIZE 1024
 
 /*
@@ -1531,8 +1532,6 @@ static int __devinit atmel_serial_probe(
 	void *data;
 	int ret;
 
-	BUILD_BUG_ON(!is_power_of_2(ATMEL_SERIAL_RINGSIZE));
-
 	port = &atmel_ports[pdev->id];
 	port->backup_imr = 0;
 

