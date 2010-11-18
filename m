From: Greg KH <greg@kroah.com>
Subject: Re: How to disable the transmit FIFO?
Date: Thu, 18 Nov 2010 08:41:22 -0800
Message-ID: <20101118164122.GB2855@kroah.com>
References: <E1PJ0al-0000hs-Kb@palantir.moria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:54443 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754945Ab0KRQrt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Nov 2010 11:47:49 -0500
Content-Disposition: inline
In-Reply-To: <E1PJ0al-0000hs-Kb@palantir.moria.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michael Haardt <michael@moria.de>
Cc: linux-serial@vger.kernel.org

On Thu, Nov 18, 2010 at 10:15:43AM +0100, Michael Haardt wrote:
> Hello,
> 
> I miss a way to disable the transmit FIFO.

>From userspace or from within a kernel driver?

> UARTs that don't do hardware handshaking in hardware, but use a transmit
> FIFO, can only be used if the peer can deal with the delayed handshaking
> response.
> 
> If slow peers can not receive at line rate, hardware handshaking will
> still cause overruns with Linux as sender, because Linux fills the
> transmit FIFO and transmission continues at worst for 16 characters with
> a 16550 after CTS was asserted.
> 
> So, how can I fix hardware flow control response to the non-delayed
> behaviour as it worked with a 8250 or 16450 by disabling the transmit
> FIFO?

So you are saying this used to work and now it doesn't?

confused,

greg k-h
