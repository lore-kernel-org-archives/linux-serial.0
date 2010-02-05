From: Greg KH <greg@kroah.com>
Subject: Re: Review and minor fixes for ftdi_sio.h
Date: Fri, 5 Feb 2010 08:38:49 -0800
Message-ID: <20100205163849.GB27145@kroah.com>
References: <6efe08af1002050154k8ae2a9evff2971afce407b52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:39675 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754237Ab0BEQoY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Feb 2010 11:44:24 -0500
Content-Disposition: inline
In-Reply-To: <6efe08af1002050154k8ae2a9evff2971afce407b52@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Vitaly V. Ch" <vitaly.v.ch@gmail.com>
Cc: USB list <linux-usb@vger.kernel.org>, linux-serial@vger.kernel.org, bryder@sgi.com, kuba@mareimbrium.org

On Fri, Feb 05, 2010 at 11:54:56AM +0200, Vitaly V. Ch wrote:
> Hi all!
> 
> I'm find then ftdi_sio.c in 2.4.37.8 kernel have next bug: if I have
> three ftdi-232 simultaneously connected to middle-loaded host,
> application which use one of them will hung in driver, usually during
> few hour.

Can you look at the version in 2.6.33-rc6, and also in the linux-next
tree?  Both of those have changes to this driver already done, and
hopefully this fixes your problem.

> At now i try to revise that driver and also I review driver in 2.6.32
> and do few minor fixes + found out possible buggy place.
> 
> ****************************************
> 1) function ftdi_232am_baud_base_to_divisor() in 2.6.32 have next view:
> 
> static unsigned short int ftdi_232am_baud_base_to_divisor(int baud, int base)
> {
>     unsigned short int divisor;
>     /* divisor shifted 3 bits to the left */
>     int divisor3 = base / 2 / baud;
>     if ((divisor3 & 0x7) == 7)
>         divisor3++; /* round x.7/8 up to x+1 */
>     divisor = divisor3 >> 3;
>     divisor3 &= 0x7;
>     if (divisor3 == 1)
>         divisor |= 0xc000; /* 0.125 */
>     else if (divisor3 >= 4)
>         divisor |= 0x4000; /* 0.5 */
>     else if (divisor3 != 0)
>         divisor |= 0x8000; /* 0.25 */
>     /// @warning possible at this place we have bug
>     else if (divisor == 1)
>         divisor = 0;    /* special case for maximum baud rate */
>     return divisor;
> }
> 
> but POSSIBLE may be need:
> 
> static unsigned short int ftdi_232am_baud_base_to_divisor(int baud, int base)
> {
>     unsigned short int divisor;
>     /* divisor shifted 3 bits to the left */
>     int divisor3 = base / 2 / baud;
>     if ((divisor3 & 0x7) == 7)
>         divisor3++; /* round x.7/8 up to x+1 */
>     divisor = divisor3 >> 3;
>     divisor3 &= 0x7;
>     if (divisor3 == 1)
>         divisor |= 0xc000; /* 0.125 */
>     else if (divisor3 >= 4)
>         divisor |= 0x4000; /* 0.5 */
>     else if (divisor3 != 0)
>         divisor |= 0x8000; /* 0.25 */
> 
>     if (divisor == 1)
>         divisor = 0;    /* special case for maximum baud rate */
>     return divisor;
> }
> 
> Can anyone guide me?

I don't know, what is the problem you are seeing here?

> *********************************************************
> 2) In the attached patch I do few small fixes. About half of them must
> be merged into kernel trunk

Which half?  :)

Can you look at the above mentioned kernel versions and see if the
problem is already fixed there?

If not, can you send a patch that I can apply (read
Documentation/SubmittingPatches for how to do it)?

thanks,

greg k-h
