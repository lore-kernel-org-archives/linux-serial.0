From: "Matt Schulte" <matts@commtech-fastcom.com>
Subject: Re: Suggested patch for linux
Date: Tue, 15 Jul 2008 15:43:42 -0500
Message-ID: <1860bbce0807151343rf5cf4apecdc422ba747dd7d@mail.gmail.com>
References: <487546D5.8050908@freesurf.ch>
	 <20080710095904.16dfdb08@the-village.bc.nu>
	 <487619C8.7080509@commtech-fastcom.com>
	 <20080712233317.05e3b6e5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:18307 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759170AbYGOUnn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Jul 2008 16:43:43 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6153194rvb.1
        for <linux-serial@vger.kernel.org>; Tue, 15 Jul 2008 13:43:43 -0700 (PDT)
In-Reply-To: <20080712233317.05e3b6e5@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Axel Hosemann <axel.hosemann@freesurf.ch>, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

> > > Do we really benefit from having this in kernel ?
> > The problem that can come up when executing this feature in user-land
> > (though not exactly common) is when the hardware on the other end
> > responds to your message faster than your user app was able to detect
> > that the UART is finished and then toggle RTS.  When this happens both
> > ends are trying to drive the line and you have bus contention, lost data
> > and possibly damage to the driver chips themselves.
>
> The chips are quite safe. Can we stick to real reasons.
>
> In terms of performance you can manage RTS with a real time application
> if need be and that will give you very close to kernel side response time.
>
> Alan

I apologize if this is a duplicate to anyone, but I've been trying to
get my response through to the board and kept getting rejected, I
think this one will make it through...

The chips may or may not be safe, that isn't the point.  There are
real world applications where response time is an issue and meeting
these criteria is sometimes impossible from a user application.
Switching to an RTOS is certainly an option, it would very likely
allow you to manage RTS withing spec.  However this might not be very
practical for many users.  I suppose another option is to switch to a
serial card that uses a UART that has this capability built in.  I
don't want to sound like an advertisement, but several of my line of
Fastcom serial cards have this feature, where the RS485 gating signal
is governed autonomously by the UART itself.

Matt Schulte
Commtech, Inc.
