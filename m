Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670EE1C75E4;
	Fri,  4 Oct 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059051; cv=none; b=en2hEHwvTcC0RE6DynxsCLxFuBozYAC3jbkER+dBmtBmz8+YMkfIBp+Vu6gpGbYTqb3rl6xUHDv4Rpe4ZZtPIRpmm6wZc0QTiq25GN1OlhULXKTiYt6SyI6iPkr+YANbeAr8TdoMTKqsdfP1lE/8Q1p5aWnejXbT8iKS8RRsijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059051; c=relaxed/simple;
	bh=MIXwu4c46lO6pDES3z40SL2p1LX6813TKrzziANSpO4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=miBlHO8xZ4XJk/HphM8nlVEd8fKH3RYd/lwchE1yFNWT81iO4YMPg633dqKQB/pbcDFaVRnTkiws/C0mssS0wawO+l2s8AHOLAS+lBXSt9NFTWHJaoTr1dSXduIKuGLsZi5Oi6ZXDcqVpV/HN7qaObmNhn2lGyIBScaRTT0ahDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 0A92992009C; Fri,  4 Oct 2024 18:24:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 0673C92009B;
	Fri,  4 Oct 2024 17:24:01 +0100 (BST)
Date: Fri, 4 Oct 2024 17:24:00 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Arnd Bergmann <arnd@kernel.org>
cc: Niklas Schnelle <schnelle@linux.ibm.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-serial@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
In-Reply-To: <b59d81ee-04af-4557-9d35-ec2c03fbcbe7@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2410041642140.45128@angie.orcam.me.uk>
References: <20240405152924.252598-1-schnelle@linux.ibm.com> <20240405152924.252598-2-schnelle@linux.ibm.com> <alpine.DEB.2.21.2405230244140.1257@angie.orcam.me.uk> <ef2912910d006c573324bcf063cb76e843dc8267.camel@linux.ibm.com> <alpine.DEB.2.21.2410011707550.45128@angie.orcam.me.uk>
 <7bcec0eb88c3891d23f5c9f224e708e4a9bb8b89.camel@linux.ibm.com> <alpine.DEB.2.21.2410021632150.45128@angie.orcam.me.uk> <84bbda13-ded1-4ada-a765-9d012d3f4abd@app.fastmail.com> <alpine.DEB.2.21.2410022305040.45128@angie.orcam.me.uk>
 <b59d81ee-04af-4557-9d35-ec2c03fbcbe7@app.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 4 Oct 2024, Arnd Bergmann wrote:

> >  It can be worse than that.  Part of my confusion with the defxx driver 
> > trying to do port I/O with my POWER9 system came from the mapping actually 
> > resulting in non-NULL invalid pointers, dereferencing which caused a flood 
> > of obscure messages produced to the system console by the system firmware:
> >
> > LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
> > IPMI: dropping non severe PEL event
> > LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
> > IPMI: dropping non severe PEL event
> > LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
> > IPMI: dropping non severe PEL event
> > LPC[000]: Got SYNC no-response error. Error address reg: 0xd0010014
> > IPMI: dropping non severe PEL event
> > [...]
> >
> > from which it was all but obvious that they were caused by an attempt to 
> > use PCI port I/O with a system lacking support for it.
> 
> Ah, that's too bad. I think this is a result of the patch that
> Michael did to shut up the NULL pointer warning we get, see
> be140f1732b5 ("powerpc/64: Set _IO_BASE to POISON_POINTER_DELTA
> not 0 for CONFIG_PCI=n"). I really wish we could have finished
> Niklas' series earlier to avoid this.

 That was back in 2020 (5.9.0), so long before be140f1732b5, and it's a 
production system, so I don't want to fiddle with it beyond necessity:

$ uptime
 16:53:27 up 466 days,  9:49,  5 users,  load average: 0.14, 0.12, 0.09
$ 

 Essentially defxx has this code (not changed much since, except that 
`dfx_use_mmio' is now always true for PCI):

	if (!dfx_use_mmio)
		region = request_region(bar_start[0], bar_len[0],
					bdev->driver->name);
	if (!region) {
		dfx_register_res_err(print_name, dfx_use_mmio,
				     bar_start[0], bar_len[0]);
		err = -EBUSY;
		goto err_out_disable;
	}
	/* ... */
	if (dfx_use_mmio) {
		/* ... */
	} else {
		bp->base.port = bar_start[0];
		dev->base_addr = bar_start[0];
	}

so whatever came out of BAR[1]:

pci 0031:02:04.0: [1011:000f] type 00 class 0x020200
pci 0031:02:04.0: reg 0x10: [mem 0x620c080020000-0x620c08002007f]
pci 0031:02:04.0: reg 0x14: [io  0x0000-0x007f]
pci 0031:02:04.0: reg 0x18: [mem 0x620c080030000-0x620c08003ffff]
pci 0031:02:04.0: BAR0 [mem size 0x00000080]: requesting alignment to 0x10000

was supplied to `inl'/`outl' and wreaked havoc.

 First of all I think `request_region', etc. ought to fail in the first 
place with non-port-I/O systems: why does a request for a resource that 
cannot be satisfied succeed?  It would have already solved the issue with 
defxx, making the driver gracefully fail to register the device.  I don't 
know if this has been fixed since.

 Second, rather than relying on a magic mapping in the physical space 
causing a bus error (unless you are absolutely sure it is going to work in 
100% cases), I think it would make sense to make port I/O accessors call 
BUG_ON(no_port_io) explicitly for platforms where it is only known at run 
time whether PCI/e port I/O is available or not.  Port I/O is the opposite 
of performance already, so a couple of extra instructions will be lost in 
the latency and at least POWER has conditional traps, so there'd be no 
branch penalty.

> >  Well, virtually all non-x86 systems continue supporting PCI/e port I/O 
> > via a suitably decoded CPU-side MMIO window, so I think coming across one 
> > that doesn't can still be a nasty surprise even in 2024.  For instance 
> > I've been happily using a PC parallel port PCIe option card, one of the 
> > very few interfaces if not the only one remaining that have not ever seen 
> > an MMIO variant, with my RISC-V hardware, newer than said POWER9 system.
> >
> >  So far it's been the s390 and a couple of POWER system implementations 
> > that have support for PCI/e port I/O removed.  Have I missed anything?
> 
> I meant PCIe cards with I/O space here, not host bridges. I know you
> have a lot of them, but what I've heard from Arm platform maintainers
> is that they tend to struggle finding any PCIe cards to test their
> hsot bridge drivers on, and I expect that a lot of them are actually
> broken because they have never been tested and just copied the
> implementation badly from some other driver.

 I would expect serial ports to be the most common PCIe options still 
using port I/O.  Sadly OxSemi was acquired and their line of devices, 
which support MMIO, cancelled at one point and my observations seem to 
indicate that what is still manufactured uses port I/O (correct me if I'm 
wrong please).  Last time I checked OxSemi-based option cards were still 
available though, but one may have to check with the supplier as to 
whether they have been configured for MMIO or port I/O, as they're not 
dual-mapped.

> I think the only new PCIe devices you can find today that still use
> I/O space are ones with compatibility registers for IBM PC style
> hardware (vga, uart, parport), but most users would never have used
> one of those and instead use the native register interface of their
> GPU (on non-x86), USB-serial and no parport. Other devices that
> needed I/O space never worked on PCIe anyway because of the lack
> of ISA style DMA.

 I think serial port options are the most likely devices still in use, 
given that UARTs continue being widely used in industrial applications.  
Depending on application a USB serial adapter may or may not be suitable 
to interface those.

> There are also a lot of Arm systems that have no I/O space support at
> all, such as the Apple M2 I'm using at the moment.

 Thanks for letting me know.  Is it AArch64 only that has no port I/O 
support in the PCIe root complex nowadays, or is it 32-bit ARM as well?

  Maciej
