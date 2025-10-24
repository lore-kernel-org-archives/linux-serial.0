Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E03090CD
	for <linux-serial@vger.kernel.org>; Fri, 24 Oct 2025 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298065; cv=none; b=oQDcYhaLtcjgoA0OB3zLOXNLVCuhYTq70fI3DNxBE+LX4o0ja0dbUV6xfK3aVZsY6xuZsRYL5WDZE/T5iy7172UG54qwZFzxGuBJRzX/j4aMUJ8lEjVs2N7OIIYuHZdeS5fQd+RoQFsshu29xVqHY2bNd67bA1dVqUN7dqJJJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298065; c=relaxed/simple;
	bh=RzPBYsE9Z+QwcYi1D0hNt0IClKgJXydxPV4v/o8X4Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II5bOigQFa6zpax60RuCtkFXAemJ6bYDhwZBDwnYLsEUrlevmW0nRq4/4vsauoBmA8L1/0ksmd9dN636/9m+qBWwiIUTgAEd3/Q6FbkrOzY67GlOLescB2jBqCHZL+MBcdCTSmrgSy9W0UhwZmC1Lsg0MOEBBjTIyw8gmCGObns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vCE5D-0003tv-Am; Fri, 24 Oct 2025 11:27:39 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vCE5C-005CcK-3A;
	Fri, 24 Oct 2025 11:27:38 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vCE5C-00F7Ne-2o;
	Fri, 24 Oct 2025 11:27:38 +0200
Date: Fri, 24 Oct 2025 11:27:38 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <20251024092738.zao47ehvzckkrsf3@pengutronix.de>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
 <Zt7kCxawoszunWq3@hovoldconsulting.com>
 <20240917044948.i2eog4ondf7vna7q@pengutronix.de>
 <Z8_wcASfJ8SeAQ8l@hovoldconsulting.com>
 <20250313194044.t2t3c7j6ktvshjhs@pengutronix.de>
 <aPogbAozezmqSMuU@hovoldconsulting.com>
 <20251023134828.2dzq2rhtjplqyyaj@pengutronix.de>
 <aPs3BX9-og6wJIWR@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPs3BX9-og6wJIWR@hovoldconsulting.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

On 25-10-24, Johan Hovold wrote:
> On Thu, Oct 23, 2025 at 03:48:28PM +0200, Marco Felsch wrote:
> > On 25-10-23, Johan Hovold wrote:
> > > On Thu, Mar 13, 2025 at 08:40:44PM +0100, Marco Felsch wrote:
> > > > On 25-03-11, Johan Hovold wrote:
> > > > > On Tue, Sep 17, 2024 at 06:49:48AM +0200, Marco Felsch wrote:
> > > > > > On 24-09-09, Johan Hovold wrote:
> 
> > > > > > > First, as the commit message you refer to below explain, we need some
> > > > > > > way to describe multiport controllers. Just dropping the 'serial' node
> > > > > > > does not make that issue go away.
> 
> > > There are other USB serial devices that support multiple ports over a
> > > single USB interface. The DT bindings need to account for that case as
> > > well, and that probably means we should not be describing the interfaces
> > > at all but rather the physical ports.
> > 
> > Ah okay, I wasn't even aware that this possible too. However this is DT
> > description and another topic.
> 
> It's still one of the issues that need to addressed.

Yes but this shouldn't be an issue with this patchset. So far the
smallest DT-describale USB entities are the interfaces.

Additional support needs to be added if there are devices which need a
more fine-grained description. I can't implement this since I don't have
access to such devices. That beeing said, my patchset doesn't break such
devices because in that case these devices simply can't be described as
serdev device within the DT and the ttyUSBx devices are exposed to
userspace.

If one wants to add the support for it, the support can surely be added
afterwards too in a backward compatible manner.

> > > > > > > Second, and more importantly, you do not address the main obstacle for
> > > > > > > enabling serdev for USB serial which is that the serdev cannot handle
> > > > > > > hotplugging.
> 
> > > You will also see the following kind of warnings in the logs:
> > > 
> > > ttyUSB ttyUSB0: tty_hangup: tty->count(1) != (#fd's(0) + #kopen's(0))
> > > ttyUSB ttyUSB0: tty_port_close_start: tty->count = 1 port count = 0
> > > 
> > > which are due to the fact that serdev does not support hangups which are
> > > used during teardown of USB serial ports.
> > 
> > IIRC I added the following patch to solve this:
> > 
> >  - [PATCH 1/3] serdev: ttyport: make use of tty_kopen_exclusive
> > 
> > Sorry for not remembering the details since this conversation/patchset
> > is quite old but still one of our top prios.
> 
> That suppresses the first warning but doesn't address the underlying
> issue (that hangups are built around file handles which serdev does not
> use). And you will still see the second one when the serdev driver tries
> to close the already hung up port during deregistration.

Can you please elaborate how I can check this? I'm not aware of any
warning yet, but I only tested the hot-(un)plug. If I got your right, I
should see the issue once I unload the serdev driver, right?

> Also, that commit message needs to more work since you don't really
> motivate why you think it's needed (e.g. as serdev ports can't be shared
> with user space).

Maybe it needs some adaptions but:

| The purpose of serdev is to provide kernel drivers for particular serial
| device, serdev-ttyport is no exception here. Make use of the
| tty_kopen_exclusive() funciton to mark this tty device as kernel
| internal device.

the last sentence should address your point that serdev ports can't be
shared with user-space.

> If it's just about suppressing the warning you could possibly just have
> set that new flag.

Which new flag? As I have written in my commit message: "Make use of ...
to mark this tty device as kernel internal device". I thought this was
the purpose of tty_kopen_exclusive().

Regards,
  Marco


> 
> Johan
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
