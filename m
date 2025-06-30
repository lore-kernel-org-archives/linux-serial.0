Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED828A3EF;
	Mon, 30 Jun 2025 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287088; cv=none; b=dBOVUyXE5vvF0NJV0gTT4mOJlaAD/fUeN8mCpVXwCUGclbcdmql+Iac/uEAjXFDOMBMlwxANd52/VlcAheTV10C+xWTSWRy+cAmUjNu2rKalSGIn4+93z13biF8vRAa1VZVDCqXUGZi5292EcjNo12tYNgihg6AkBAa2y+8Jv1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287088; c=relaxed/simple;
	bh=Hc4d0axlb0QIm7buUtUoHen9OaZG8yxdv/vS2Vp5K9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdshFyqtieNDBcIrFJKrcw31uaNx5fn/PkIk3H38X4eSGhCigvQzm575Pso/CJZyf/co68PWkUd9vhGTGfd4X/NOY0eCWE1oQ8+LYgpT9f5D7r2KmJWo2cdcVDrsKFa8XWGnEtL5LTz44fPGJD7YdYKuQV2FvNd8n+LVfyOdQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOvEVZut; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOvEVZut"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751287088; x=1782823088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hc4d0axlb0QIm7buUtUoHen9OaZG8yxdv/vS2Vp5K9U=;
  b=FOvEVZutmdYkOk+2VZR5H9nbJpkYfTk9ErQcqdR71y7rq2lhRC2MTH/d
   McATlQYILJRuE1Ja0cyEVY8CC6jzOm0zO4oi5bne3JUGhAui6ri/+Hm3/
   +IL9F3KUzQwz9YhbDKPkKolVP3VTJM9LKJi+6P4/C0JiieNtqa6zPOPBc
   w4WoIsoJRxOVT2hQDCe3e9do3nqchAEQzLWjOoFCtWqTE4RygxMLPFOyR
   r1aZO2fBSDh7mf1vxWgjBYkWCnseJcq/frDgBqR+/k9az0cpPi98PdNjm
   QTdIKsS/bjHHdVcVJQfznIXQt3vJakYXLOTo9jU0gPoV61LWnv5qGkRgj
   A==;
X-CSE-ConnectionGUID: QvY2GwgeSDidrfmI1y9ygQ==
X-CSE-MsgGUID: ISLRMK/+T3a9w9KdBMBVEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53634349"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="53634349"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 05:38:07 -0700
X-CSE-ConnectionGUID: keLvS+2ATcykwwgAecvlQw==
X-CSE-MsgGUID: zEalniYYRZ2v4I0ct8WWoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="153990099"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 05:38:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWDlo-0000000BJ3z-4AOE;
	Mon, 30 Jun 2025 15:38:00 +0300
Date: Mon, 30 Jun 2025 15:38:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 1/1] serial: 8250: Move CE4100 quirks to a module
 under 8250 driver
Message-ID: <aGKFKOWv1xTDlhnD@smile.fi.intel.com>
References: <20250627182743.1273326-1-andriy.shevchenko@linux.intel.com>
 <a7f162cf-b7ba-472c-b13a-e3a5cd722bab@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f162cf-b7ba-472c-b13a-e3a5cd722bab@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 30, 2025 at 01:27:10PM +0200, Jiri Slaby wrote:
> On 27. 06. 25, 20:25, Andy Shevchenko wrote:
> > There is inconvenient for maintainers and maintainership to have
> > some quirks under architectural code. Move it to the specific quirk
> > file like other 8250-compatible drivers do.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Nice.
> 
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Thanks, but it seems a bit late :-)

> Just two nits (one suggestion actually) below. Ignore if you won't resubmit
> for some other reasons...

Sure, see above.

...

> > +static inline void sdv_serial_fixup(void) {};
> 
> Superfluous ;.

Indeed. But I don't want to update just this (as it now may require
a separate change for x86).

...

> > -static u32 ce4100_mem_serial_in(struct uart_port *p, unsigned int offset)
> > -{
> > -	u32 ret, ier, lsr;
> > -
> > -	if (offset != UART_IIR)
> > -		return mem_serial_in(p, offset);
> > -
> > -	offset <<= p->regshift;
> > -
> > -	ret = readl(p->membase + offset);
> 
> Just noticed: why the two above lines are not one:
> ret = mem_serial_in()?
> 
> Or in fact the whole function intro:
> ret = mem_serial_in(p, offset);
> if (offset != UART_IIR)
>   return ret;

Hmm... Sounds like an equivalent. I probably can send a followup for this
suggestion.

-- 
With Best Regards,
Andy Shevchenko


