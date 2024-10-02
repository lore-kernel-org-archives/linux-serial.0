Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B55A1CF7C0;
	Wed,  2 Oct 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727892772; cv=none; b=CAA3qkYwpgjWHtO3FxaPrNK4PSrvu5ZpNbYs0q1bd5lRs8o97PaLZfYCaWbBs7MJDYfbD3kyltjODX0Noc5yzNkpglFo3AgC/35blcu5AXgXs93szLtlmL/04DnwHLEBi/3/NBGPcNNzfrW9RpWeKFUVG7i1tQKYg2YkhPqyj2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727892772; c=relaxed/simple;
	bh=5aO6wBqRhiaYXWNAw/nDaGQwzXhDuOmPzvaXcnjdj7I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nUbUG03Lw0B5k/BSlivSWwPgJhjbnq794Va+ZyZlQlQQAgwTYGyNDGukCbGafSLFxSbubqetx0T3iO3Hr+/ORuWk4nffWjYI6dYusPOpei6Et1fjzc5dBZFdj/NcWhklryBQs1Ktr19YfDB+EI6ak0RWAtl0B7kPZBee8PYfhIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 88E8492009C; Wed,  2 Oct 2024 20:12:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8290192009B;
	Wed,  2 Oct 2024 19:12:41 +0100 (BST)
Date: Wed, 2 Oct 2024 19:12:41 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Niklas Schnelle <schnelle@linux.ibm.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-serial@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, 
    Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
In-Reply-To: <7bcec0eb88c3891d23f5c9f224e708e4a9bb8b89.camel@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2410021632150.45128@angie.orcam.me.uk>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>   <20240405152924.252598-2-schnelle@linux.ibm.com>   <alpine.DEB.2.21.2405230244140.1257@angie.orcam.me.uk>  <ef2912910d006c573324bcf063cb76e843dc8267.camel@linux.ibm.com> 
 <alpine.DEB.2.21.2410011707550.45128@angie.orcam.me.uk> <7bcec0eb88c3891d23f5c9f224e708e4a9bb8b89.camel@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 2 Oct 2024, Niklas Schnelle wrote:

> >  Ideally we could come with a slightly user-friendlier change that would 
> > report the inability to handle port I/O devices as they are discovered 
> > rather than just silently ignoring them.
> 
> I think this would generally get quite ugly as one would have to keep
> around enough of the drivers which can't possibly work in that
> !HAS_IOPORT kernel to identify the device and print some error. It's
> also not what happens when anything else isn't supported by your kernel
> build. And I don't think we can just look for any I/O ports either
> because they could be an alternative access method that isn't required.

 There might be corner cases, but offhand I think it's simpler than you 
outline.  There are two cases to handle here:

1. Code you've #ifdef'd out that explicitly refers port I/O resources.
   So rather than having struct entries referring to problematic `*_init' 
   handlers #ifdef'd out we can keep them and make them call an error 
   reporting function if (!IS_ENABLED(CONFIG_HAS_IOPORT)).  As a side 
   effect the structure of code will improve as we don't really like 
   #ifdefs sprinkled throughout.

2. Code that infers the access type required from BARs.  It has to handle 
   the unsupported case anyway, so rather than doing it silently it can 
   call the same error reporting function.

Yes, there's some work to be done here, but nothing exceedingly tough I 
believe.

 Also I think this case is a bit special, because it's different from a 
missing driver.  The driver is there and the hardware is there visible in 
the PCI hierarchy, there's nothing reported and other serial ports work, 
or a similar serial port works elsewhere, so why doesn't this one?  The 
user may not necessarily be aware of the peculiarity that the lack of 
support for port I/O is.

 I was not and discovered it the hard way in the course of installing my 
POWER9 system and trying to make the defxx driver work as supplied by the 
distribution.  It took me a few days to conclude there is no bug anywhere 
except for the system lacking support for port I/O and the driver having 
been configured by the packager via a Kconfig option to use that access 
type.  Also I had PHB4 documentation to hand to refer to and track down 
the relevant bits.

 I ended up updating the driver to choose the access type automatically 
(as the board resources are dual-mapped, via both a port I/O and an MMIO 
BAR), and would have done so long before if I was aware of the existence 
of such systems.

 Now I consider myself a reasonably seasoned systems software developer, 
so what can an ordinary user say?  They might be utterly confused and 
either report it as a system bug (if they were so determined) or just 
conclude Linux is junk.

 A message such as:

serial 0001:01:00.0: cannot handle, no port I/O support in the system

would definitely help.

> As an example for the ugliness, for 8250 one could get something to
> work as it supports both I/O port and MMIO devices. First one would
> need to not #ifdef the setup routines and keep the quirk entry for
> devices that use UPIO_PORT and then in pciserial_init_ports() one could
> check with !IS_ENABLED(CONFIG_HAS_IOPORT) && uart.port.iotype ==
> UPIO_PORT. But then for moxa one would have to keep pci_moxa_setup() to
> set iotype = UPIO_PORT but would have to #ifdef in pci_moxa_init()
> because the initialization already uses I/O ports and init is part of
> the quirk.

 I don't think it has to be as complex as that.  The OxSemi Tornado driver 
which I care about a lot is an example of one that handles hardware that 
can be strapped for either access type (and I have cards with actual pin 
header jumpers and associated documentation for the user to configure 
that), so you only know at run time from the type of BAR 0 whether you 
need port I/O or MMIO.  So it falls into #2 above, and all you need is to 
handle this in `serial8250_pci_setup_port', which I can see your change 
doesn't take into account anyway, whether silently or aloud.

> I think allowing for such custom configs is a possible second step and
> I agree it would be nice and probably becomes more useful as more and
> more platforms lose I/O port support. First we need to be able to build
> without HAS_IOPORT on architectures that just can't do I/O port access
> though, and I'd like not delay this any more.

 I agree it will best be done in steps, no worry.

  Maciej
