From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: Suggested patch for linux
Date: Thu, 10 Jul 2008 09:16:40 -0500
Message-ID: <487619C8.7080509@commtech-fastcom.com>
References: <487546D5.8050908@freesurf.ch> <20080710095904.16dfdb08@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:18270 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757602AbYGJORT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Jul 2008 10:17:19 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2491006wri.5
        for <linux-serial@vger.kernel.org>; Thu, 10 Jul 2008 07:17:18 -0700 (PDT)
In-Reply-To: <20080710095904.16dfdb08@the-village.bc.nu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Axel Hosemann <axel.hosemann@freesurf.ch>, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org


> The big problem is that the kernel does not know what is a "transmission"
> it just sees a series of writes to the device. In many cases the
> multi-drop or radio systems also need the caller to wait for a
> transmission slot either by beacon, by timing or by monitoring the
> carrier detect to avoid collisions.
I believe that he is referring to something much simpler than you are 
thinking.  He is talking about 2-wire RS485 transmissions in which the 
RTS signal is used to enable the driver chips just before transmitting 
data and disabling (tri-stating) them just after transmitting data.  
There are some UARTs that have this behavior built into them.
>
> That seems to best be done in user space as the algorithms are quite
> variable and some are complex.
>
> Do we really benefit from having this in kernel ?
The problem that can come up when executing this feature in user-land 
(though not exactly common) is when the hardware on the other end 
responds to your message faster than your user app was able to detect 
that the UART is finished and then toggle RTS.  When this happens both 
ends are trying to drive the line and you have bus contention, lost data 
and possibly damage to the driver chips themselves.

Matt Schulte
Commtech, Inc.
http://www.commtech-fastcom.com



