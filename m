From: Joachim Buermann <jbuermann@zes.com>
Subject: Re: Overruns with kernel 2.4.19
Date: Wed, 19 Feb 2003 09:22:41 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20030219092241.1cccbb34.jbuermann@zes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from inv1253.zes.com (217.5.81.123)
          by websrvnt02 with MERCUR-SMTP/POP3/IMAP4-Server (v3.10.18 AS-0098309)
          for <linux-serial@vger.kernel.org>; Wed, 19 Feb 2003  09:27:31 +0100
Received: from inv1253.zes.com (localhost [127.0.0.1])
	by inv1253.zes.com (Postfix) with ESMTP id B68231F3B1
	for <linux-serial@vger.kernel.org>; Wed, 19 Feb 2003 09:22:42 +0100 (CET)
Received: from inv1428.zes.com (inv1428.zes.com [192.168.2.28])
	by inv1253.zes.com (Postfix) with SMTP id 325591F3A8
	for <linux-serial@vger.kernel.org>; Wed, 19 Feb 2003 09:22:42 +0100 (CET)
List-Id: linux-serial@vger.kernel.org
To: linux serial <linux-serial@vger.kernel.org>

Hi Ed,


> Hi Joachim and David,
> 
> Do I need an external data source to reproduce this, or does it also fail
> with a looped back 115200 baud data stream (ttyS1 -> ttyS0)? I can try it on
> my 333 MHz Pentium II when it frees up in a couple of days. 
> 
> So, 2.2.20 works okay and 2.4.19 fails. Anybody have a rough idea of when
> the receive data overrun behavior crept in? 
> 
> Cheers,
> Ed
> 

I will check this next time and let you know what happens.

Regards
Joachim
