Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0697030568B;
	Thu, 30 Jul 2026 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428425; cv=none; b=jVc7WF/Hy/4quff2y4pLU2lTHn/BRYVexcmH68MghReJ18q084QFRi3dSNknL8pcOuRgdq8mp6MYZ3pOk/JvFdoA6dE3yECEwM3RZFd+BDdgHi/JdyR1d0fAkkZVfVih2D04SJMRL/tw/HMC3pvvnrJkOGCdz16f5LyjV8FeKQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428425; c=relaxed/simple;
	bh=+9UGuttv5hstIeLX8WA7WF8fC5iVeRfGPrIHU+otEzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPB0EF2l6dfasUc96QyjgPCHucPnHsf3LKNSE4S7mc8Z+WKTpLQE0LakT2kvWau4dmjt5/gEvrrMAUNVXVlrq1djXip9q4NdygGuqI0ttxH/UplUfWoElIpGUkSM3xGz4awUWUmS8SIi/hZ7kb0icI4JekfPXQt3f2nuNekpnR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CWlzzHru; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CWlzzHru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234C41F000E9;
	Thu, 30 Jul 2026 16:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428423;
	bh=e5C4wwtQFXgMUGzR9hQg4pDI52/QJbOlV+rCqkxZphQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CWlzzHrun8g0+dCk/LPXhY6U1vzgnKSpigpqOsvf/VE0oA3IaRdBaZtu3ORPWZlsL
	 xFtrV4+KM3C2WCdpnV/uBxmdfTcehzRRnlqsJbdLvnwjtaIxu/KdLOXm7CO53ROFTf
	 CKsYuT+CtfT8JQhJ33zTFifM9cApP1orqWEs1EV4=
Date: Thu, 30 Jul 2026 16:49:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Hugo Villeneuve <hugo@hugovil.com>, Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_hub6: Fix double definition for
 hub6_match_port()
Message-ID: <2026073028-anointer-unlinked-c0ea@gregkh>
References: <al34uIyOue73MMN0@monoceros>
 <20260720100708.5b9b3ed9f6f42b27adb264d4@hugovil.com>
 <al6PfMCuRiYcOBQV@monoceros>
 <20260720185326.9652faa0df7b02e07eeb7d4b@hugovil.com>
 <amGYgUhPrSdR5srV@monoceros>
 <20260723231359.5d7fa1e8e11990fa00c476f4@hugovil.com>
 <amMZoJ41FKcd2ddG@monoceros>
 <20260727112210.7a0b08d19de0e17fbd995290@hugovil.com>
 <20260727112643.86b3ab3a725eabc66eb47e39@hugovil.com>
 <amn8Hb2dbv_Sah_Y@monoceros>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amn8Hb2dbv_Sah_Y@monoceros>

On Wed, Jul 29, 2026 at 03:30:57PM +0200, Uwe Kleine-König wrote:
> Hello Hugo,
> 
> On Mon, Jul 27, 2026 at 11:26:43AM -0400, Hugo Villeneuve wrote:
> > On Mon, 27 Jul 2026 11:22:10 -0400
> > Hugo Villeneuve <hugo@hugovil.com> wrote:
> > 
> > > Hi Uwe,
> > > 
> > > On Fri, 24 Jul 2026 09:58:13 +0200
> > > Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:
> > > 
> > > > On Thu, Jul 23, 2026 at 11:13:59PM -0400, Hugo Villeneuve wrote:
> > > > > > For me the open question remains if the driver works in the
> > > > > > configuration CONFIG_SERIAL_8250=y (and thus CONFIG_SERIAL_CORE=y) +
> > > > > > CONFIG_SERIAL_8250_HUB6=m. In this case at least commit
> > > > > > 3d406299d8829747fe2e8692f4c29fe3dc1d101f +
> > > > > > https://lore.kernel.org/linux-serial/20260715153707.4181828-1-hugo@hugovil.com/
> > > > > > introduces a logical change in uart_match_port() that isn't explained in
> > > > > > the commit log.
> > > > > 
> > > > > Not sure what you mean by that logical change?
> > > > 
> > > > With said configuration and before
> > > > 3d406299d8829747fe2e8692f4c29fe3dc1d101f uart_match_port() returned
> > > > 
> > > > 	port1->iobase == port2->iobase && port1->hub6 == port2->hub6
> > > > 
> > > > and with 3d406299d8829747fe2e8692f4c29fe3dc1d101f (and your fix on top)
> > > > it returns false (because when drivers/tty/serial/serial_core.c is
> > > > compiled IS_REACHABLE(CONFIG_SERIAL_8250_HUB6) evaluates to false).
> > > 
> > > this change was certainly not intended, sorry about that. Looks like
> > > there are still subtle Kconfig-isms (and 8250-isms) that I still need to
> > > master...
> > > 
> > > So to be sure i understand this correctly:
> > > I will submit a patch to replace IS_REACHABLE with IS_ENABLED, which
> > > means that the configuration CONFIG_SERIAL_8250=y and
> > > CONFIG_SERIAL_8250_HUB6=m is not supported, as you stated that
> > > it currently cannot happen?
> 
> No, that can happen. e.g. ARCH=parisc allmodconfig has something similar
> (and this is how I stumbled over the breakage of
> 3d406299d8829747fe2e8692f4c29fe3dc1d101f).
> 
> [similar = SERIAL_CORE=y + SERIAL_8250_HUB6=m]
> 
> > Or we leave it as is, since this combination is not really valid?
> 
> Not sure what you're saying here. You want to keep the IS_REACHABLE and
> so be able to compile CONFIG_SERIAL_8250=y + CONFIG_SERIAL_8250_HUB6=m
> but have that broken at runtime? What does make CONFIG_SERIAL_8250=y +
> CONFIG_SERIAL_8250_HUB6=m "not really valid"? Or do you mean something
> else?
> 
> I think the real fix would be to just copy uart_match_port() into the
> two drivers that actually use it (and remove the then dead code paths).
> Then it would be drivers/tty/serial/8250/8250_core.c using
> hub6_match_port() only and that can be handled by a proper dependency.

I'm totally confused, so I'll drop this patch from my review queue and
wait for you all to figure it out :)
