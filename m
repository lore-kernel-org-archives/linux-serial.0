From: Hector Palacios <hector.palacios@digi.com>
Subject: mxs auart timeout waiting for transmission with hw flow control
Date: Mon, 30 Sep 2013 18:07:19 +0200
Message-ID: <5249A1B7.4000404@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.4]:32734 "EHLO
	mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754343Ab3I3QPS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Sep 2013 12:15:18 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org
Cc: Huang Shijie <b32955@freescale.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>

Hi Uwe,

I saw your patch at http://www.spinics.net/lists/stable/msg12952.html and I believe 
I'm having a similar issue when not using the port as console.

With hardware flow control enabled transmission fails at low baudrates (9600,38400). 
Apparently the transmitter closes the port before the data has been really shifted out 
(or even transferred by the DMA). While the console functions check the status of 
AUART_STAT_BUSY, the standard functions don't, and the AUART is busy when shutdown is 
called at low baudrates.

I also see the function uart_wait_until_sent() of serial_core.c getting out with 
timeout expired. At 9600 baud, this function waits 2 or 4 jiffies. Increasing (a lot) 
the timeout of this function solves the problem. I monitored the time it takes for TX 
to be empty and it resulted in sometimes around 200 jiffies (@9600).

The issue can be reproduced using two iMX28 devices (transmitting between two ports on 
the same platform usually works fine), configuring a low baudrate (9600) and hardware 
flow enabled, and sending a file of 40K, for example. The last ~200 bytes or so are 
typically not sent over the line.

Best regards,
--
Hector Palacios
