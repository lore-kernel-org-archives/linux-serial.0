From: Michal Simek <monstr@monstr.eu>
Subject: Re: Uartlite - ulite_transmit
Date: Wed, 05 Jan 2011 13:39:14 +0100
Message-ID: <4D246672.3070002@monstr.eu>
References: <4D2465E0.2000707@monstr.eu>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47118 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab1AEMjT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 5 Jan 2011 07:39:19 -0500
Received: by bwz15 with SMTP id 15so15433858bwz.19
        for <linux-serial@vger.kernel.org>; Wed, 05 Jan 2011 04:39:18 -0800 (PST)
In-Reply-To: <4D2465E0.2000707@monstr.eu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: monstr@monstr.eu
Cc: Peter Korsgaard <jacmet@sunsite.dk>, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org

Hi Peter, [cc: Grant]

I have found one thing which I would like to check with you.
It is about mdm console which is uartlite compatible but it is slow.
The problem which I think it is there is in ulite_transmit function if
TXFULL is reported then it was returned 0. ulite_transmit is called from
do-while loop in ulite_isr (shown below).

     do {
         int stat = readb(port->membase + ULITE_STATUS);
         busy  = ulite_receive(port, stat);
         busy |= ulite_transmit(port, stat);
     } while (busy);

If tx is full then loop ends but there could be a lot of characters
which need to be send that's why will be good to wait a little bit. I
think it could be done by returning 1 in that case.

What do you think? Patch is below.

Thanks,
Michal

P.S.: second email because c&p error.


diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index ff5f248..cd2c94b 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -128,7 +128,7 @@ static int ulite_transmit(struct uart_port *port,
int stat)
         struct circ_buf *xmit  = &port->info->xmit;

         if (stat & ULITE_STATUS_TXFULL)
-               return 0;
+               return 1;

         if (port->x_char) {
                 writeb(port->x_char, port->membase + ULITE_TX);



-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
