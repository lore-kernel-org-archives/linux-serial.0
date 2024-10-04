Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561C91E3788;
	Fri,  4 Oct 2024 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059685; cv=none; b=qLMGJAe6EV/wRlBOfDWxNuhUMtzEo2fRA8nae2Co3YpcD9S4xeI8tZJ4GKA9vNPMGj7xspmXzDBzMqhV4XoePef2dfs7/01IamKyfuLwVCJOuDrOTO2wPqD4IgM2rdPuBqRSivtUc28znuRBGSpFy9KZdul1tftY7ETdxliduR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059685; c=relaxed/simple;
	bh=DXfqLtojgOGdnHjDIg1o7iT3bk15C/Tdn7zgEf0kHIU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R2/E8zaxccqPC77Y+wVigWjnPPvpg2aRFG+r5+7zrjv1a7I4RWEDvOy35w5KpjCNWr1Kqh+nRnH5VnxgQWBENw87fQ7jJOlB5mEqYkR4hGu5Tu6NzBHXD+OFK4Fk8w6x3/SN5PIbjI7pUSg8YeXCFEPat4Trp1XuuRF2xKKeyRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id B54FE92009C; Fri,  4 Oct 2024 18:34:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id AE6AF92009B;
	Fri,  4 Oct 2024 17:34:41 +0100 (BST)
Date: Fri, 4 Oct 2024 17:34:41 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Niklas Schnelle <schnelle@linux.ibm.com>
cc: Arnd Bergmann <arnd@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-serial@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
In-Reply-To: <e916ff3347cef88981d8e519fe1bcedfabfbea24.camel@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2410041724450.45128@angie.orcam.me.uk>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>  <20240405152924.252598-2-schnelle@linux.ibm.com>  <alpine.DEB.2.21.2405230244140.1257@angie.orcam.me.uk>  <ef2912910d006c573324bcf063cb76e843dc8267.camel@linux.ibm.com> 
 <alpine.DEB.2.21.2410011707550.45128@angie.orcam.me.uk>  <7bcec0eb88c3891d23f5c9f224e708e4a9bb8b89.camel@linux.ibm.com>  <alpine.DEB.2.21.2410021632150.45128@angie.orcam.me.uk>  <84bbda13-ded1-4ada-a765-9d012d3f4abd@app.fastmail.com> 
 <alpine.DEB.2.21.2410022305040.45128@angie.orcam.me.uk> <e916ff3347cef88981d8e519fe1bcedfabfbea24.camel@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 4 Oct 2024, Niklas Schnelle wrote:

> >  Can we just provide dummy prototypes with `__attribute__((error("...")))' 
> > instead?  This will surely prevent us from having to bend backwards so as 
> > to make sure the compiler won't see any spurious references to these 
> > inexistent functions or macros.  We already have a `__compiletime_error()' 
> > macro for this purpose even.
> 
> This is already done in the final patch of my series when disabling
> inb()/outb() and friends.

 Good!

> >  I agree.  Enthusiastically.
> 
> I think there was also a bit of a misunderstanding. My argument that
> this would be very ugly in the general case was really meant as general
> case outside of drivers like 8250 that deals with both I/O port and
> MMIO i.e. we can't warn/error when !HAS_IOPORT deactivates a whole
> driver because seeing an I/O port BAR in common PCI code doesn't mean
> that it is required for use of the device.

 Absolutely.  Just seeing an I/O bar does not mean it's ever going to be 
used.  Even conventional PCI hardware is often dual-mapped and it's up to 
the driver to choose which mapping to use.

> I'm working on a new proposal for 8250 now. Basically I think we can
> put the warning/error in serial8250_pci_setup_port(). And then for
> those 8250_pci.c "sub drivers" that require I/O ports instead of just
> ifdeffing out their setup/init/exit we can define anything but setup to
> NULL and setup to pci_default_setup() such that the latter will find
> the I/O port BAR via FL_GET_BASE() and subsequently cause the error
> print in serial8250_pci_setup_port(). It's admittedly a bit odd but it
> also keeps the #ifdefs to just around the code that wouldn't compile.

 I'd rather you did what Arnd example patch does and just made original 
handlers bail out right away unless IS_ENABLED(CONFIG_HAS_IOPORT).  I do 
hope it will make no #ifdef necessary in 8250_pci.c at all.

  Maciej
