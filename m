Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8711B87D1;
	Mon, 25 Nov 2024 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732560134; cv=none; b=TzESmE/hpc4GwVbVVZtfGfVnKYj2BASmhTMSTGj492Fqu4rITC+igykNgHrd64MRRxfoGQm9JMBln5VcooFkKFeMyphXQos8cagLsZTvlMoTbGhFWJmMUIDzV5ng95dn5xIZ9BJTUCjErbu10OXeC4EY0YKQqKttGl1uW7eJc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732560134; c=relaxed/simple;
	bh=dE96jZM7t+ilUzLQzwPnbdBszqCq/WutM2xvSHjMijw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TaKgDoGzI2yUUxDs4XjeR5Dw+bvF+R0Gy3dVt/1m9yUAdS5uwlls4iEbZCYhtHeR1UG/CGca7enwTI35LkyikRdlzRIz+Z+u0YNiSQ27mr+3EgGJCOxTBO5+jr1x0SOktDtQAhmS6vloVYxy1J9ZDyQKFHqIEvbrRU/FvNlU8c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id B0E2D92009C; Mon, 25 Nov 2024 19:42:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id AAC7892009B;
	Mon, 25 Nov 2024 18:42:09 +0000 (GMT)
Date: Mon, 25 Nov 2024 18:42:09 +0000 (GMT)
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
In-Reply-To: <42b1911e-c69b-4f5a-96f2-ab6d4353ea5c@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2411251820200.44939@angie.orcam.me.uk>
References: <20240405152924.252598-2-schnelle@linux.ibm.com> <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net> <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com> <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net> <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com> <Z0QtZky8Sr7qUW7v@smile.fi.intel.com> <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com> <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
 <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com> <Z0Re61Tk5lN2Xuxi@smile.fi.intel.com> <1a7da799-f15b-4714-a3bd-4c0b1f48fc09@app.fastmail.com> <alpine.DEB.2.21.2411251628320.44939@angie.orcam.me.uk>
 <42b1911e-c69b-4f5a-96f2-ab6d4353ea5c@app.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 25 Nov 2024, Arnd Bergmann wrote:

> >  May I suggest to call `serial8250_isa_init_ports':
> >
> > 	if (IS_ENABLED(CONFIG_ISA) || IS_ENABLED(CONFIG_ALPHA) ||
> > 	    IS_ENABLED(CONFIG_M68K) || IS_ENABLED(CONFIG_X86))
> >
> > then (or have an equivalent `select' in the relevant Kconfig files)?
> 
> Right, I think that makes sense, but I'm a little worried
> about renumbering or incorrectly configuring the uarts on
> a non-x86 system that might have ISA slots and also register
> a 8250 console.
> 
> E.g. on the RM200, two serial ports get registered on
> MMIO addresses:
> 
> arch/mips/sni/rm200.c:static struct serial8250_platform_data rm200_data[] = {
> arch/mips/sni/rm200.c-  MEMPORT(0x160003f8, RM200_I8259A_IRQ_BASE + 4),
> arch/mips/sni/rm200.c-  MEMPORT(0x160002f8, RM200_I8259A_IRQ_BASE + 3),
> arch/mips/sni/rm200.c-  { },
> arch/mips/sni/rm200.c-};
> 
> so these would become ports ttyS4 and ttyS5 if the first four
> ports get reserved for ISA cards, or disappear when using the
> default CONFIG_SERIAL_8250_NR_UARTS=4.

 I think it's still the correct thing to do or ISA card ports won't be 
accessible.  Then where there are platform ports, they ought to be given 
precedence so that they are given lower indices.  I'm undecided as to 
whether we actually need to get it sorted now or wait for someone with an 
RM200 system to trigger the problem (with the possible workarounds being:

1. Do not plug any ISA cards with serial ports.

2. Set CONFIG_SERIAL_8250_RUNTIME_UARTS or "8250.nr_uarts" to 0.

).  It might be quite easy to get sorted though, so I'd be leaning towards 
at least checking how feasible it would be.

  Maciej
