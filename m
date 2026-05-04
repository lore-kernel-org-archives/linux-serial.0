Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8606521CFEF;
	Mon,  4 May 2026 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910412; cv=none; b=KunGZUOuC2Z8erMQpvj5ZlCApghjmIG6r7e3yysIt7nvPGtzmbK146ET4iCnZ6cCfxOGSFSMUdrIydMVxcBpVYAH3+D42mERvQdstIVlO/06C696wdo0LNxOtzblnUt2qAoCCBi5c1Bl35ZRfxASX3iN0Z0dHfaIig+vOHwjaK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910412; c=relaxed/simple;
	bh=fQFAs8EZqQunCH32/N5Lh8GaSW7zKxvz8m6KQX667pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5DUh4lzk924ah3BUn2E5XJUAhyrebZSwV/zZNQ/CamS0IFJSf6A7d4KrbkeXYev737PCqKgIAQIyqxWJ+SXgLfAa8cPL6QmPzKHiUzS03vjLDo4CJb2wL9fTbJeY9zgqj/VJNV1ewK0uDFWfIUBaUM9qGOHxEYx1QcnkmSiS/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0WeQTa1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0WeQTa1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777910411; x=1809446411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fQFAs8EZqQunCH32/N5Lh8GaSW7zKxvz8m6KQX667pU=;
  b=P0WeQTa158IyCXMPYHuPIEoE0wgAZrFWAH/VA6P87BQ5OJ2qzqfBWJd0
   frmBAx74D5i9Gb72Lf7LDTav8sRyBLQdwcv4LZV5q9nsc4FDDzp+RTQrI
   sNrDneWqAZ8KAb92uWz1mJ7y+MFBhruK3YJQII6gFmmNhFzAjvy9jypKH
   dAHzo/qZuQPA8Ix6WsjMJaWrNlmM8jsQUaqlBcNE2U19JOkRZrKpHolPs
   zXodcfHlAsTAN+FQqakJNP4ARKbRsiaMAfdKnTVj1jCfl60/SIfFsb+0M
   iizUzm4GSNVeKoguo/8o+ae4zjY7InxbuB9quHXCXXM90336VqPFxYkkE
   Q==;
X-CSE-ConnectionGUID: O4Dbenj8RtykmMMHXjeoCA==
X-CSE-MsgGUID: rd0LgzW3TvWsVi3WLlLWsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89873890"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="89873890"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 08:59:56 -0700
X-CSE-ConnectionGUID: j/XjCs2ESJ6SI/PRbL3g3w==
X-CSE-MsgGUID: Q8npQySJQlOpv+ulbY4W1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="231187285"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.198])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 08:59:52 -0700
Date: Mon, 4 May 2026 18:59:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Hugo Villeneuve <hugo@hugovil.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v2 02/15] serial: core: add uart_iotype_mmio/legacy_io
 helper functions
Message-ID: <afjCdicRlSZN3Asd@ashevche-desk.local>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
 <20260428-tty-upio-v2-2-01c1857cf761@dimonoff.com>
 <afNwaUf8esqaqxUe@black.igk.intel.com>
 <alpine.DEB.2.21.2605030016120.23161@angie.orcam.me.uk>
 <afhdTI_jAQrIsPSZ@ashevche-desk.local>
 <alpine.DEB.2.21.2605041220540.23161@angie.orcam.me.uk>
 <afitf0I1izLup5TR@ashevche-desk.local>
 <alpine.DEB.2.21.2605041617190.23161@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2605041617190.23161@angie.orcam.me.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 04:20:13PM +0100, Maciej W. Rozycki wrote:
> On Mon, 4 May 2026, Andy Shevchenko wrote:
> 
> > I see no value in this discussion. And I see no point to add a word where it's
> > not needed at all.
> 
>  Agreed.  I just pointed out that the use of "legacy" in this context is 
> not incorrect.  And "regular users" won't see any of this stuff anyway.

Good, thanks for the point!

-- 
With Best Regards,
Andy Shevchenko


