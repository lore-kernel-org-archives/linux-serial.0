From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Wed, 7 Mar 2007 10:19:55 -0500
Message-ID: <200703071019.55896.rgetz@blackfin.uclinux.org>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com> <200703061824.08834.rgetz@blackfin.uclinux.org> <m3irddusp0.fsf@maximus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:4703 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbXCGPTD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Mar 2007 10:19:03 -0500
In-Reply-To: <m3irddusp0.fsf@maximus.localdomain>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Mike Frysinger <vapier.adi@gmail.com>, rmk@arm.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

On Wed 7 Mar 2007 07:46, Krzysztof Halasa pondered:
> Robin Getz <rgetz@blackfin.uclinux.org> writes:
> > It is useful on (broken) legacy serial equipment, where RTS should be
> > completely under the applications control.
> >
> > Glitches on RTS aren't acceptable, and confuse some devices.
>
> Does that mean you can't use TIOCMSET, TIOCM_RTS etc?
>
> > I understand - the request wasn't to change the default operation -
>
> just
>
> > add a
> > method of controlling things, so those minority of people who want the
> >
> > control can have it.
>
> No problem as long as open without CRTSCTS raises RTS by default.

Right - so the question is where to manage the default state? I was thinking 
in the resource might be a good idea, but there isn't really a good place for 
it. (You could re-use some bits if flags, but I think that would not be a 
good idea).

-Robin
