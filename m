Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F927149DF4;
	Thu, 19 Dec 2024 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601288; cv=none; b=dY2NUS2KHSs03Psw2Tedu3ADaweDPPI69xFudO/aPGa4Q2zsFAkP3rKhMhejtPTDgHTC0sQOdbkrgsmrH8Aea8XJiUs2FmMOzwrpyNqyPZ/QBvvwUp78RSl/wY9EVrCg1h3rry/eK6JO/U2m/z3eG8aUonB3M2v9Q+rJxcoqeCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601288; c=relaxed/simple;
	bh=pOMe8zZaOCGaoZGQJzImyxSkGib5qk/ijjniTWD6T7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExUHzFcmEqgovkRhSIR/aOB9MgPokTYCH8mh+tJlqsbDtPUE5duWtXpxr3mP1KhM4Ucb5cgzF2R36HqqyFK+WIZpRLkJGoNprfezNoE91RFKJy8NDi6ggkzdmAL0LPl/YzbDuMTmGfB823Hioovt1bVsw67Tos0iGLGY/+Z92Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h+H+K2FK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h+H+K2FK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E254FC4CED0;
	Thu, 19 Dec 2024 09:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734601286;
	bh=pOMe8zZaOCGaoZGQJzImyxSkGib5qk/ijjniTWD6T7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h+H+K2FKGCX+4zFC5j6+ZgOwMfgStTcBFi+hxiurNHUD6HTPpXDR0jMO5kzHqXqrz
	 +qafK/tuPvywWF0Wr4UIUzFjVVhLFt/LxtoOpLPfic68DxOYgFvrpBL541Yd3GsHDw
	 1r70xruiUf2xO1+9FTjWAdbwJql7jSLbZnQ77ITg=
Date: Thu, 19 Dec 2024 10:41:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: jirislaby@kernel.org, hvilleneuve@dimonoff.com, andy@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com
Subject: Re: [External Email] Re: [PATCH] serial: sc16is7xx: Add polling
 feature if no IRQ usage possible
Message-ID: <2024121906-reach-hash-3d7c@gregkh>
References: <20241219084638.960253-1-andre.werner@systec-electronic.com>
 <2024121931-turbojet-preamble-b520@gregkh>
 <fbd224a3-8f10-3ccf-5480-38fcd839d409@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbd224a3-8f10-3ccf-5480-38fcd839d409@systec-electronic.com>

On Thu, Dec 19, 2024 at 10:22:40AM +0100, Andre Werner wrote:
> Dear Greg,
> On Thu, 19 Dec 2024, Greg KH wrote:
> 
> > On Thu, Dec 19, 2024 at 09:46:38AM +0100, Andre Werner wrote:
> > > Fall back to polling mode if no interrupt is configured because not
> > > possible. If "interrupts" property is missing in devicetree the driver
> > > uses a delayed worker to pull state of interrupt status registers.
> > >
> > > Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> > > ---
> > > This driver was tested on Linux 5.10. We had a custom board that was not
> > > able to connect the interrupt port. Only I2C was available.
> >
> > Could you not test this on the latest tree?  5.10 is _VERY_ old now.
> 
> I will try it on devboard with a 6.1 Kernel. Is that okay for you?

6.1 was released in December of 2022, 2 full years and hundreds of
thousands of changes ago.  Please work off of Linus's latest tree, we
can't go back in time :)

> > > @@ -1537,7 +1564,13 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
> > >
> > >  	/* Always ask for fixed clock rate from a property. */
> > >  	device_property_read_u32(dev, "clock-frequency", &uartclk);
> > > +	s->polling = !device_property_present(dev, "interrupts");
> > >
> > > +	if (s->polling) {
> > > +		dev_warn(dev,
> > > +			 "No interrupt definition found. Falling back to polling mode.\n");
> >
> > What is a user supposed to do with this message?  And why would a device
> > NOT have any interrupts?  This feels like it is just going to pound on
> > the device and cause a lot of power drain for just a simple little uart.
> 
> I thought it could be interesting to know that the device has missing
> interrupt support.

Maybe, but as you are now warning a user about this, what are they
supposed to do to fix it?

> > Why can't your system provide a valid irq line?
> >
> 
> In our case we have only an I2C available in a connection cable and the
> GPIOs are linked through a two way level shifter.
> It was a very special situation in our case because target platform and
> sensor platform are provided.
> The IRQ from the sensor war not able to drive the two way level shifter low so
> we always detect outgoing traffic and the IRQ signal but at the target
> board after the level shifter the signal remains stable. So
> communication failed with a timeout. So we need to force polling the
> interrupt status register because
> both HW solution should not be changed in any way.

Again, you are burning a TON of power just for a simple little uart,
with your system never being able to go to sleep, are you sure this is
something that you want others to emulate and support?

thanks,

greg k-h
