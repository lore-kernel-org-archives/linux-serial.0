Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DDD1922D8;
	Mon, 25 Nov 2024 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530799; cv=none; b=hL7U/+rEBBqN6V7I/gYCeciQGMy1R9zeIrU+t2pVk7TA4mToUz9Xrh432P+JDEoo9A5A8dYieHQs7f6rjSCSuUpwdDOFZOGQWREJmG2e4SrdWCoH4GwNtMKa4nxURwvqK63GQqVE8lXDT9+xgrYoMA73AphvjCjaiH0Wuh41r4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530799; c=relaxed/simple;
	bh=+uoflAdRYVjlXIXkWYl+rqDb6tX7x77CG5QG31XMhDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCvrg/0JMoJqI2kg+q/YAWlK6WdRdwWNafewKsBhr6ix/j1hciAFnw+LZEU2xCuDmBlQ8wTiNYE4Bt8/gkjvhbScznnhpSKxB1lOqQPacPOGWpv1UZp14ZPFR8SvY/t4cSJmsQhpvz0bXiRx4vodfAk8jJgYUDVsKA8QDDxL6Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DeUGQbWW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DeUGQbWW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732530797; x=1764066797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+uoflAdRYVjlXIXkWYl+rqDb6tX7x77CG5QG31XMhDI=;
  b=DeUGQbWWwAGLKFrfnhWaN4kTyaUX2CFkOi1C3b9PaiQzFJwS5z0wT0ag
   u/NKN3eYtO//2VjMHmhAiF4iK2uBnQBzFRjqcCObnzQnik+nMLcsdooxG
   Wl3ib8JRuS51kORDNIU7Yf39LbVGznAQcvUSBzn7DQDvLw/ddg5g85yU7
   frYTENgBvfb5QauUn0Uvc+/WiHyP+raS5oZoCsf8Fx3GBH343+s4/Lg3p
   WBMdd0Z68XoLM6XxWiJb0fqA5W6EIjn7MfRPWZZmx1ydeRRUUS0YIJeAY
   Qcspu0EPRAepeQL6wBn9XRnAGCPX0gO29Ny16d93Dv+eVYsqw4nCCXHMR
   g==;
X-CSE-ConnectionGUID: jJ2eQBg0Q2aUZImms5m4dQ==
X-CSE-MsgGUID: Plg1/tWQRnaNKF/mYrrUsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="32371655"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="32371655"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 02:33:17 -0800
X-CSE-ConnectionGUID: GfjgBMg3RAWvB8I8zIFbfQ==
X-CSE-MsgGUID: xpEPjXOcTXKRhlZygFSOsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91574611"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 02:33:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tFWP1-00000000iJJ-3hFg;
	Mon, 25 Nov 2024 12:33:11 +0200
Date: Mon, 25 Nov 2024 12:33:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Message-ID: <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
 <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Nov 25, 2024 at 10:53:46AM +0100, Arnd Bergmann wrote:
> On Mon, Nov 25, 2024, at 08:55, Andy Shevchenko wrote:
> > On Fri, Nov 22, 2024 at 08:24:37PM +0100, Arnd Bergmann wrote:
> >> On Fri, Nov 22, 2024, at 18:22, Guenter Roeck wrote:
> >> 
> >> This looks like a bug in drivers/tty/serial/8250/8250_platform.c
> >> to me, not something the architectures did wrong. My impression
> >> from __serial8250_isa_init_ports() is that this is supposed
> >> to initialize exactly the ports in the old_serial_port[]
> >> array, which is filled only on alpha, m68k and x86 but not
> >> on the other ones.
> >
> >> Andy moved this code in ffd8e8bd26e9 ("serial: 8250: Extract
> >> platform driver"), but I don't think this move by itself
> >> changed anything.
> >
> > Yep. the idea was to purely split this code out of the core
> > library parts. I was not intending any functional changes.
> 
> Ok.
> 
> > I believe it's a preexisted bug, but if you can point out to
> > the breakage I made, please do it, so I would be able to fix
> > ASAP.
> >
> >> serial8250_setup_port() is where it ends up using the
> >> uninitialized serial8250_ports[index] contents. Since 
> >> port->iotype is not set to anything here, it defaults to
> >> '0', which happens to be UPIO_PORT.
> >
> > Btw, we have a new constant to tell the 8250 core that IO type is not set,
> > but that one is not used here.
> 
> So I see serial8250_setup_port() setting "up->cur_iotype = 0xFF"
> by first calling serial8250_init_port(), this is the "not
> set" value you mean, right?.

Yes, and we have a constant for that, I'll send a patch to make it clear.

> Right after that it calls serial8250_set_defaults(),
> which sets "up->cur_iotype = p->iotype;", which may or
> may not be initialized here.
> 
> The possible calls chains I see leading up to
> serial8250_setup_port() are:
> 
> serial8250_register_8250_port(): here we first initialize
>   the iotype incorrectly, then set uart->port.iotype and
>   call serial8250_set_defaults() again to fix it.
> 
> module_init(serial8250_init): relies on the first
>   serial8250_set_defaults() for the ISA ports since they
>   are always UPIO_PORT, but sets the other ones (pnp, acpi,
>   platform_data) correctly.
> 
> early_serial_setup(): called only on non-ISA platforms,
>   shouldn't need to call serial8250_isa_init_ports() at
>   all.
> 
> console_initcall(univ8250_console_init): Not completely
>   sure here, it seems this now only allows ports that
>   are registered from one of the methods above
> 
> Can you have a look at the patch below? I think this
> correctly removes the broken serial8250_set_defaults()
> while also still adding it in the one case that relies
> on the implied version.
> 
> This does however revert f4c23a140d80 ("serial: 8250:
> fix null-ptr-deref in serial8250_start_tx()") and
> might bring back the bug came from opening an
> uninitialized uart. On the other hand, I don't see
> why that doesn't also crash from accessing the invalid
> I/O port on the same architectures.

AFAICS it does only partial revert, so I don't see how your patch
may break that.

> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 5f9f06911795..5b72309611cb 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -358,8 +358,6 @@ struct uart_8250_port *serial8250_setup_port(int index)
>  
>  	up->ops = &univ8250_driver_ops;
>  
> -	serial8250_set_defaults(up);
> -
>  	return up;
>  }
>  
> diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
> index 66fd6d5d4835..d3c1668add58 100644
> --- a/drivers/tty/serial/8250/8250_platform.c
> +++ b/drivers/tty/serial/8250/8250_platform.c
> @@ -94,6 +94,10 @@ static void __init __serial8250_isa_init_ports(void)
>  		port->regshift = old_serial_port[i].iomem_reg_shift;
>  
>  		port->irqflags |= irqflag;
> +
> +		serial8250_set_defaults(port);
> +
> +		/* Allow Intel CE4100 and jailhouse to override defaults */
>  		if (serial8250_isa_config != NULL)
>  			serial8250_isa_config(i, &up->port, &up->capabilities);
>  	}

-- 
With Best Regards,
Andy Shevchenko


