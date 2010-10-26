From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH resend] Add sc16is7x2 driver
Date: Tue, 26 Oct 2010 15:59:34 +0100
Message-ID: <20101026155934.7e70a57c@lxorguk.ukuu.org.uk>
References: <4CAD818B.2070603@iis.fraunhofer.de>
	<20101014190133.GB1009@kroah.com>
	<4CB801B2.808@iis.fraunhofer.de>
	<20101015142709.GA18905@kroah.com>
	<4CB86E8F.3060907@iis.fraunhofer.de>
	<20101015164922.GB21576@kroah.com>
	<4CBC177E.8020407@iis.fraunhofer.de>
	<20101019153748.GB4589@kroah.com>
	<4CC6977C.1020908@iis.fraunhofer.de>
	<20101026145107.GA18531@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35959 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754095Ab0JZPAg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Oct 2010 11:00:36 -0400
In-Reply-To: <20101026145107.GA18531@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

> > And huh, "grep -R serial_max3100.h *" gives what? Only max3100.c
> > So do we need to remove serial_max3100.h as it's not used anywhere else?
> 
> Yup, that sounds like a great idea, I'll go queue up that patch when I
> get back from my travels at the moment.

Sounds a very bad idea to me. The point of the platform data objects
throughout the kernel is to allow other devices to use the driver without
having to hack it up. Removing these interfaces breaks that.

So NAK such a change. The existing code is right, the fact that the
interface isn't being used in that way visibly by currently merged code
doesn't mean it shouldn't be there.

Also max3100 has an active maintainer so perhaps you should Cc them on
such discussion ?

Alan
