Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD854194A6C
	for <linux-serial@vger.kernel.org>; Thu, 23 Oct 2025 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227320; cv=none; b=TgmnH/16BhsUjRZA50IYpwvL900txm5Z6ZMEbe/OrTW+l91qZCSALFHBYgsdH2UnQnNOCjNOdHj8SANGC7r/ihuvbB2jSp1WofS2udLid0fgyo72/9bnOefCKruXza3C1UXFiUlbafNUwSp4EXq8yLVsUVZU4d+OH1gPde9AvBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227320; c=relaxed/simple;
	bh=mUk5hBrYrGGkrMiI5trxkBqm/8b3hnisi9ONaq3cT7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6TPOOCDr5LrZWCkKd0kev+0MM62lj/OfJ7N6yqoIxFzosLB5ikvO1rDOjtuxHNzUnXJWobFVxil1hrlnkNZYkpHFyfATTr3d2boYf3jZiUozPfQszwRrDWKeLTcX4TzVP3twNwwm2Z0BeS+cE0CnCR4dRo7N9ngGaGlbW/BQ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vBvg4-00026g-Ls; Thu, 23 Oct 2025 15:48:28 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vBvg4-0054AZ-1B;
	Thu, 23 Oct 2025 15:48:28 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vBvg4-00DFOj-0r;
	Thu, 23 Oct 2025 15:48:28 +0200
Date: Thu, 23 Oct 2025 15:48:28 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <20251023134828.2dzq2rhtjplqyyaj@pengutronix.de>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
 <Zt7kCxawoszunWq3@hovoldconsulting.com>
 <20240917044948.i2eog4ondf7vna7q@pengutronix.de>
 <Z8_wcASfJ8SeAQ8l@hovoldconsulting.com>
 <20250313194044.t2t3c7j6ktvshjhs@pengutronix.de>
 <aPogbAozezmqSMuU@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPogbAozezmqSMuU@hovoldconsulting.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

On 25-10-23, Johan Hovold wrote:
> On Thu, Mar 13, 2025 at 08:40:44PM +0100, Marco Felsch wrote:
> > On 25-03-11, Johan Hovold wrote:
> > > On Tue, Sep 17, 2024 at 06:49:48AM +0200, Marco Felsch wrote:
> > > > On 24-09-09, Johan Hovold wrote:
> > > > > On Wed, Aug 07, 2024 at 04:08:47PM +0200, Marco Felsch wrote:
> > > > > > this patchset is based on Johan's patches [1] but dropped the need of
> > > > > > the special 'serial' of-node [2].
> > > > > 
> > > > > That's great that you found and referenced my proof-of-concept patches,
> > > > > but it doesn't seem like you tried to understand why this hasn't been
> > > > > merged yet.
> > > 
> > > > > First, as the commit message you refer to below explain, we need some
> > > > > way to describe multiport controllers. Just dropping the 'serial' node
> > > > > does not make that issue go away.
> > > > 
> > > > Sorry for asking but isn't the current OF abstraction [1] enough? As far
> > > > as I understood we can describe the whole USB tree within OF. I used [1]
> > > > and the this patchset to describe the following hierarchy:
> > > > 
> > > >  usb-root -> usb-hub port-1 -> usb-serial interface-0 -> serial
> > > >                                                          bt-module
> > > > 
> > > > [1] Documentation/devicetree/bindings/usb/usb-device.yaml
> > > 
> > > Again, you still need to consider devices with multiple serial ports
> > > (and they do not always map neatly to one port per interface either).
> > 
> > We use a dual-port FTDI and our USB tree looks as followed:
> 
> > interface-0 is used for the bt-module which is served by the serdev
> > driver.
> > 
> > interface-1 is used by an userspace driver which makes use of the
> > /dev/ttyUSB1 port.
> >
> > So we do have the multiple serial ports use-case already. Can you please
> > explain what I miss?
> 
> There are other USB serial devices that support multiple ports over a
> single USB interface. The DT bindings need to account for that case as
> well, and that probably means we should not be describing the interfaces
> at all but rather the physical ports.

Ah okay, I wasn't even aware that this possible too. However this is DT
description and another topic.

> > > > > Second, and more importantly, you do not address the main obstacle for
> > > > > enabling serdev for USB serial which is that the serdev cannot handle
> > > > > hotplugging.
> > > > 
> > > > Hotplugging is a good point but out-of-scope IMHO (at least for now)
> > > > since the current serdev implementation rely on additional firmware
> > > > information e.g OF node to be present. E.g. if the above mentioned setup
> > > > would connect the "serial bt-module" directly to the UART port you still
> > > > need an OF node to bind the serdev driver. If the node isn't present
> > > > user-space would need to do the hci handling.
> > > 
> > > There's nothing preventing you from adding a devicetree node for a USB
> > > device that can be unplugged.
> > 
> > I see and I have to admit that I didn't test this :/ But since you
> > pointed it out I tested it now!
> > 
> > So as explained, our USB tree looks as above and our DTS looks like the
> > one in the cover letter. Of course I run on an embedded system but the
> > USB FTDI based module is powered by the VBUS of the hub. Therefore I
> > ran the test by disabling the downstream port which in turn disabled the
> > VBUS supply. This should come very close to a physical unplug event.
> 
> You will also see the following kind of warnings in the logs:
> 
> ttyUSB ttyUSB0: tty_hangup: tty->count(1) != (#fd's(0) + #kopen's(0))
> ttyUSB ttyUSB0: tty_port_close_start: tty->count = 1 port count = 0
> 
> which are due to the fact that serdev does not support hangups which are
> used during teardown of USB serial ports.

IIRC I added the following patch to solve this:

 - [PATCH 1/3] serdev: ttyport: make use of tty_kopen_exclusive

Sorry for not remembering the details since this conversation/patchset
is quite old but still one of our top prios.

> > > > So from my POV the serdev abstraction is for manufacturers which make
> > > > use of "onboard" usb-devices which are always present at the same USB
> > > > tree location. Serdev is not made for general purpose USB ports (yet)
> > > > where a user can plug-in all types of USB devices.
> > > 
> > > Right, but someone need to make sure that serdev can handle devices
> > > going away first as nothing is currently preventing that from happening.
> > 
> > Can you please check my above tests? Maybe I do miss something but for
> > me it looks like it's working. Looking forwards for your input.
> 
> I skimmed the code to verify that the issue is still there, and even
> forward ported my patches to confirm that that you would still see the
> port count warnings that indicate that something is amiss.

As said, patch-1 should address this issue.

Regards,
  Marco


> Johan
> 
