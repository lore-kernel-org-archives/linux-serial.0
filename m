Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5252725A2AF;
	Wed,  9 Apr 2025 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183759; cv=none; b=B66P+FE4YwWhKQ0Fruu2/CvYL8qUVG+YP9PLehRBGePm0Ut053+yE9jq6Zf0xJtWCzLZP6asoEbVpr5EAwwrDSWyLM1/0gPyXhR57w6RPWex+kBfbHldu28wmjZfFKIE5taB1541tY0XniWEEUOC9ATJXW1MILxEiSw+KDiiK0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183759; c=relaxed/simple;
	bh=SGfNYxf1SFuOxndDllT2akQb3PF8/MAIXy5zK8FRPFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQzzPWSf/UcYHMdBuWN1792STMfStMvUbX4Yf/FZfhYZwa6t2C00PeVPPjW7wlSDIC/ITq27YDRnqukRhLlYpJJsPKHocgpyGDZCz0uc9fuyNOkPt3GQ/2/IVTB8NhrMb2HGrdSWvNSyBr0ph4JZggDe3FE/jzm9GzHQlnolGTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rm3YTr4z; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rm3YTr4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744183758; x=1775719758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SGfNYxf1SFuOxndDllT2akQb3PF8/MAIXy5zK8FRPFk=;
  b=Rm3YTr4zX7jrsW3HdK/2QJVwuds63NoPsnJs0PSkOHj290rWCVwhjJrM
   0x3I83sGOO3DkXdkZX/mvI5i+sd3v20Dbfbb5FM5cWUmVufAGM8/AFvcg
   fJpnPk3H/s7I4nHcwab+fbNWy8igJgz71G7XQLlmpaQSCJ33Sc8C/AsN9
   LI2xFEyjAjhE0T0hqwvHrrAYxqUrM509rbc/dHYDn+jPZ4iEOQj4+sx/D
   O8TSgR95HVY/ZOrMNm3QU0SeVNvhg4+28O83SDu9Gd7u6RigNgj7P8JOU
   uf3AwCJYPfgyuPzpAoj4autqb2d2kK+k7Ms1ho7v2Soq1dDefqJgm+DTZ
   g==;
X-CSE-ConnectionGUID: 61PDVKtITjey4Br80ruInw==
X-CSE-MsgGUID: 09pfA6+WR2Ky87QnZbZUJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="33248826"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="33248826"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 00:29:16 -0700
X-CSE-ConnectionGUID: Sov2QirNQMyY4Sg8LTP0bw==
X-CSE-MsgGUID: g5S/97v6QbiG4KufX4Wc1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="129331858"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 00:29:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u2Prs-0000000AeQj-2FRX;
	Wed, 09 Apr 2025 10:29:04 +0300
Date: Wed, 9 Apr 2025 10:29:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alex Elder <elder@riscstar.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	benjamin.larsson@genexis.eu, bastien.curutchet@bootlin.com,
	u.kleine-koenig@baylibre.com, lkundrak@v3.sk,
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250_of: add support for an optional bus
 clock
Message-ID: <Z_YhwJ1ZGSodMcMH@smile.fi.intel.com>
References: <20250408175146.979557-1-elder@riscstar.com>
 <20250408175146.979557-3-elder@riscstar.com>
 <Z_V-aKBOFHt-0RKz@smile.fi.intel.com>
 <2b322564-10c0-4bbd-89d9-bc9da405f831@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b322564-10c0-4bbd-89d9-bc9da405f831@riscstar.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 08, 2025 at 03:11:10PM -0500, Alex Elder wrote:
> On 4/8/25 2:52 PM, Andy Shevchenko wrote:
> > On Tue, Apr 08, 2025 at 12:51:43PM -0500, Alex Elder wrote:

> > > The SpacemiT UART requires a bus clock to be enabled, in addition to
> > > it's "normal" core clock.  Look up the core clock by name, and if
> > > that's found, look up the bus clock.  If named clocks are used, both
> > > are required.
> > > 
> > > Supplying a bus clock is optional.  If no bus clock is needed, the clocks
> > > aren't named and we only look up the first clock.
> > 
> > Code and description are not aligned. And What you are described above make
> > more sense to me than what's done below.
> 
> I want to do this the right way.
> 
> My explanation says:
> - look up the core clock by name
>     - if that is found, look up the bus clock
>     - both clocks are required in this case (error otherwise)
> - If the "core" clock is not found:
>     - look up the first clock.
> 
> And my code does:
> - look up the core clock by name (not found is OK)
>     - if it is found, look up the bus clock by name
>     - If that is not found or error, it's an error
> - if the "core" clock is not found
>     - look up the first clock
> 
> What is not aligned?

That you are telling that bus is optional and core is not, the code does the
opposite (and yes, I understand the logic behind, but why not doing the same in
the code, i.e. check for the *optional* bus clock first?

> > Also can we simply not not touch this conditional at all, but just add
> > a new one before? Like
> > 
> > 	/* Get clk rate through clk driver if present */
> > 
> > 	/* Try named clock first */
> > 	if (!port->uartclk) {
> > 		...
> > 	}
> > 
> > 	/* Try unnamed core clock */
> > // the below is just an existing code.
> 
> That's easy enough.  I think it might be a little more code
> but I have no problem with that.

I;m fine with a little more code, but it will be much cleaner in my point of
view and as a bonus the diff will be easier to review.

> > 	if (!port->uartclk) {
> > 		...
> > 	}

-- 
With Best Regards,
Andy Shevchenko


