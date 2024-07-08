Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C45680046;
	Mon,  8 Jul 2024 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440355; cv=none; b=HZiaYgaE4pUeQJdVSITh++TmoCXmXx7iNjHTC1e+/BTWgcdZWwH94Xg+dX1cbQX4DcTZQQqqEV7bjpK5w3kIRFcjJ5YGUEytqEgeDpohZrnEVSQBRiVAtlBwn05/+H2u4FkPKufQnaGTdoTfwfaLKLEij7Khul93SsPRInPv4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440355; c=relaxed/simple;
	bh=zYiZL26YpL9nyJBbsDP8s4nzF/bHXrFqq56T1M+s51E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQl1JDn/iaifH6mY60F0ZjafawAj/aYQ1K7vUA7vbHNv4tvokzLG3VmMfLGxwUdYvYUG5DsH2Qv6cTjBDS95pHFpM4u0VlEflBWKYE0m1eyFe5RbcVU7g9xBOWRp35ahvYAmHLyIRs8O9qVOtSYEujrGc8r7EO8gmHOaJoh3iI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CScz0WZ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CScz0WZ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64675C116B1;
	Mon,  8 Jul 2024 12:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720440354;
	bh=zYiZL26YpL9nyJBbsDP8s4nzF/bHXrFqq56T1M+s51E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CScz0WZ99qjtrVPURkXM/OG7BWNP/9toOwOYu6FHQmMXHVS6vkrvE9s+tv5Ag5GyX
	 d+zy08c/3FCc+bWgUIJ7D1QfpyaxOclKyAHbpORvZQ3DzeBDFFpM9eKl8bF8rGjBxg
	 O8elQO+czjq/PgK0FCDdM25lfRqHJ5rZnhexQ2hQloqpbDSQaznCXUIj6Kkm7W2zar
	 NA8pOYoEg8GY9ARqy90GQp9O/yRmwRLa4w8v5X27EEMtbutKNUoe1k2Ys/mxs1z7WY
	 Q5DiUvNWoCzrUZ0ZEEFqFibTyuflF0nlqRRMzfMh5DnQLLR9rKpBDr8DjJik3arWvl
	 3VRj9O/Fa7eQg==
Date: Mon, 8 Jul 2024 19:51:43 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] serial: 8250: move mmp|pxa uart earlycon code and add
 xscale earlycon
Message-ID: <ZovSzxZzZJRS8JWm@xhacker>
References: <20240706101856.3077-1-jszhang@kernel.org>
 <20240706223323.GYA367.dlan.gentoo>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240706223323.GYA367.dlan.gentoo>

On Sat, Jul 06, 2024 at 10:33:23PM +0000, Yixun Lan wrote:
> Hi 
> On 18:18 Sat 06 Jul     , Jisheng Zhang wrote:
> > There are two other drivers that bind to "mrvl,mmp-uart": the 8250_of
> > and the 8250_pxa. The previous one is generic and the latter is binded
> > to ARCH_PXA || ARCH_MMP. Now we may have pxa programming compatible
> > HW to support, making use of the generic 8250_of seems a good idea.
> > However, there's no earlycon support if we go with this solution. So
> > move the mmp|pxa-uart earlycon code to core 8250_early.c.
> > 
> > At the same, add xscale earlycon support too, only build test since
> > I have no xscale machine any more.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  drivers/tty/serial/8250/8250_early.c | 11 +++++++++++
> >  drivers/tty/serial/8250/8250_pxa.c   | 16 ----------------
> >  2 files changed, 11 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> > index e3f482fd3de4..6176083d0341 100644
> > --- a/drivers/tty/serial/8250/8250_early.c
> > +++ b/drivers/tty/serial/8250/8250_early.c
> > @@ -171,6 +171,17 @@ OF_EARLYCON_DECLARE(ns16550a, "ns16550a", early_serial8250_setup);
> >  OF_EARLYCON_DECLARE(uart, "nvidia,tegra20-uart", early_serial8250_setup);
> >  OF_EARLYCON_DECLARE(uart, "snps,dw-apb-uart", early_serial8250_setup);
> >  
> > +static int __init early_serial8250_rs2_setup(struct earlycon_device *device,
> > +					     const char *options)
> > +{
> > +	device->port.regshift = 2;
> just wondering if possible to introduce a generic earlycon sub option? so kernel

the 8250 ealycon can parse reg-shift from dt too, so no sub option is
needed. The reason I hardcoded here is: pxa-uart and xscale-uart doesn't
mandate "reg-shift" property in the binding, while I did see mmp-uart
mentions "reg-shift" is required in the DT binding.


> can parse reg-shift from command line parameter instead of hardcoding here,
> which would benefit more drivers (potentially without adding more OF_EARLYCON_DECLAREs..)
> 
> I mean something like this:
> Documentation/admin-guide/kernel-parameters.txt
> uart[8250],mmio32,<addr>[,options[,reg-shift=0,1,2,4 ..]]
> 
> > +
> > +	return early_serial8250_setup(device, options);
> > +}
> > +OF_EARLYCON_DECLARE(uart, "intel,xscale-uart", early_serial8250_rs2_setup);
> > +OF_EARLYCON_DECLARE(uart, "mrvl,mmp-uart", early_serial8250_rs2_setup);
> > +OF_EARLYCON_DECLARE(uart, "mrvl,pxa-uart", early_serial8250_rs2_setup);
> > +
> >  #ifdef CONFIG_SERIAL_8250_OMAP
> >  
> >  static int __init early_omap8250_setup(struct earlycon_device *device,
> > diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
> > index ba96fa913e7f..b5d937f6f3f9 100644
> > --- a/drivers/tty/serial/8250/8250_pxa.c
> > +++ b/drivers/tty/serial/8250/8250_pxa.c
> > @@ -165,22 +165,6 @@ static struct platform_driver serial_pxa_driver = {
> >  
> >  module_platform_driver(serial_pxa_driver);
> >  
> > -#ifdef CONFIG_SERIAL_8250_CONSOLE
> > -static int __init early_serial_pxa_setup(struct earlycon_device *device,
> > -				  const char *options)
> > -{
> > -	struct uart_port *port = &device->port;
> > -
> > -	if (!(device->port.membase || device->port.iobase))
> > -		return -ENODEV;
> > -
> > -	port->regshift = 2;
> > -	return early_serial8250_setup(device, NULL);
> > -}
> > -OF_EARLYCON_DECLARE(early_pxa, "mrvl,pxa-uart", early_serial_pxa_setup);
> > -OF_EARLYCON_DECLARE(mmp, "mrvl,mmp-uart", early_serial_pxa_setup);
> > -#endif
> > -
> >  MODULE_AUTHOR("Sergei Ianovich");
> >  MODULE_LICENSE("GPL");
> >  MODULE_ALIAS("platform:pxa2xx-uart");
> > -- 
> > 2.43.0
> > 
> 
> -- 
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55
