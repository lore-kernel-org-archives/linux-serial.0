From: Grant Edwards <grante@visi.com>
Subject: Re: Suggested patch for linux
Date: Thu, 10 Jul 2008 14:47:56 +0000 (UTC)
Message-ID: <g557er$c32$1@ger.gmane.org>
References: <487546D5.8050908@freesurf.ch>
 <20080710095904.16dfdb08@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:35759 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755248AbYGJOsP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Jul 2008 10:48:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KGxRL-0001He-82
	for linux-serial@vger.kernel.org; Thu, 10 Jul 2008 14:48:11 +0000
Received: from 64.251.14.41 ([64.251.14.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 10 Jul 2008 14:48:11 +0000
Received: from grante by 64.251.14.41 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 10 Jul 2008 14:48:11 +0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-usb@vger.kernel.org

On 2008-07-10, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

>> Stimulated by the RTS signal, the DCE will then engage the
>> channel for transmission and release it, after the RTS has
>> been deasserted when the buffer had been sent. This behaviour
>> is up to now not supported by the linux serial drivers.
>
> Actually you can drive this behaviour from user space

That doesn't generally work.  You often can't respond quickly
enough in user space.  You need to turn the line around within
as little as a few bit-times.  At high baud rates, you simply
can't do that from user space (especially when the UART is
attached via something like USB or Ethernet).

> which is what software like scarabd has done for many years.
>
>> If you see a chance, to add this functionality for future
>> linux kernels, I would be interested in further discussions
>> about this patch.
>
> The big problem is that the kernel does not know what is a
> "transmission" it just sees a series of writes to the device.

"Transmission" is when the UART is sending data (when the shift
register is not empty).

> In many cases the multi-drop or radio systems also need the
> caller to wait for a transmission slot either by beacon, by
> timing or by monitoring the carrier detect to avoid
> collisions.

That's obviously beyond the scope of the serial driver.
Controlling RTS in half-duplex mode isn't.

> That seems to best be done in user space as the algorithms are
> quite variable and some are complex.
>
> Do we really benefit from having this in kernel ?

People who do industrial communications sure would.  I maintain
a couple serial drivers that support half-duplex mode exactly
as described by the OP, and we have to control that feature via
non-standard hacks.

In the past, I added half-duplex mode support into the standard
Linux 16x50 driver, but could never get it to work reliably
across various chipsets (PC motherboard UART designs don't all
seem to set the shift register empty bit at the same time).

If there was at least a standard way to enable half-duplex
mode, it would be easier to support on hardware that correctly
implements RTS control for half-duplex operation.

-- 
Grant Edwards                   grante             Yow! Here we are in America
                                  at               ... when do we collect
                               visi.com            unemployment?

