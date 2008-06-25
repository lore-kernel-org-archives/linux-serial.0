From: =?iso-8859-1?Q?Chris_Dor=E9?= <cdore@connecttech.com>
Subject: RE: Output character lost with 8250 UART driver
Date: Wed, 25 Jun 2008 10:00:15 -0400
Message-ID: <005a01c8d6cb$ccd363d0$667a2b70$@com>
References: <1214381202.6938.76.camel@xzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from inetc.connecttech.com ([64.7.140.42]:4668 "EHLO
	inetc.connecttech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756310AbYFYOAr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Jun 2008 10:00:47 -0400
In-Reply-To: <1214381202.6938.76.camel@xzhang1-desktop>
Content-Language: en-ca
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: 'Paul Gortmaker' <paul.gortmaker@windriver.com>

> -----Original Message-----
> From: ZhangXiao
> Sent: June 25, 2008 4:07 AM
> 
> Based on theses lines, characters should be written to the THR
> continuous, no matter if it had already move the character to the TSR. I
> think it is not safe in some cases so I add a line
> 
> 	wait_for_xmitr(up, UART_LSR_THRE);
> 
> before line 3. And then the issue in my target was disappeared. This is
> a static function that was already exist in the same file. It just check
> and wait until the THR was empty.

Do you have the FIFO's disabled, but transmit_chars() thinks they are
enabled?
Sounds to me like that might be your problem and without the
wait_for_xmitr() call you are overrunning the transmitter.  In other words,
if you have FIFOs disabled, up->tx_loadsz should be 1.

What UART are you using?


..Chris


