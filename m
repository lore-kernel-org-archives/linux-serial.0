Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C884314AD2D;
	Mon, 25 Nov 2024 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732521326; cv=none; b=Zb5HjclqgSntot/t4tMqblQsTew+Hi7PUmqaf9kelMrIVBRkxiaJ5RSwpr2e7w5Rlq+y3KNFoBUPdemo61VGzmKSqvs2k5BSyaDan/Nv8c3Zbd26jkaEt8jt6k+I/F/v1OreyYkiX0U9YH7NjQoHZScFYzYgy3CvGXEy5dyDRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732521326; c=relaxed/simple;
	bh=uBnYP9aE7Pwete/XjL4x75AnL05KyLv2gT61TgDIibA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDlWs2QpQDDUQoik1vgsyRCZ5JEjnQm8NhrhavFMhhGBaA69JwvJYE/P4RAHrZhry0/l0ZsMaaOZtf9JeOiiOwMIDUQv0ZFUkRKhfs+fdWEz6aeQr8FyM1K8Jp6NtuNCJF1Y7LmTnVsOxl4GujX1rz8n/GQgy259MRmSc9m7aIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQN5k0AQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQN5k0AQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732521325; x=1764057325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uBnYP9aE7Pwete/XjL4x75AnL05KyLv2gT61TgDIibA=;
  b=nQN5k0AQ/e+yNJGNU0Li2hXLgj/U8aCpTdV39uD1C2+HLwnDpeI4+TNB
   V+9jNSrEU2a6AVXpWY+5nNkfPW0Qf8551X9IMMzFtLMIBoG7umBIzdA5S
   ltZWnRtT7oZtVkxIrceBIprRf7P6N+qQPukBoif7FKZwgoduQ8jDmekYq
   i2jYAgKm1gDgrTtPsfOLzX35783eAN1p+F8mpVIwAWqQ8Y2men/LeR7Ho
   KaeC5FzUMLidLTxDOpMY5lAYquRPvrDbkTe+L0hKA95hPD7GfQUpzPtiN
   cePN/BzvvWH3lfJHXSbDS7zaN/itDnt3+qOcEXJnJ9X7gyVkdukpeOImP
   Q==;
X-CSE-ConnectionGUID: CpcRRbEsTA+t4CDiAR/HBw==
X-CSE-MsgGUID: rJX6nPpxT0KfDHfQh3n6IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="58021005"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="58021005"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2024 23:55:24 -0800
X-CSE-ConnectionGUID: IO1jN5scSR+/Y7f5z3vpNg==
X-CSE-MsgGUID: j0FxLA7KQS2tRcBAchBuVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="96109231"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2024 23:55:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tFTwE-00000000fsL-3O9s;
	Mon, 25 Nov 2024 09:55:18 +0200
Date: Mon, 25 Nov 2024 09:55:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Message-ID: <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
 <20240405152924.252598-2-schnelle@linux.ibm.com>
 <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 22, 2024 at 08:24:37PM +0100, Arnd Bergmann wrote:
> On Fri, Nov 22, 2024, at 18:22, Guenter Roeck wrote:
> > On 11/22/24 08:31, Arnd Bergmann wrote:
> >> On Fri, Nov 22, 2024, at 16:35, Niklas Schnelle wrote:
> >>> On Fri, 2024-11-22 at 07:18 -0800, Guenter Roeck wrote:

...

> >> So in all four cases, the normal uart should keep working,
> >> and if something tried to start up an ISA style 8250, I
> >> would expect to see the new version produce the WARN()
> >> in place of what was a NULL pointer dereference (reading
> >> from (u8 *)0x2f8) before.
> >> 
> >> Since there are so many ways to set up a broken 8250,
> >> it is still possible that something tries to add another
> >> UPIO_PORT uart, and that this causes the WARN() to trigger,
> >> if we find any of those, the fix is to no stop registering
> >> broken ports.
> >
> > The call chain in all cases is
> >
> > [    0.013596] Call Trace:
> > [    0.013796]  [<d06eb249>] dump_stack+0x9/0xc
> > [    0.014115]  [<d000c12c>] __warn+0x94/0xbc
> > [    0.014332]  [<d000c29c>] warn_slowpath_fmt+0x148/0x184
> > [    0.014560]  [<d04f03d8>] set_io_from_upio+0x70/0x98
> > [    0.014781]  [<d04f0459>] serial8250_set_defaults+0x59/0x8c
> > [    0.015013]  [<d04efa6a>] serial8250_setup_port+0x6e/0x90
> > [    0.015240]  [<d0ae2a12>] serial8250_isa_init_ports+0x32/0x5c
> > [    0.015473]  [<d0ae28a1>] univ8250_console_init+0x15/0x24
> > [    0.015698]  [<d0ad0684>] console_init+0x18/0x20
> > [    0.015926]  [<d0acbf43>] start_kernel+0x3db/0x4cc
> > [    0.016145]  [<d06ebc37>] _startup+0x13b/0x13b
> >
> > That seems unconditional. What is the architecture expected to do to
> > prevent this call chain from being executed ?
> 
> This looks like a bug in drivers/tty/serial/8250/8250_platform.c
> to me, not something the architectures did wrong. My impression
> from __serial8250_isa_init_ports() is that this is supposed
> to initialize exactly the ports in the old_serial_port[]
> array, which is filled only on alpha, m68k and x86 but not
> on the other ones.

> Andy moved this code in ffd8e8bd26e9 ("serial: 8250: Extract
> platform driver"), but I don't think this move by itself
> changed anything.

Yep. the idea was to purely split this code out of the core
library parts. I was not intending any functional changes.

I believe it's a preexisted bug, but if you can point out to
the breakage I made, please do it, so I would be able to fix
ASAP.

> serial8250_setup_port() is where it ends up using the
> uninitialized serial8250_ports[index] contents. Since 
> port->iotype is not set to anything here, it defaults to
> '0', which happens to be UPIO_PORT.

Btw, we have a new constant to tell the 8250 core that IO type is not set,
but that one is not used here.

> The reason it doesn't immediately crash and burn is that
> this is still only setting up the structures for later
> use, but I assume that trying to use console=ttyS0, or
> opening /dev/ttyS0 on the uninitialized port would
> then cause an oops.
> 
> The bit I'm less sure about is why the
> serial8250_setup_port() function is called here in
> the first place. I assume it does something for
> /some/ architecture, but it's clearly wrong for
> most of them.

-- 
With Best Regards,
Andy Shevchenko


