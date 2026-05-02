Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486FB186A;
	Sat,  2 May 2026 23:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777764335; cv=none; b=qsyIBcD2cJ4fiw6NkFLVSfgyxp/hDoGemPOWNIw9p3nzF4hH/IDJrHGLYmI7ppcX0GoHfKQ9pNwQm/PFEgjNKBe8NO2zCefRvpl8hjn4+YUYQFOBd209hG0dIyKF7ErMiS4FfzhzGK+w64BuDmbZulbvLwrFa98dLBBLs3ufzok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777764335; c=relaxed/simple;
	bh=BtGJHLc/sdX4KcIKThLgGMBHggOMZicwbiKvxUugyxc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rWJnmzms+IWQUIpRm3qzYNyRMt37QIJVQNkjoSpvlJuEUfOfOX2DsXW7NgTKkvfckMEhtdqiL6m1YO4VGdWyA2XiM7iMxeLOpKvrdzzLHdx9GhqRYNWkq2w2sE6sU+iJK3PSoRfdNWYqB41Z85LpS/2hNibftEK1kYev6kM7wbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id A2D0592009C; Sun,  3 May 2026 01:25:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 95F3092009B;
	Sun,  3 May 2026 00:25:24 +0100 (BST)
Date: Sun, 3 May 2026 00:25:24 +0100 (BST)
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
In-Reply-To: <afNwaUf8esqaqxUe@black.igk.intel.com>
Message-ID: <alpine.DEB.2.21.2605030016120.23161@angie.orcam.me.uk>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com> <20260428-tty-upio-v2-2-01c1857cf761@dimonoff.com> <afNwaUf8esqaqxUe@black.igk.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Apr 2026, Andy Shevchenko wrote:

> > +bool uart_iotype_legacy_io(enum uart_iotype iotype)
> 
> Why do we use 'legacy'? Still in use in modern CPUs...

 Deprecated in PCIe and not available in numerous systems.  Also actually 
called "legacy" in some serial port datasheets aged ~20 years now.  While 
some contemporary CPUs indeed retain the port I/O address space, it's for 
legacy use anyway, you don't want to rely on it in new designs.

  Maciej
