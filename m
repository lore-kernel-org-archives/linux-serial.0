From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Suggested patch for linux
Date: Sat, 12 Jul 2008 23:33:17 +0100
Message-ID: <20080712233317.05e3b6e5@lxorguk.ukuu.org.uk>
References: <487546D5.8050908@freesurf.ch>
	<20080710095904.16dfdb08@the-village.bc.nu>
	<487619C8.7080509@commtech-fastcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57620 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753227AbYGLWvg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 12 Jul 2008 18:51:36 -0400
In-Reply-To: <487619C8.7080509@commtech-fastcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: Axel Hosemann <axel.hosemann@freesurf.ch>, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

On Thu, 10 Jul 2008 09:16:40 -0500
> I believe that he is referring to something much simpler than you are 
> thinking.  He is talking about 2-wire RS485 transmissions in which the 
> RTS signal is used to enable the driver chips just before transmitting 

Its all the same thing. And actually the radios are often RS485

> > That seems to best be done in user space as the algorithms are quite
> > variable and some are complex.

> > Do we really benefit from having this in kernel ?
> The problem that can come up when executing this feature in user-land 
> (though not exactly common) is when the hardware on the other end 
> responds to your message faster than your user app was able to detect 
> that the UART is finished and then toggle RTS.  When this happens both 
> ends are trying to drive the line and you have bus contention, lost data 
> and possibly damage to the driver chips themselves.

The chips are quite safe. Can we stick to real reasons.

In terms of performance you can manage RTS with a real time application
if need be and that will give you very close to kernel side response time.

Alan
