Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CC61E5B95;
	Thu, 23 Oct 2025 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761222758; cv=none; b=IDDnSb/4lcscNDAfu1rxlcNyhqdQ8MDSk1QC16vWCGrfTmSu+tvV6osuLbBUop+Jmz5WrG+hlpLs9mfjKxPF7wSs76xYokv0hihBbu0aaiftSLnYL6COxiv84Bc1H5gwwGGyTiPqlt2XqUCQLotWH8dqRN3/fB7HEsQPXgNA0bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761222758; c=relaxed/simple;
	bh=NrMDek1mHIScyZ5/eHfylLBBqIEG6Pc+FJM7JCnrANs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eM+5hjy0DyBU5aRYE8QlXzCkqgJhfeuJPnbYJDLtBJ7mEMJgD3S4acm57KjKK7uzYL1DRuosKbxN/bZCBYrQ5yzRTBJbaru/vrMHPIIhJ+bBewR8g8N2B00X04GVQ/xsFFbDZB/qluNu+jFZzt50pAQ6HhmEwXtNt41dKQ2adYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY+qTyDt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY+qTyDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F89C4CEFB;
	Thu, 23 Oct 2025 12:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761222758;
	bh=NrMDek1mHIScyZ5/eHfylLBBqIEG6Pc+FJM7JCnrANs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TY+qTyDtgZP3jLPYkwdf7rJeTRkvMaqmh8wMtpt3hg/qaKUBlQePuwjgLpAX2+fKi
	 CTZTI1jTb7amhlvT2eIy/TY9FmUo165R6qHxmWPcdq3fhRnAAPkUAySBPU1SirH4a8
	 7jniyz76yImOuSqzfo/uKuTFoyd7ux65XceJqP/xp9PcWhhve47CNrTTcacSYqArey
	 /ZGWJr65g+Up1+9cSZehvDXR4Fkf0tb1ByRzNIiHjwuCPpO3zM0Q4vqtYmcrRyCC0p
	 nA1atzpKCSSX544ALsKlwV1PlnohkAm0jWSXKgFV62o18BOF6URasR7J01iigpxbux
	 xP8kAeYdaa1Ow==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vBuUm-000000002ug-1bsC;
	Thu, 23 Oct 2025 14:32:45 +0200
Date: Thu, 23 Oct 2025 14:32:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <aPogbAozezmqSMuU@hovoldconsulting.com>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
 <Zt7kCxawoszunWq3@hovoldconsulting.com>
 <20240917044948.i2eog4ondf7vna7q@pengutronix.de>
 <Z8_wcASfJ8SeAQ8l@hovoldconsulting.com>
 <20250313194044.t2t3c7j6ktvshjhs@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313194044.t2t3c7j6ktvshjhs@pengutronix.de>

On Thu, Mar 13, 2025 at 08:40:44PM +0100, Marco Felsch wrote:
> On 25-03-11, Johan Hovold wrote:
> > On Tue, Sep 17, 2024 at 06:49:48AM +0200, Marco Felsch wrote:
> > > On 24-09-09, Johan Hovold wrote:
> > > > On Wed, Aug 07, 2024 at 04:08:47PM +0200, Marco Felsch wrote:
> > > > > this patchset is based on Johan's patches [1] but dropped the need of
> > > > > the special 'serial' of-node [2].
> > > > 
> > > > That's great that you found and referenced my proof-of-concept patches,
> > > > but it doesn't seem like you tried to understand why this hasn't been
> > > > merged yet.
> > 
> > > > First, as the commit message you refer to below explain, we need some
> > > > way to describe multiport controllers. Just dropping the 'serial' node
> > > > does not make that issue go away.
> > > 
> > > Sorry for asking but isn't the current OF abstraction [1] enough? As far
> > > as I understood we can describe the whole USB tree within OF. I used [1]
> > > and the this patchset to describe the following hierarchy:
> > > 
> > >  usb-root -> usb-hub port-1 -> usb-serial interface-0 -> serial
> > >                                                          bt-module
> > > 
> > > [1] Documentation/devicetree/bindings/usb/usb-device.yaml
> > 
> > Again, you still need to consider devices with multiple serial ports
> > (and they do not always map neatly to one port per interface either).
> 
> We use a dual-port FTDI and our USB tree looks as followed:

> interface-0 is used for the bt-module which is served by the serdev
> driver.
> 
> interface-1 is used by an userspace driver which makes use of the
> /dev/ttyUSB1 port.
>
> So we do have the multiple serial ports use-case already. Can you please
> explain what I miss?

There are other USB serial devices that support multiple ports over a
single USB interface. The DT bindings need to account for that case as
well, and that probably means we should not be describing the interfaces
at all but rather the physical ports.

> > > > Second, and more importantly, you do not address the main obstacle for
> > > > enabling serdev for USB serial which is that the serdev cannot handle
> > > > hotplugging.
> > > 
> > > Hotplugging is a good point but out-of-scope IMHO (at least for now)
> > > since the current serdev implementation rely on additional firmware
> > > information e.g OF node to be present. E.g. if the above mentioned setup
> > > would connect the "serial bt-module" directly to the UART port you still
> > > need an OF node to bind the serdev driver. If the node isn't present
> > > user-space would need to do the hci handling.
> > 
> > There's nothing preventing you from adding a devicetree node for a USB
> > device that can be unplugged.
> 
> I see and I have to admit that I didn't test this :/ But since you
> pointed it out I tested it now!
> 
> So as explained, our USB tree looks as above and our DTS looks like the
> one in the cover letter. Of course I run on an embedded system but the
> USB FTDI based module is powered by the VBUS of the hub. Therefore I
> ran the test by disabling the downstream port which in turn disabled the
> VBUS supply. This should come very close to a physical unplug event.

You will also see the following kind of warnings in the logs:

ttyUSB ttyUSB0: tty_hangup: tty->count(1) != (#fd's(0) + #kopen's(0))
ttyUSB ttyUSB0: tty_port_close_start: tty->count = 1 port count = 0

which are due to the fact that serdev does not support hangups which are
used during teardown of USB serial ports.

> > > So from my POV the serdev abstraction is for manufacturers which make
> > > use of "onboard" usb-devices which are always present at the same USB
> > > tree location. Serdev is not made for general purpose USB ports (yet)
> > > where a user can plug-in all types of USB devices.
> > 
> > Right, but someone need to make sure that serdev can handle devices
> > going away first as nothing is currently preventing that from happening.
> 
> Can you please check my above tests? Maybe I do miss something but for
> me it looks like it's working. Looking forwards for your input.

I skimmed the code to verify that the issue is still there, and even
forward ported my patches to confirm that that you would still see the
port count warnings that indicate that something is amiss.

Johan
