Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010411B3930;
	Mon, 25 Nov 2024 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554143; cv=none; b=KXOz57Y3XQS8S866AIaiThujShrbLrQwqxRhpl14AwxJBsdasbtlnCVS6cu4KH8emwMz08GgJNUbrzdqWDfUOX/TTe1+n9tJmrcI+nWdPpUCaCcSvEL/PYixQGuKHuERttDH/XyTINFOCdvYY1O14q0JigTV6S2zVCqYVx3akzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554143; c=relaxed/simple;
	bh=4/SIKWMo3PgwM8oMuJ2GgHkJIaJAXvE90KQc+A/BcBc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kaX5/SxTW/Oeu6al++Yry8sX0vSn6Zvy/65ZD+XGX4Ee8dDvgh6mZNpfwMmvjJbJdM6ldvgL6TRQwcsoOhAyM/T1OSEfS4YFsj+nqwmiYwrF2oTjzmbiu8ZnNIKlpOK6imUBkpk7/vjeVfO8ecSA6PbxF34a+NK+Xv9Wm1BsBGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id DEA8A92009C; Mon, 25 Nov 2024 17:54:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id DA07C92009B;
	Mon, 25 Nov 2024 16:54:11 +0000 (GMT)
Date: Mon, 25 Nov 2024 16:54:11 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Arnd Bergmann <arnd@kernel.org>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Guenter Roeck <linux@roeck-us.net>, 
    Niklas Schnelle <schnelle@linux.ibm.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-serial@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
    linux-kernel@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
In-Reply-To: <1a7da799-f15b-4714-a3bd-4c0b1f48fc09@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2411251628320.44939@angie.orcam.me.uk>
References: <20240405152924.252598-2-schnelle@linux.ibm.com> <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net> <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com> <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net> <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com> <Z0QtZky8Sr7qUW7v@smile.fi.intel.com> <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com> <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
 <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com> <Z0Re61Tk5lN2Xuxi@smile.fi.intel.com> <1a7da799-f15b-4714-a3bd-4c0b1f48fc09@app.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 25 Nov 2024, Arnd Bergmann wrote:

> > But the configuration can give less than old_serial_port contains.
> > See dozens of the explicit settings in the defconfigs.
> 
> I don't see any of the upstream defconfigs doing this
> though, the only ones setting CONFIG_SERIAL_8250_RUNTIME_UARTS
> are those that have an empty old_serial_port[]. 
> 
> Note that SERIAL_PORT_DFNS is only defined on x86, alpha
> and m68k (for q40), which are the main PC-like platforms.

 May I suggest to call `serial8250_isa_init_ports':

	if (IS_ENABLED(CONFIG_ISA) || IS_ENABLED(CONFIG_ALPHA) ||
	    IS_ENABLED(CONFIG_M68K) || IS_ENABLED(CONFIG_X86))

then (or have an equivalent `select' in the relevant Kconfig files)?

 The whole point of this legacy setup is to poke at ISA serial ports that 
have been wired by jumpers or similar means (sometimes just hardwired) to 
their designated ISA port I/O locations.  Sometimes it means LPC rather 
than real ISA, but LPC stuff should mostly be covered by platform bindings 
rather than just blind poking, which may only be needed for platforms that 
have some kind of a generic config and no DT or other way (such as ACPI or 
ISA PNP) to discover actual ports.

> I see that all three have identical definitions of
> SERIAL_PORT_DFNS, so I think these should just be moved
> next to the __serial8250_isa_init_ports definition, with
> the entire thing moved into a separate ISA driver or
> an #ifdef around it. This is of course not the problem
> at hand, but it would help separate the x86/isa and
> non-x86 platform device cases further.

 This SERIAL_PORT_DFNS definition is just original ISA stuff, so it does 
apply universally across CONFIG_ISA platforms.  Original ISA option cards 
have had no way to discover other than by blind-poking (or giving port I/O 
locations by hand via a kernel parameter).

  Maciej
