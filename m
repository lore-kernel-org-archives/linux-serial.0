From: Alexandre Courbot <Alexandre.Courbot@lifl.fr>
Subject: Bug with 2.6 serial driver when in UART 8250 mode
Date: Thu, 19 Aug 2004 18:53:49 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <4124DB1D.8040401@lifl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ioskeha.hittite.isp.9tel.net ([62.62.156.27]:50396 "EHLO
	ioskeha.hittite.isp.9tel.net") by vger.kernel.org with ESMTP
	id S266689AbUHSQxi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 Aug 2004 12:53:38 -0400
Received: from [84.97.19.32] (unknown [84.97.19.32])
	by ioskeha.hittite.isp.9tel.net (Postfix) with ESMTP id D91AD14B6C6
	for <linux-serial@vger.kernel.org>; Thu, 19 Aug 2004 19:05:07 +0200 (CEST)
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello everybody,

I've sent this email to the lkml but it seems to have raised no 
discussion at all. So I'm submitting it with hopes that someone will at 
least have a look at the matter. Thanks! :)

For communicating with a serial device of ours we need to disable the
UART buffer (the device at the other end doesn't have a serial buffer at
all and therefore we can't use hardware control flow efficiently). The
only way to do this with Linux seems to pass the UART in 8250 mode,
which doesn't use the buffer:

# setserial /dev/ttyS0 uart 8250

We did that with success with 2.4 kernel series. Since most of our
machines are using 2.6, we tried to do the same on them, but noticed
something wrong: only one byte upon 16 is being sent. For instance, if I

$ echo -n "qwertyuiopasdfgh" > /dev/ttyS0

My device only receives the 'h', while with a 2.4 kernel it receives the
entire string.

So I think that for some reason, the UART buffer is not deactivated
while switching it to 8250 mode, and that the driver only sends the last
byte it contains when the interrupt is triggered.

I've tried to look at the code but unfortunately only lost myself
without being able to even identify the right source file to look at.
Sorry about that. :/

Could someone have a look at this or point me to the right section of
code so I do it myself?

Thanks,
Alex.
--
Alexandre Courbot
PhD Student - LIFL/RD2P
http://www.lifl.fr/~courbot/

