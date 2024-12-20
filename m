Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4CB25949A;
	Fri, 20 Dec 2024 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734673826; cv=none; b=hKGZv5hcw4oXudKp6NRSaC+lm/51A0vfxqw/IdH9CfB4T5OEEJXManVFYh5487oa1rqHDaRem9PuzAWMFvhzDRpoA/YvDhA+aYBH02dsyLQAGfshL/oR7iswD34D4lLBrdL7urqUIzD/8COB+qqoUZVJXubn7t9OJegoCk0WANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734673826; c=relaxed/simple;
	bh=Rt9EEptbiT5JTor4VKSUvfjZZlrraLVmHZh0HAVivmY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=glv+IYEl9K6zvhDSFTTzeF6V19gAT2qOJg5JDUcx0pPLCRh2oH+Y38iak8oG9X0vaps+qBPlIp8C3a97ulIcT+ddskwxJnW3wlxBAr/Wa/pbPHIS3UX5PahKkfRX8YCNRjM5Fvn62TnjYajUqKX+T8FIwYPPQ+/yE7WVfErZ8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=KeamvsYz; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="KeamvsYz"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 76591940010A;
	Fri, 20 Dec 2024 06:50:17 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id cxAVJx7jychw; Fri, 20 Dec 2024 06:50:17 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 45D2794016AB;
	Fri, 20 Dec 2024 06:50:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 45D2794016AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1734673817; bh=t3x5OH81PBlki8yWuznnLWWopP+5nN9pGnWnWMnuAX0=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=KeamvsYz9LBWzahZS5KAzSK9SSofdRQ7v4BZrfNTtV3EtgbMCyUFzneLdUCQ/RuMT
	 vlbaGBWDEf0PoZDKELH4z8pRkloMoNqrz2eHH1P3wyYXxfgN9J6zPEOINwvZ1S1bSH
	 eq+aRjWPEPOreJ2ieJVam5C7PDWVTsU+iJTj+k4mMtyKXjlqe69MeSxT82hSg8hJCH
	 PXk9SBNQe/6hpelAi7XmjjdEGcTLwVAfRhzDerAI46jcgNW+JKadYRQxWTZFvwC3Gs
	 9Eg8XrRtcbC110dwxJ/2IDDvXbf6xoGm9fEl/q2rUc4zkoptqxZHfP4LCsNrldpJK7
	 IyhPJzaUYwyjA==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 5Tl2IiigLhDQ; Fri, 20 Dec 2024 06:50:17 +0100 (CET)
Received: from ws565760 (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id E0C34940010A;
	Fri, 20 Dec 2024 06:50:16 +0100 (CET)
Date: Fri, 20 Dec 2024 06:50:16 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
Reply-To: Andre Werner <andre.werner@systec-electronic.com>
To: Greg KH <gregkh@linuxfoundation.org>
cc: Andre Werner <andre.werner@systec-electronic.com>, jirislaby@kernel.org, 
    hvilleneuve@dimonoff.com, andy@kernel.org, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, lech.perczak@camlingroup.com
Subject: Re: [External Email] Re: [PATCH] serial: sc16is7xx: Add polling
 feature if no IRQ usage possible
In-Reply-To: <2024121906-reach-hash-3d7c@gregkh>
Message-ID: <5a524cb7-23d9-63b8-81fc-b68a23fddd65@systec-electronic.com>
References: <20241219084638.960253-1-andre.werner@systec-electronic.com> <2024121931-turbojet-preamble-b520@gregkh> <fbd224a3-8f10-3ccf-5480-38fcd839d409@systec-electronic.com> <2024121906-reach-hash-3d7c@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Dear Greg:

On Thu, 19 Dec 2024, Greg KH wrote:

> On Thu, Dec 19, 2024 at 10:22:40AM +0100, Andre Werner wrote:
> > Dear Greg,
> > On Thu, 19 Dec 2024, Greg KH wrote:
> >
> > > On Thu, Dec 19, 2024 at 09:46:38AM +0100, Andre Werner wrote:
> > > > Fall back to polling mode if no interrupt is configured because not
> > > > possible. If "interrupts" property is missing in devicetree the driver
> > > > uses a delayed worker to pull state of interrupt status registers.
> > > >
> > > > Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> > > > ---
> > > > This driver was tested on Linux 5.10. We had a custom board that was not
> > > > able to connect the interrupt port. Only I2C was available.
> > >
> > > Could you not test this on the latest tree?  5.10 is _VERY_ old now.
> >
> > I will try it on devboard with a 6.1 Kernel. Is that okay for you?
>
> 6.1 was released in December of 2022, 2 full years and hundreds of
> thousands of changes ago.  Please work off of Linus's latest tree, we
> can't go back in time :)

>
> > > > @@ -1537,7 +1564,13 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
> > > >
> > > >  	/* Always ask for fixed clock rate from a property. */
> > > >  	device_property_read_u32(dev, "clock-frequency", &uartclk);
> > > > +	s->polling = !device_property_present(dev, "interrupts");
> > > >
> > > > +	if (s->polling) {
> > > > +		dev_warn(dev,
> > > > +			 "No interrupt definition found. Falling back to polling mode.\n");
> > >
> > > What is a user supposed to do with this message?  And why would a device
> > > NOT have any interrupts?  This feels like it is just going to pound on
> > > the device and cause a lot of power drain for just a simple little uart.
> >
> > I thought it could be interesting to know that the device has missing
> > interrupt support.
>
> Maybe, but as you are now warning a user about this, what are they
> supposed to do to fix it?
>
> > > Why can't your system provide a valid irq line?
> > >
> >
> > In our case we have only an I2C available in a connection cable and the
> > GPIOs are linked through a two way level shifter.
> > It was a very special situation in our case because target platform and
> > sensor platform are provided.
> > The IRQ from the sensor war not able to drive the two way level shifter low so
> > we always detect outgoing traffic and the IRQ signal but at the target
> > board after the level shifter the signal remains stable. So
> > communication failed with a timeout. So we need to force polling the
> > interrupt status register because
> > both HW solution should not be changed in any way.
>
> Again, you are burning a TON of power just for a simple little uart,
> with your system never being able to go to sleep, are you sure this is
> something that you want others to emulate and support?

I got your point and I'm fully with. This caused me to print a warning
in Kernel log because it should not be the general working method.
In our special case we do not have any other option because the sensor
module using the SC16IS7xx and the hardware with the MCU running Linux OS
are fixed. We had no possibilities to move any GPIO or such. This was
the only chance  to support the dedicated sensor platform and I may be
the case that someone else faces the same problems. I thought that
someone else may benefit from this workaround too. But as I got your
point I'm also fine if it is not merged into main Linux Kernel sources.

>
> thanks,
>
> greg k-h
>
