Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2A61E25EB;
	Fri, 24 Oct 2025 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312385; cv=none; b=nh4sl1RifeXgGsK2Y+5KpW1lkgHjoDtFJTOt+9alQZhGFMKPK3IBhXct6Zo8glImcAempizt2uwIc0bhS9sCDTraqYEihyRSDUug5vkpCVtZ+QRU3XuWEZrKmNE7RwhjUKFrwJOWRKResBqpDPx79oGYVZXUDsCk0izn9hiXkwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312385; c=relaxed/simple;
	bh=BHlLTllg8VMeedT/+QW4zrG5xLEczdpXykVcabanI5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mbg2Hi2LaaSiLtE4YSLLDoOt0Dz0MhcczdQljv9r6sF/tXRdA+6VBwydJszbCo4PuhD0xGSmvjnRQ+oaOnvbdTR+Gq8Eg0Y+1CU20bbPnB0sWF43CocItGKYlM7S5WFyORCdRwtcZjZq8PuFBzGRaCi+3nZapVKVNAxE126M5gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLxu6su5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLxu6su5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8837BC4CEF1;
	Fri, 24 Oct 2025 13:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761312384;
	bh=BHlLTllg8VMeedT/+QW4zrG5xLEczdpXykVcabanI5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aLxu6su5y7QMIOC5qXas5T5ujrbHo1/84P0gGlzkUh8u35IvgV6Pz9kc6KBJjMFUE
	 ciFmjcHJZL6sqCWIhKNf+attc5qfRMw/yYfyjlcvxfPLcdZ2tFXG6GEyRTrkeG9hPe
	 RbccWtTei8dST6ZW6dzgMu0HYotGR1IXKjawmIKTu1Lg9h+KzSZagtQKnWA2y6GGW/
	 +R3B6awY2e5vBVX+UpRZJCtN6llvAf9xnKT87VCydlQRx+0zqRmn++uWCdLrzROO/C
	 1eKph3UwKib+hN8H7eT8S6wYRn7rHCZSaJg+IEx1btPsWaM9kcCXUZ8DQ9ArtYwG3f
	 VN3HLRccMV6dg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vCHoN-000000005fF-2fYC;
	Fri, 24 Oct 2025 15:26:31 +0200
Date: Fri, 24 Oct 2025 15:26:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <aPt-h_jzlG3uyLUx@hovoldconsulting.com>
References: <Zt7kCxawoszunWq3@hovoldconsulting.com>
 <20240917044948.i2eog4ondf7vna7q@pengutronix.de>
 <Z8_wcASfJ8SeAQ8l@hovoldconsulting.com>
 <20250313194044.t2t3c7j6ktvshjhs@pengutronix.de>
 <aPogbAozezmqSMuU@hovoldconsulting.com>
 <20251023134828.2dzq2rhtjplqyyaj@pengutronix.de>
 <aPs3BX9-og6wJIWR@hovoldconsulting.com>
 <20251024092738.zao47ehvzckkrsf3@pengutronix.de>
 <aPtV1qNu3aVrS4LS@hovoldconsulting.com>
 <20251024124047.gnhxvjxjv7ie6ryy@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024124047.gnhxvjxjv7ie6ryy@pengutronix.de>

On Fri, Oct 24, 2025 at 02:40:47PM +0200, Marco Felsch wrote:
> On 25-10-24, Johan Hovold wrote:
> > On Fri, Oct 24, 2025 at 11:27:38AM +0200, Marco Felsch wrote:
> > > On 25-10-24, Johan Hovold wrote:
> > > > On Thu, Oct 23, 2025 at 03:48:28PM +0200, Marco Felsch wrote:
> > > > > On 25-10-23, Johan Hovold wrote:
> > > > > > On Thu, Mar 13, 2025 at 08:40:44PM +0100, Marco Felsch wrote:
> > > > > > > On 25-03-11, Johan Hovold wrote:
> > > > > > > > On Tue, Sep 17, 2024 at 06:49:48AM +0200, Marco Felsch wrote:
> > > > > > > > > On 24-09-09, Johan Hovold wrote:
> > 
> > > > It's still one of the issues that need to addressed.
> > > 
> > > Yes but this shouldn't be an issue with this patchset. So far the
> > > smallest DT-describale USB entities are the interfaces.
> > 
> > It is an issue with this patchset since any binding for USB serdev will
> > need to take both kind of devices into account. Period.
> 
> Sorry but I really don't see the issue. As of now DT abstractions
> supports all my use-cases. If $another_developer has an USB device which
> actually exposes multiple serial ports behind a single usb-interface,
> fine. But in that case $another_developer needs to add the
> support/extend the support for it if he wants to use it in combination
> with serdev.

Fine, but if you only care about your use case then you can keep your
implementation out-of-tree until someone comes with along with enough
time to solve this properly.

> > > > > > You will also see the following kind of warnings in the logs:
> > > > > > 
> > > > > > ttyUSB ttyUSB0: tty_hangup: tty->count(1) != (#fd's(0) + #kopen's(0))
> > > > > > ttyUSB ttyUSB0: tty_port_close_start: tty->count = 1 port count = 0
> > > > > > 
> > > > > > which are due to the fact that serdev does not support hangups which are
> > > > > > used during teardown of USB serial ports.

> > You should see it in your test setup as well. Unless the bluetooth
> > driver you use is doing something funky (e.g. not closing the port).
> > 
> > I'm testing with a mock gnss device here.
> 
> Okay, let me test this. Just that we're on the same page: The test is to
> remove the serdev (bluetooth, gnss, ...) driver, right?

No, trigger a disconnect like you did before, or do a physical
disconnect, by wiring up a regular USB port.
 
> > > > Also, that commit message needs to more work since you don't really
> > > > motivate why you think it's needed (e.g. as serdev ports can't be shared
> > > > with user space).

> > No, my point was that serdev devices *are* not shared with user space,
> > you don't need to use that new kopen helper for that.

> > That helper sets the new TTY_PORT_KOPENED flag which suppresses the
> > warning on hangups.
> 
> Okay, so you meant the TTY_PORT_KOPENED flag. According the
> documentation of tty_kopen_exclusive():
> 
> | tty_kopen_exclusive - open a tty device for kernel
> 
> isn't that exactly what serdev-ttyport should do to "not share it with
> user space"? IMHO it's an implementation detail if the logic behind
> "open a tty device for kernel" is only built around a flag to suppress
> the warning.

I give up. I've already told you that serdev does not share anything
with user space.

Johan
