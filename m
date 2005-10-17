From: Ben Papps <ben.papps@oxsemi.com>
Subject: [PATCH]serial: 8250 16950 uart capabilities fix
Date: Mon, 17 Oct 2005 10:38:27 +0100
Message-ID: <43537113.2050108@oxsemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from jupiter.oxsemi.com ([62.255.240.98]:27052 "EHLO
	jupiter.oxsemi.com") by vger.kernel.org with ESMTP id S932230AbVJQJit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Oct 2005 05:38:49 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux serial newsgroup <linux-serial@vger.kernel.org>, Russell King <rmk+serial@arm.linux.org.uk>, linux-kernek@vger.kernel.org

--- linux-2.6.13.4/drivers/serial/8250.c.orig    2005-10-10 
19:54:29.000000000 +0100
+++ linux-2.6.13.4/drivers/serial/8250.c    2005-10-17 
10:19:20.000000000 +0100
@@ -211,7 +211,7 @@ static const struct serial8250_config ua
         .fifo_size    = 128,
         .tx_loadsz    = 128,
         .fcr        = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
-        .flags        = UART_CAP_FIFO,
+        .flags        = UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP,
     },
     [PORT_16654] = {
         .name        = "ST16654",

-------------------------------
These flags allow the hardware flow control and other enhanced 
capabilities of 950 uarts.

Signed-off-by: Ben Papps <ben.papps@oxsemi.com>


-- 
_____________________________
 
Ben Papps

Software Design Engineer
Oxford Semiconductor Ltd
25 Milton Park, Oxfordshire, OX14 4SH
 
Tel: 01235 824887


