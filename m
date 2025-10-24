Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B822EF673
	for <linux-serial@vger.kernel.org>; Fri, 24 Oct 2025 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322977; cv=none; b=fvatrQRCdVdl9IDHnRdwE59XK6VTX+t7adBKBs9Ue2OO28u4b8DaTyzktJED9kczVxfab0JP7LKqB0BEehWPAztFNachZPpZd4rjbjX/H8c2VluuQl6vIIo4a7JGDiGXEFiSYaeQKM/izfPVu+1u2KfZjxW3l1VKJVKgaSdiNis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322977; c=relaxed/simple;
	bh=pVfNtlvy4XlVUO/mWv2Vpg+ljrkxUs7Of07EOF4fuXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVF+EyGLkxG7t+y38o1WQ7O6RtQ9vW59mObManYCb2X/TGBcVDMXt/SDVxe1SpsD87e/xEuNnStcgEmAbslILUqaVhR+ZtZS0xduef52C15bW1+/xgu7o1+OFUivvSXSc6nMejTkI0/utaNaapJA4joUaIPedEg5yQ7eBZGKw9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vCKYw-00086q-QK; Fri, 24 Oct 2025 18:22:46 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vCKYw-005FmO-1i;
	Fri, 24 Oct 2025 18:22:46 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vCKYw-00FDi2-1F;
	Fri, 24 Oct 2025 18:22:46 +0200
Date: Fri, 24 Oct 2025 18:22:46 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <20251024162246.fo4ipxz2ihvpqaef@pengutronix.de>
References: <20240917044948.i2eog4ondf7vna7q@pengutronix.de>
 <Z8_wcASfJ8SeAQ8l@hovoldconsulting.com>
 <20250313194044.t2t3c7j6ktvshjhs@pengutronix.de>
 <aPogbAozezmqSMuU@hovoldconsulting.com>
 <20251023134828.2dzq2rhtjplqyyaj@pengutronix.de>
 <aPs3BX9-og6wJIWR@hovoldconsulting.com>
 <20251024092738.zao47ehvzckkrsf3@pengutronix.de>
 <aPtV1qNu3aVrS4LS@hovoldconsulting.com>
 <20251024124047.gnhxvjxjv7ie6ryy@pengutronix.de>
 <aPt-h_jzlG3uyLUx@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPt-h_jzlG3uyLUx@hovoldconsulting.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

On 25-10-24, Johan Hovold wrote:
> On Fri, Oct 24, 2025 at 02:40:47PM +0200, Marco Felsch wrote:
> > On 25-10-24, Johan Hovold wrote:
> > > On Fri, Oct 24, 2025 at 11:27:38AM +0200, Marco Felsch wrote:
> > > > On 25-10-24, Johan Hovold wrote:
> > > > > On Thu, Oct 23, 2025 at 03:48:28PM +0200, Marco Felsch wrote:
> > > > > > On 25-10-23, Johan Hovold wrote:
> > > > > > > On Thu, Mar 13, 2025 at 08:40:44PM +0100, Marco Felsch wrote:
> > > > > > > > On 25-03-11, Johan Hovold wrote:
> > > > > > > > > On Tue, Sep 17, 2024 at 06:49:48AM +0200, Marco Felsch wrote:
> > > > > > > > > > On 24-09-09, Johan Hovold wrote:
> > > 
> > > > > It's still one of the issues that need to addressed.
> > > > 
> > > > Yes but this shouldn't be an issue with this patchset. So far the
> > > > smallest DT-describale USB entities are the interfaces.
> > > 
> > > It is an issue with this patchset since any binding for USB serdev will
> > > need to take both kind of devices into account. Period.
> > 
> > Sorry but I really don't see the issue. As of now DT abstractions
> > supports all my use-cases. If $another_developer has an USB device which
> > actually exposes multiple serial ports behind a single usb-interface,
> > fine. But in that case $another_developer needs to add the
> > support/extend the support for it if he wants to use it in combination
> > with serdev.
> 
> Fine, but if you only care about your use case then you can keep your
> implementation out-of-tree until someone comes with along with enough
> time to solve this properly.

Fair enough, after checking your patchset once again I see your special
USB-UART converter. I get your point and will add the serial@ binding!

Since I don't have a MOS7840 USB-Serial to test it, it would be nice of
you if you could test it afterwards on your side as well.

> > > > > > > You will also see the following kind of warnings in the logs:
> > > > > > > 
> > > > > > > ttyUSB ttyUSB0: tty_hangup: tty->count(1) != (#fd's(0) + #kopen's(0))
> > > > > > > ttyUSB ttyUSB0: tty_port_close_start: tty->count = 1 port count = 0
> > > > > > > 
> > > > > > > which are due to the fact that serdev does not support hangups which are
> > > > > > > used during teardown of USB serial ports.
> 
> > > You should see it in your test setup as well. Unless the bluetooth
> > > driver you use is doing something funky (e.g. not closing the port).
> > > 
> > > I'm testing with a mock gnss device here.
> > 
> > Okay, let me test this. Just that we're on the same page: The test is to
> > remove the serdev (bluetooth, gnss, ...) driver, right?
> 
> No, trigger a disconnect like you did before, or do a physical
> disconnect, by wiring up a regular USB port.

I will test it again, thanks!

> > > > > Also, that commit message needs to more work since you don't really
> > > > > motivate why you think it's needed (e.g. as serdev ports can't be shared
> > > > > with user space).
> 
> > > No, my point was that serdev devices *are* not shared with user space,
> > > you don't need to use that new kopen helper for that.
> 
> > > That helper sets the new TTY_PORT_KOPENED flag which suppresses the
> > > warning on hangups.
> > 
> > Okay, so you meant the TTY_PORT_KOPENED flag. According the
> > documentation of tty_kopen_exclusive():
> > 
> > | tty_kopen_exclusive - open a tty device for kernel
> > 
> > isn't that exactly what serdev-ttyport should do to "not share it with
> > user space"? IMHO it's an implementation detail if the logic behind
> > "open a tty device for kernel" is only built around a flag to suppress
> > the warning.
> 
> I give up. I've already told you that serdev does not share anything
> with user space.

I really try to understand the issue you see which I don't.

To cycle back: You posted the following warnings:

| ttyUSB ttyUSB0: tty_hangup: tty->count(1) != (#fd's(0) + #kopen's(0))
| ttyUSB ttyUSB0: tty_port_close_start: tty->count = 1 port count = 0

As written earlier, the tty_kopen_exclusive() should mark the serial
port as kernel-only serial. Also as you said, this suppresses the first
warning.

Is your issue that serdev can't handle hangups (e.g. hot-plugs) yet and
that a serdev driver could try to access the tty while the .remove() is
in progress?

Regards,
  Marco

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
