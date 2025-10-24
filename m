Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9079B3191C4
	for <linux-serial@vger.kernel.org>; Fri, 24 Oct 2025 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761309655; cv=none; b=iEW7Xu8P4ZqmAmIdpE7aRZQueCnur72lyMqZX+tTyGPpvkeMy+k4ASC6Vgss0E292SdiD2Y2wt+uqyh5K28n51uy11xEIDzynvzy2rkK1uJJLmvY3DgoxiLHRYKp+2cehTiDWiC/Hhi7pePhvx0hQcw//oVI4O9eYoZm/pvW9yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761309655; c=relaxed/simple;
	bh=PLRVLvdl7dWr/qhCmjftgM+DDHOnmWt5ZRoZQkGlpss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1RID1r/H1PEBz3FL3nH7oQc0swSEi60El9vk0a1WxepextoVRIkocaXgVxIkrIPhV/EBL2gLYN8bG8Oe87ENUvp12/SSia9ICPz1YHPNzYMxxDrBGT5eglO2Oj0vxFV+Nu3G6ik7wIk1vjHsAyO4hcQKSW+nGcpV33RU4yEBdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vCH67-0004IA-SS; Fri, 24 Oct 2025 14:40:47 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vCH67-005E8E-1D;
	Fri, 24 Oct 2025 14:40:47 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vCH67-00FAGC-0p;
	Fri, 24 Oct 2025 14:40:47 +0200
Date: Fri, 24 Oct 2025 14:40:47 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <20251024124047.gnhxvjxjv7ie6ryy@pengutronix.de>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
 <Zt7kCxawoszunWq3@hovoldconsulting.com>
 <20240917044948.i2eog4ondf7vna7q@pengutronix.de>
 <Z8_wcASfJ8SeAQ8l@hovoldconsulting.com>
 <20250313194044.t2t3c7j6ktvshjhs@pengutronix.de>
 <aPogbAozezmqSMuU@hovoldconsulting.com>
 <20251023134828.2dzq2rhtjplqyyaj@pengutronix.de>
 <aPs3BX9-og6wJIWR@hovoldconsulting.com>
 <20251024092738.zao47ehvzckkrsf3@pengutronix.de>
 <aPtV1qNu3aVrS4LS@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPtV1qNu3aVrS4LS@hovoldconsulting.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

On 25-10-24, Johan Hovold wrote:
> On Fri, Oct 24, 2025 at 11:27:38AM +0200, Marco Felsch wrote:
> > On 25-10-24, Johan Hovold wrote:
> > > On Thu, Oct 23, 2025 at 03:48:28PM +0200, Marco Felsch wrote:
> > > > On 25-10-23, Johan Hovold wrote:
> > > > > On Thu, Mar 13, 2025 at 08:40:44PM +0100, Marco Felsch wrote:
> > > > > > On 25-03-11, Johan Hovold wrote:
> > > > > > > On Tue, Sep 17, 2024 at 06:49:48AM +0200, Marco Felsch wrote:
> > > > > > > > On 24-09-09, Johan Hovold wrote:
> 
> > > It's still one of the issues that need to addressed.
> > 
> > Yes but this shouldn't be an issue with this patchset. So far the
> > smallest DT-describale USB entities are the interfaces.
> 
> It is an issue with this patchset since any binding for USB serdev will
> need to take both kind of devices into account. Period.

Sorry but I really don't see the issue. As of now DT abstractions
supports all my use-cases. If $another_developer has an USB device which
actually exposes multiple serial ports behind a single usb-interface,
fine. But in that case $another_developer needs to add the
support/extend the support for it if he wants to use it in combination
with serdev.

I actually have no such USB device and also my customer doesn't use such
a device. Therefore I'm afraid that I can't add support for something I
can't actually test.

What is your suggestion how the DT abstraction should look like in 2025,
e.g. given the current DT abstraction?

> > > > > > > > > Second, and more importantly, you do not address the main obstacle for
> > > > > > > > > enabling serdev for USB serial which is that the serdev cannot handle
> > > > > > > > > hotplugging.
> > > 
> > > > > You will also see the following kind of warnings in the logs:
> > > > > 
> > > > > ttyUSB ttyUSB0: tty_hangup: tty->count(1) != (#fd's(0) + #kopen's(0))
> > > > > ttyUSB ttyUSB0: tty_port_close_start: tty->count = 1 port count = 0
> > > > > 
> > > > > which are due to the fact that serdev does not support hangups which are
> > > > > used during teardown of USB serial ports.
> > > > 
> > > > IIRC I added the following patch to solve this:
> > > > 
> > > >  - [PATCH 1/3] serdev: ttyport: make use of tty_kopen_exclusive
> > > > 
> > > > Sorry for not remembering the details since this conversation/patchset
> > > > is quite old but still one of our top prios.
> > > 
> > > That suppresses the first warning but doesn't address the underlying
> > > issue (that hangups are built around file handles which serdev does not
> > > use). And you will still see the second one when the serdev driver tries
> > > to close the already hung up port during deregistration.
> > 
> > Can you please elaborate how I can check this? I'm not aware of any
> > warning yet, but I only tested the hot-(un)plug. If I got your right, I
> > should see the issue once I unload the serdev driver, right?
> 
> You should see it in your test setup as well. Unless the bluetooth
> driver you use is doing something funky (e.g. not closing the port).
> 
> I'm testing with a mock gnss device here.

Okay, let me test this. Just that we're on the same page: The test is to
remove the serdev (bluetooth, gnss, ...) driver, right?

> > > Also, that commit message needs to more work since you don't really
> > > motivate why you think it's needed (e.g. as serdev ports can't be shared
> > > with user space).
> > 
> > Maybe it needs some adaptions but:
> > 
> > | The purpose of serdev is to provide kernel drivers for particular serial
> > | device, serdev-ttyport is no exception here. Make use of the
> > | tty_kopen_exclusive() funciton to mark this tty device as kernel
> > | internal device.
> > 
> > the last sentence should address your point that serdev ports can't be
> > shared with user-space.A
> 
> No, my point was that serdev devices *are* not shared with user space,
> you don't need to use that new kopen helper for that.
> 
> > > If it's just about suppressing the warning you could possibly just have
> > > set that new flag.
> > 
> > Which new flag? As I have written in my commit message: "Make use of ...
> > to mark this tty device as kernel internal device". I thought this was
> > the purpose of tty_kopen_exclusive().
> 
> That helper sets the new TTY_PORT_KOPENED flag which suppresses the
> warning on hangups.

Okay, so you meant the TTY_PORT_KOPENED flag. According the
documentation of tty_kopen_exclusive():

| tty_kopen_exclusive - open a tty device for kernel

isn't that exactly what serdev-ttyport should do to "not share it with
user space"? IMHO it's an implementation detail if the logic behind
"open a tty device for kernel" is only built around a flag to suppress
the warning.

Regards,
  Marco
