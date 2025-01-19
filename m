Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABFB6FC3;
	Sun, 19 Jan 2025 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737269324; cv=none; b=dV+aQfSdixHywQKzI64KKmuoH9ijgbBDO2nyRpqDIjAJ7udPAS/AzclBwsXDM7AsT2IAcy+y8gFU+qpl4AP0pCUBnhL9/8vtzqv/510CATEeqjhIGjiC0OQI54Z8afAr+RWiMsw/idb/ASencSw4cxEV1bj7H3VU7Po79t6MZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737269324; c=relaxed/simple;
	bh=c5UUPcs9GFUBQJvLAMsuAKngOP/kLP2FiWK7PVvLc6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5iA2Sd/k2sMWt+wwW6IEpQ+YlANZgcDZ4FdbL6xu0ofD8tclAeZJy+vQo46tQfeHZu7BFkTmZCd+XAb+Z3EHNQJ7Ocdxrm02FSaBVoqlzbtXxa852r9cz4tNHtUg9hlXtz154ns/vC4RNAJTGiR2CEY5kXz5fsd52vHwIIojro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IPsREJWE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IPsREJWE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F589C4CED6;
	Sun, 19 Jan 2025 06:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737269323;
	bh=c5UUPcs9GFUBQJvLAMsuAKngOP/kLP2FiWK7PVvLc6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPsREJWEiKZ3QzWw1iPa2da3ND5B4WTp4PVNylWWHQtxxXt2W7CJorrWFhnPzCBDU
	 MxZINoXRyuYb7YTYC3ggRk/Tblju2zh3HxqRaEh3v/VjgNnOaVDnd3KBt1Hxzvz/sm
	 OPO0UA9d8U7T0lF2WV41bmSPgyVQg5KaPwohe1wE=
Date: Sun, 19 Jan 2025 07:48:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andre Werner <andre.werner@systec-electronic.com>
Cc: jirislaby@kernel.org, hvilleneuve@dimonoff.com, andy@kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	lech.perczak@camlingroup.com
Subject: Re: [External Email] Re: [PATCH v2] serial: sc16is7xx: Extend IRQ
 check for negative values
Message-ID: <2025011924-circle-iron-5d09@gregkh>
References: <20250117171822.775876-1-andre.werner@systec-electronic.com>
 <2025011855-ashen-gigantic-f832@gregkh>
 <2ba9bd72-f391-7590-d309-c1c2ecc5ce78@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ba9bd72-f391-7590-d309-c1c2ecc5ce78@systec-electronic.com>

On Sat, Jan 18, 2025 at 08:28:49PM +0100, Andre Werner wrote:
> Dear Greg,
> 
> > On Fri, Jan 17, 2025 at 06:18:22PM +0100, Andre Werner wrote:
> > > Fix the IRQ check to treat the negative values as No IRQ.
> > >
> > > Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> > > ---
> > > V2:
> > > There are no changes to the patch itself. The previous patch submission
> > > had a very weird structure within the discussion thread:
> > > https://lkml.org/lkml/2025/1/16/398
> > > This is simply a new thread opened for better handling.
> > > ---
> > >  drivers/tty/serial/sc16is7xx.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > > index 7b51cdc274fd..560f45ed19ae 100644
> > > --- a/drivers/tty/serial/sc16is7xx.c
> > > +++ b/drivers/tty/serial/sc16is7xx.c
> > > @@ -1561,7 +1561,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
> > >  	/* Always ask for fixed clock rate from a property. */
> > >  	device_property_read_u32(dev, "clock-frequency", &uartclk);
> > >
> > > -	s->polling = !!irq;
> > > +	s->polling = (irq <= 0);
> > >  	if (s->polling)
> > >  		dev_dbg(dev,
> > >  			"No interrupt pin definition, falling back to polling mode\n");
> > > --
> > > 2.48.0
> > >
> > >
> >
> > What commit id does this "fix"?
> 
> 104c1b9dde9d859dd01bd2d71a2755a2fae43e15
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?h=tty-next&id=104c1b9dde9d859dd01bd2d71a2755a2fae43e15
> 

Great, then properly document that with a Fixes: tag when you resend
this please.

thanks,

greg k-h
