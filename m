Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB1731BCAE;
	Mon, 19 Oct 2026 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792397583; cv=none; b=K1DjfI0AIXaWRgSR14SupLt1gnuxNXw6VUlKpE0NYZuLAEl2Gl9DidtNtDxXTIzEd5xcN8hsu+GqX4/eB4ZzTLCID66SePu3cyMOTm1Pqer71Hj3VTeoZCosaQzC4n/4+76itpYy7GxQSIostbMGw0mUOgEV1NuCPcMUFEaUZDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792397583; c=relaxed/simple;
	bh=OpxKsY4pQMxWXG5ginCdqOe1JmpLsqB7ew68KaUuqRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Esqrnj6Ld/ieVI+uBhNBstAGrNtGr50MpvVox9iNB7cvhiK6/P0Li3OBYDk/JmGNcv2DZZ7G/ECL23fxTlDLspdKIE140gOx3pqGU6d3c7d0nUV73Nl9wpwNAZCulY8Bhde+CWHsZn+iXsa1RpsG8ualqFDyTds48LPVVeLcynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XXTCDZYX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XXTCDZYX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792397582; x=1823933582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OpxKsY4pQMxWXG5ginCdqOe1JmpLsqB7ew68KaUuqRc=;
  b=XXTCDZYXha3HqT+9obAKYtYl3pTW5g7LnPV1oa1tX8HdATBXSqukjizS
   MbUPcWiP7bXmcuw8ujft0Ly/mMun1TSWv3p5qfTSH/kq5ML2ZV4zhQt+Z
   oicwDcThMIrgXaljbiEiQBqCwZXkxMws8DBlQVwFV+20GT+C4FdOUJ6Rt
   NuBrqU1xtPV7y+20dXXysEO0198pZLPNGPMrSSE/gqm2ukoJwqSgOBPl3
   sgVMP1LJRpkdrT0OLBzVMnmED0MLon+7wvq6GKw5aT7E/WfqHSiXWlHYM
   r1ScK9xhHTUPaJ8EV/tHEFv1qwS0/gce6h1c3+f1t6hltz/NvwkKZh2Cl
   g==;
X-CSE-ConnectionGUID: T/ffCH2NTgW7lNsaODwwPg==
X-CSE-MsgGUID: IqLLKAyFQmOqEbnAMghL1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="944080"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="944080"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:13:02 -0700
X-CSE-ConnectionGUID: P7yLX90wTAyjhQhKT6K14g==
X-CSE-MsgGUID: J7SAvJEoR5mx5tic2JqxOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4321776"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 01:12:59 -0700
Date: Mon, 19 Oct 2026 11:12:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/2] tty: serial: remove hub6 multiport support
Message-ID: <atXRCJjQGcSKZ_X3@ashevche-desk.local>
References: <20261016130328.1037616-1-arnd@kernel.org>
 <20261016124839.0d5564f7d7e036ee782a0486@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016124839.0d5564f7d7e036ee782a0486@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 16, 2026 at 12:48:39PM -0400, Hugo Villeneuve wrote:
> On Fri, 16 Oct 2026 14:59:47 +0200
> Arnd Bergmann <arnd@kernel.org> wrote:

...

> >  	switch (up->port.iotype) {
> > -	case UPIO_HUB6:
> > -		outb(up->port.hub6 - 1 + offset, up->port.iobase);
> > -		return inb(up->port.iobase + 1);
> > -
> >  	case UPIO_MEM:
> >  		return readb(up->port.membase + offset);
> 
> Maybe change to a simple if/else?
> 
> 	if (up->port.iotype == UPIO_MEM)
> 		return readb(up->port.membase + offset);
> 	else
> 		return inb(up->port.iobase + offset);

While it may work, I would still leave a possibility of the default case, but
Ideally this should be a simple callback level change, so it will be checked
only once at the probe time or so.

...

> >  	offset <<= up->port.regshift;
> >  
> >  	switch (up->port.iotype) {
> > -	case UPIO_HUB6:
> > -		outb(up->port.hub6 - 1 + offset, up->port.iobase);
> > -		outb(value, up->port.iobase + 1);
> > -		break;
> > -
> >  	case UPIO_MEM:
> >  		writeb(value, up->port.membase + offset);
> >  		break;
> 
> Similar here:
> 
> 	if (up->port.iotype == UPIO_MEM)
> 		writeb(value, up->port.membase + offset);
> 	else
> 		outb(value, up->port.iobase + offset);

Same here, see how we assign the respective callbacks in the 8250, for instance.

-- 
With Best Regards,
Andy Shevchenko


