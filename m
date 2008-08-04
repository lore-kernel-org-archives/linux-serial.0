From: Grant Edwards <grante@visi.com>
Subject: Re: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Mon, 4 Aug 2008 16:21:10 +0000 (UTC)
Message-ID: <g77a9l$7ih$4@ger.gmane.org>
References: <014e01c8f63c$6d03dee0$2e01a8c0@acksys.local>
 <200808041637.02058.laurentp@cse-semaphore.com>
 <g779ul$7ih$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:38074 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053AbYHDQaJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Aug 2008 12:30:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KQ2wd-0006tG-36
	for linux-serial@vger.kernel.org; Mon, 04 Aug 2008 16:30:03 +0000
Received: from 64.251.14.41 ([64.251.14.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 04 Aug 2008 16:30:03 +0000
Received: from grante by 64.251.14.41 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Mon, 04 Aug 2008 16:30:03 +0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2008-08-04, Grant Edwards <grante@visi.com> wrote:
> On 2008-08-04, Laurent Pinchart <laurentp@cse-semaphore.com> wrote:
>> On Monday 04 August 2008, Tosoni wrote:
>>> About the flags names -- CARTS, UART_FCTR_RS485
>>> 
>>> May I suggest CRTSTOGGLE since it is known by that kind of name in other
>>> OS's :-)
>>
>> I like Russell's proposal of sticking to CRTSCTS and adding options to setserial:
>>
>>> Should CRTSCTS be a global "enable some kind of flow control" bit and
>>> setserial be used to configure the actual flow control method
>>> (conventional RTS/CTS, DTR/DSR, alternate RTS/CTS, RS485 on RTS,
>>> RS485 on DTR) ?
>>
>> Any opinion on that ?
>
> Opposed.
>
>  1) CRTSCTS means something quite specific.  Rather than
>     overload that name for something unrelated, create a new
>     mode bit for the new mode.

Besides, there are often times when you want _both_ RTS toggle
and CTS flow control.  If both RTS toggle and RTSCTS flow
control are set, the "toggle" function would have priority
control of the RTS pin.

-- 
Grant Edwards                   grante             Yow! Was my SOY LOAF left
                                  at               out in th'RAIN?  It tastes
                               visi.com            REAL GOOD!!

