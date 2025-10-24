Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E0826F2BD;
	Fri, 24 Oct 2025 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301968; cv=none; b=TUD4qBCros4agD8aRQMwHDATu8Tp+Fs0ZWMU0MyBNmqYUVY/TR9c4IunQ53AVuET1IH6OUlqN70eoK3ShrSqFSeySftqAyQdVCvcpKJTV3q5Twc7m2emnSL9YW+pItm3WhD/F5avPoEkAe0k/WDyOzpZLyldx4vvAx81bOn7IZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301968; c=relaxed/simple;
	bh=tKXOV20AUg8P4v3Ae4bzYimBTaokjawTTrJ7Uz/5YwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQlpjJVEs3Bn4mo9BnaXZIeRgvNZDoq9zrl5mJqx8uXkOg+1yqiKvhfnZup/9GM8/IUcsJo/97rgYFDTUGmCu3XhrlcaVDjhrriGYbHuiwSBLp3ySptWbFRZAdYuc40qc3m9U/YwofPy5zPclaU5BENXoxiRlxM6kFtjIZiZfIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lX5o5lSL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX5o5lSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B08C4CEF1;
	Fri, 24 Oct 2025 10:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761301967;
	bh=tKXOV20AUg8P4v3Ae4bzYimBTaokjawTTrJ7Uz/5YwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lX5o5lSLWbgVGl2/g0nIX+enmLGp6T4rXgOcXL4L+b+s0zjqr29XskreNo6AxqQrf
	 gMts8KtrIBxyr/BJhBa3uyRyC91u4rVXhT4pQWJhWyc2bKUb8O9a+QTNKGfEt5wivD
	 61OspIk/KYTUbPVpnGyXw41sdBjXk7gr4zR+xGBgo+BrusLb9fgHJkv3mO5dX9WkRc
	 na77c3SpJg2q419uftLPqBBxanSgvqlr6Mq9mlpZZvlawnT4JjO0+dScEZO44wF/kZ
	 bg1RtVZYzIdbTzZ655NZ9kQqEmUdxeilnd/jNzq4OmqeSNSFInWKKadyN//22ETwG/
	 FhOCvs1MZhrzA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vCF6M-000000003Lh-0Car;
	Fri, 24 Oct 2025 12:32:54 +0200
Date: Fri, 24 Oct 2025 12:32:54 +0200
From: Johan Hovold <johan@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <aPtV1qNu3aVrS4LS@hovoldconsulting.com>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
 <Zt7kCxawoszunWq3@hovoldconsulting.com>
 <20240917044948.i2eog4ondf7vna7q@pengutronix.de>
 <Z8_wcASfJ8SeAQ8l@hovoldconsulting.com>
 <20250313194044.t2t3c7j6ktvshjhs@pengutronix.de>
 <aPogbAozezmqSMuU@hovoldconsulting.com>
 <20251023134828.2dzq2rhtjplqyyaj@pengutronix.de>
 <aPs3BX9-og6wJIWR@hovoldconsulting.com>
 <20251024092738.zao47ehvzckkrsf3@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024092738.zao47ehvzckkrsf3@pengutronix.de>

On Fri, Oct 24, 2025 at 11:27:38AM +0200, Marco Felsch wrote:
> On 25-10-24, Johan Hovold wrote:
> > On Thu, Oct 23, 2025 at 03:48:28PM +0200, Marco Felsch wrote:
> > > On 25-10-23, Johan Hovold wrote:
> > > > On Thu, Mar 13, 2025 at 08:40:44PM +0100, Marco Felsch wrote:
> > > > > On 25-03-11, Johan Hovold wrote:
> > > > > > On Tue, Sep 17, 2024 at 06:49:48AM +0200, Marco Felsch wrote:
> > > > > > > On 24-09-09, Johan Hovold wrote:

> > It's still one of the issues that need to addressed.
> 
> Yes but this shouldn't be an issue with this patchset. So far the
> smallest DT-describale USB entities are the interfaces.

It is an issue with this patchset since any binding for USB serdev will
need to take both kind of devices into account. Period.

> > > > > > > > Second, and more importantly, you do not address the main obstacle for
> > > > > > > > enabling serdev for USB serial which is that the serdev cannot handle
> > > > > > > > hotplugging.
> > 
> > > > You will also see the following kind of warnings in the logs:
> > > > 
> > > > ttyUSB ttyUSB0: tty_hangup: tty->count(1) != (#fd's(0) + #kopen's(0))
> > > > ttyUSB ttyUSB0: tty_port_close_start: tty->count = 1 port count = 0
> > > > 
> > > > which are due to the fact that serdev does not support hangups which are
> > > > used during teardown of USB serial ports.
> > > 
> > > IIRC I added the following patch to solve this:
> > > 
> > >  - [PATCH 1/3] serdev: ttyport: make use of tty_kopen_exclusive
> > > 
> > > Sorry for not remembering the details since this conversation/patchset
> > > is quite old but still one of our top prios.
> > 
> > That suppresses the first warning but doesn't address the underlying
> > issue (that hangups are built around file handles which serdev does not
> > use). And you will still see the second one when the serdev driver tries
> > to close the already hung up port during deregistration.
> 
> Can you please elaborate how I can check this? I'm not aware of any
> warning yet, but I only tested the hot-(un)plug. If I got your right, I
> should see the issue once I unload the serdev driver, right?

You should see it in your test setup as well. Unless the bluetooth
driver you use is doing something funky (e.g. not closing the port).

I'm testing with a mock gnss device here.

> > Also, that commit message needs to more work since you don't really
> > motivate why you think it's needed (e.g. as serdev ports can't be shared
> > with user space).
> 
> Maybe it needs some adaptions but:
> 
> | The purpose of serdev is to provide kernel drivers for particular serial
> | device, serdev-ttyport is no exception here. Make use of the
> | tty_kopen_exclusive() funciton to mark this tty device as kernel
> | internal device.
> 
> the last sentence should address your point that serdev ports can't be
> shared with user-space.A

No, my point was that serdev devices *are* not shared with user space,
you don't need to use that new kopen helper for that.

> > If it's just about suppressing the warning you could possibly just have
> > set that new flag.
> 
> Which new flag? As I have written in my commit message: "Make use of ...
> to mark this tty device as kernel internal device". I thought this was
> the purpose of tty_kopen_exclusive().

That helper sets the new TTY_PORT_KOPENED flag which suppresses the
warning on hangups.

Johan
