Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC00C390205;
	Mon,  4 May 2026 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777895092; cv=none; b=c5Cokjie519OgfAe01ZC8pFALE+sqq6O8YcGWYsNVc/FLyjP50fBXYSzFkn/Sb0gy64D3CMgh+PcPUuK7xVB/g/ANbi+0G/osKvVaTRdLvFXX/SG7lQCGoh8hQojSzYxokLTydsUmLteRn/d32dWBPTxiii62sifgaLogNNK1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777895092; c=relaxed/simple;
	bh=pk3NyvDbKX4N0pNg2pyS+FOHFuOHEEy7zncB8qtcyzU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nGaeT1alRAt6cr1nctKvJMy8BLgN4rCNQZEZzeo1Pm146QtkK7X7LOYF+lmWH0P+943mP1HwLcjTEYx7UT9CpyhpjmX9cMuQYiTClHYBkf4JCus/Xr0ESIzciv2Q9yEdnhozotLkg1jtyVdOw1yc7Dvm/PvSZc0g2YU9K6RrUoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 179F192009C; Mon,  4 May 2026 13:44:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 10D9492009B;
	Mon,  4 May 2026 12:44:42 +0100 (BST)
Date: Mon, 4 May 2026 12:44:41 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
cc: Hugo Villeneuve <hugo@hugovil.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v2 02/15] serial: core: add uart_iotype_mmio/legacy_io
 helper functions
In-Reply-To: <afhdTI_jAQrIsPSZ@ashevche-desk.local>
Message-ID: <alpine.DEB.2.21.2605041220540.23161@angie.orcam.me.uk>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com> <20260428-tty-upio-v2-2-01c1857cf761@dimonoff.com> <afNwaUf8esqaqxUe@black.igk.intel.com> <alpine.DEB.2.21.2605030016120.23161@angie.orcam.me.uk> <afhdTI_jAQrIsPSZ@ashevche-desk.local>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 4 May 2026, Andy Shevchenko wrote:

> > > Why do we use 'legacy'? Still in use in modern CPUs...
> > 
> >  Deprecated in PCIe and not available in numerous systems.  Also actually 
> > called "legacy" in some serial port datasheets aged ~20 years now.  While 
> > some contemporary CPUs indeed retain the port I/O address space, it's for 
> > legacy use anyway, you don't want to rely on it in new designs.
> 
> For the holder of the new (modern) CPU which supports the IO ports, this is
> definitely not a legacy interface despite on whatever PCIe or other datasheets
> call it.

 I appreciate your point of view, however I disagree that the presence of 
an interface in a contemporary chip makes the interface modern.

 I see the port I/O space so much legacy as say the PC/AT DMA controller 
(8237 pair), which is similarly present in current x86 chipsets.  If this 
stuff was not present, such as say the PC/AT interrupt controller (8259A 
pair), which I believe has been removed from some x86 system designs, then 
it would be obsolete/removed rather than legacy.

 It is analogous to PCI/e systems that lack a southbridge and are called 
"legacy-free", as the whole southbridge stuff, the main consumer of the 
port I/O space still remaining in use, is legacy nowadays (the other one I 
know of being the 8255-based PC parallel port, which has been considered a 
legacy interface as well, even though you can still buy and plug one into 
a modern PCIe system).

 NB I have a couple of modern x86 CPUs around too that support the port 
I/O space, but it doesn't change my view as to the nomenclature.

 FWIW,

  Maciej
