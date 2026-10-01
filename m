Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F069B4BCAA9;
	Thu,  1 Oct 2026 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845958; cv=none; b=uOF74cmQPFZRyiZV/GL1Ioa7hbkhcS8jWcvxN0ouRUGe9zIX/ThFQBIod4u14xCrabYDYtUxknQxHx0/eG7R3ls8Y5tcI6sa/lK+TldYpIhq71/YBSL4Y69itlg9yaZeBp9z/7VXKm49RQhdHR46UA9seXpBwkLYHStqJ1BvrTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845958; c=relaxed/simple;
	bh=T52j4RXUYEr0OMRBojj9z4kVfnxFZfeqg2qHF78LxCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XObt1GOv8V3eWxbijNUCsnJh0ZhTgXDJfwJ8j7YkgcD+Y7so/qJe7elMprl3HIdX5ALXR/rt19r5aQakrUgj9txF2hTaRpKXeaaFHr9ocm4Q9Y4dXF9dyEAr0xg/FyBkLZOsinCn2Wz8JuI7Twpr0b4VjnF1ZcyVBTHO/famP2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v50h3bi3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v50h3bi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079021F000FF;
	Thu,  1 Oct 2026 09:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790845956;
	bh=idaqNScWi/0Rw+2KHY10jVpi4L4PGGs5cd7Rx8836hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=v50h3bi3JCvhTDor0maAoQWWGEnDH+yCc/PvsrGiib6xHwk59wGNx+x6u3ihEoOkl
	 /HMrgYKbTvXNljZo7s+xCIRHXCt7w3fA7y+369sQoV3dqy6T2z5GouessR3ppoJO3a
	 oXdxYg3L4cBDVt7NGB/yyyq6YWKBwU4Wn/8tRAOI=
Date: Thu, 1 Oct 2026 11:12:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Jo=E3o?= Loureiro <joaofl@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Sherry Sun <sherry.sun@nxp.com>,
	Frank Li <frank.li@nxp.com>, Alexander Dahl <ada@thorsis.com>,
	linux-serial@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: fsl_lpuart: add support for GPIO-controlled
 modem lines
Message-ID: <2026100152-pupil-enlighten-9295@gregkh>
References: <20260819144458.253967-1-joaofl@gmail.com>
 <2026092313-snare-goggles-ed1c@gregkh>
 <CAJMWnCiJsNXsEe9JWDGBzHBGiUToco31ysoHF_Loj-9=YMQ3GQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJMWnCiJsNXsEe9JWDGBzHBGiUToco31ysoHF_Loj-9=YMQ3GQ@mail.gmail.com>

On Wed, Sep 23, 2026 at 10:41:09PM +0200, João Loureiro wrote:
> On Wed, Sep 23, 2026 at 02:53PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Aug 19, 2026 at 04:44:53PM +0200, João Loureiro wrote:
> > > --- a/drivers/tty/serial/Kconfig
> > > +++ b/drivers/tty/serial/Kconfig
> > > @@ -1301,6 +1301,7 @@ config SERIAL_FSL_LPUART
> > >       tristate "Freescale lpuart serial port support"
> > >       depends on HAS_DMA
> > >       select SERIAL_CORE
> > > +     select SERIAL_MCTRL_GPIO if GPIOLIB
> >
> > Why not depends?
> 
> Because SERIAL_MCTRL_GPIO is a hidden symbol.  It is declared as a bare
> "tristate" with no prompt at the end of the same Kconfig file, so it can
> only ever be enabled by a select.  With "depends on SERIAL_MCTRL_GPIO"
> nothing could ever satisfy the dependency and SERIAL_FSL_LPUART would
> become unselectable.
> 
> The dependency is also not a hard one.  serial_mctrl_gpio.h provides
> no-op static inlines for the !CONFIG_GPIOLIB case, so fsl_lpuart still
> builds and behaves exactly as before when GPIOLIB is off; the GPIO modem
> lines are an optional extra rather than a requirement.  A depends would
> silently drop LPUART from those configurations.
> 
> Finally, this is what every other user of the helpers does:
> SERIAL_ATMEL, SERIAL_IMX, SERIAL_SH_SCI, SERIAL_STM32, SERIAL_MXS_AUART,
> SERIAL_SA1100, SERIAL_CLPS711X and SERIAL_AR933X all spell it as
> "select SERIAL_MCTRL_GPIO if GPIOLIB" in the same file, so this keeps
> fsl_lpuart consistent with them.

for some reason your first email in this thread is not on
lore.kernel.org so I can't run the CI tools on it.

Can you resend a new version so that we can test it?

thanks,

greg k-h
