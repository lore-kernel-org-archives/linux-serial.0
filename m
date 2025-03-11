Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C41DE894;
	Tue, 11 Mar 2025 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680758; cv=none; b=O5DJ0RN2eveDhOhegisiR+XRkgF2gPf8PdnDvaiMlG8zzgJJDdAQmpujcww/QcA0GRZPlhD5OhHritJwrxcLlisZiV2W2dppA8ze+Dc/ZHTu/IU8b6Fxq14ru6u6sg43GEhYNzZEy/K9427aFqSJtSWL4YFgiCpNJ1CkmRlvc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680758; c=relaxed/simple;
	bh=zSb95WPbrPnw9lIVPKI1mGrHrwXfgKMta+gE6HnBjFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9b/z96V0C7olIlNTkByAlHmS6mDQ0L55w2bKP09QGksHFkqQ4ubya1ljB19QwfPkLOOSkhZL8KTsswB55DUQpJ2YMvdu15C6dhBwhyXBNaG58xbAPdG4bK5ECGocS1qB6aX4gCOKNEfUiJEKnfkUJGxuRf84Yo046mDOhIpnuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2/x3Srp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2/x3Srp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079D3C4CEE9;
	Tue, 11 Mar 2025 08:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741680758;
	bh=zSb95WPbrPnw9lIVPKI1mGrHrwXfgKMta+gE6HnBjFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D2/x3SrpbcR/fKO+XbKMcevqY3MB3HbCVkHenncnj6Lv2H1NaAptAWniZHDURh3ra
	 toVmeiF0DpLGKrz3GazLkoEwxeilvPv6Ao4s98WtG0P76XGnMudXu3DyY7NN9AX6d7
	 dnQd6mlYpL1cSXUHKPzrWqeLBn62FjouoflPzrWLBweaOwgWNGXUyEeIFPzAZrE+Rw
	 6NuCptaALSBhTbWqsXX6ygO4IP5GOEAQMQmCL88D1C3X5lxsA5yfQW6T0WIjFonx9F
	 pBpWpxyUM2qTf/V3sWH4N7UMqrq1H1gRcVVoo9E7xvLlGxUg2ydEJ9TCDAW0JLZcK+
	 m63eptsXx9KbA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1truj2-0000000048n-2YC5;
	Tue, 11 Mar 2025 09:12:33 +0100
Date: Tue, 11 Mar 2025 09:12:32 +0100
From: Johan Hovold <johan@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <Z8_wcASfJ8SeAQ8l@hovoldconsulting.com>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
 <Zt7kCxawoszunWq3@hovoldconsulting.com>
 <20240917044948.i2eog4ondf7vna7q@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917044948.i2eog4ondf7vna7q@pengutronix.de>

On Tue, Sep 17, 2024 at 06:49:48AM +0200, Marco Felsch wrote:
> On 24-09-09, Johan Hovold wrote:
> > On Wed, Aug 07, 2024 at 04:08:47PM +0200, Marco Felsch wrote:
> > > this patchset is based on Johan's patches [1] but dropped the need of
> > > the special 'serial' of-node [2].
> > 
> > That's great that you found and referenced my proof-of-concept patches,
> > but it doesn't seem like you tried to understand why this hasn't been
> > merged yet.

> > First, as the commit message you refer to below explain, we need some
> > way to describe multiport controllers. Just dropping the 'serial' node
> > does not make that issue go away.
> 
> Sorry for asking but isn't the current OF abstraction [1] enough? As far
> as I understood we can describe the whole USB tree within OF. I used [1]
> and the this patchset to describe the following hierarchy:
> 
>  usb-root -> usb-hub port-1 -> usb-serial interface-0 -> serial
>                                                          bt-module
> 
> [1] Documentation/devicetree/bindings/usb/usb-device.yaml

Again, you still need to consider devices with multiple serial ports
(and they do not always map neatly to one port per interface either).

> > Second, and more importantly, you do not address the main obstacle for
> > enabling serdev for USB serial which is that the serdev cannot handle
> > hotplugging.
> 
> Hotplugging is a good point but out-of-scope IMHO (at least for now)
> since the current serdev implementation rely on additional firmware
> information e.g OF node to be present. E.g. if the above mentioned setup
> would connect the "serial bt-module" directly to the UART port you still
> need an OF node to bind the serdev driver. If the node isn't present
> user-space would need to do the hci handling.

There's nothing preventing you from adding a devicetree node for a USB
device that can be unplugged.

> So from my POV the serdev abstraction is for manufacturers which make
> use of "onboard" usb-devices which are always present at the same USB
> tree location. Serdev is not made for general purpose USB ports (yet)
> where a user can plug-in all types of USB devices.

Right, but someone need to make sure that serdev can handle devices
going away first as nothing is currently preventing that from happening.

> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/log/?h=usb-serial-of
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-serial-of&id=b19239022c92567a6a9ed40e8522e84972b0997f

Johan
