Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9F17A309;
	Tue,  3 Mar 2026 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772526377; cv=none; b=E6yhBmKJ+nmIm0MQ4oXbd6iBOqCm1eMRxb9HG89yx2Mbg9Cr76q+iEe0R/xDNcJ8m3CYlHSiV1zDexNH6+GlW+WHG0dfk6ewF2D/j4Iw7QRmyWlJ5cCdwC6c3c8nR4+Wf/Dsn7SywK5CrTVyWFGrJSYhGkHc4lyciwzzhRgmE2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772526377; c=relaxed/simple;
	bh=448dK8GnIa9bf97ungbXtcNYT/1dnAsvokMfQnlvWHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYjYX/FwowIOAwHk0+MKTxE41ltY6+/vQNDSeR6wlpr+oOMDU57/LIUHG5nFIsXX51hVIaI/0wNpERuVtCYV4if4X6HcafU2DE2V4439D1/S/SxU4hVYAd3QUkJc6C4AeXggl4M00jaYfROD6PCvHx/3CUv21FqmseEw85CSpDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMF3V784; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMF3V784"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772526376; x=1804062376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=448dK8GnIa9bf97ungbXtcNYT/1dnAsvokMfQnlvWHA=;
  b=IMF3V784cLAHHv0EoL3iKZiiEIGSX/IrVGOV477KNgbC/gKK1XjcM26t
   wKi8M6fVH/8vbaUo4belx90P0B3GBqNhslzpVtVi9Ozfhutv/kt8USLfC
   ap1oKr0E7JClbl4FJ0TgsywG7uv+gi8aQXgUZw0NLj5VA6EW8IrVt05cA
   Pt7b3eRpyh6mEw8o+NVoZX7hdcqIisAOy+VWC7sJ6jKdkpJIWBOiSrcBj
   DPqIQysKepP3KFoRyWBsXtZpQDJMfYq5J3/xFVRM5muZM//NfuZEf48ss
   g9XpMxP5/TrqKfhacq5MggXUGqJFwHrKfY6wiN1F42utFQyvjEhd3afb8
   A==;
X-CSE-ConnectionGUID: WDtSG9nIT+KGLXC1IMB2VQ==
X-CSE-MsgGUID: lyYxbF+FQ7CUpaVjByfuwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73598159"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73598159"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 00:26:13 -0800
X-CSE-ConnectionGUID: yeA/LFCOSmy1UtfsMaGJBw==
X-CSE-MsgGUID: rE8pnFa0RnapIJyzaiMUWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="222084181"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 00:26:12 -0800
Date: Tue, 3 Mar 2026 10:26:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 1/1] serial: 8250_port: Drop duplicate NULL check
Message-ID: <aaabITX34OyXB2Dg@ashevche-desk.local>
References: <20260302152738.2498579-1-andriy.shevchenko@linux.intel.com>
 <c1500ee2-d609-4c66-b301-2b081722eef9@kernel.org>
 <aaaT_LiDbWX-ifK1@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaaT_LiDbWX-ifK1@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 03, 2026 at 09:55:45AM +0200, Andy Shevchenko wrote:
> On Tue, Mar 03, 2026 at 06:25:29AM +0100, Jiri Slaby wrote:
> > On 02. 03. 26, 16:27, Andy Shevchenko wrote:
> > > serial8250_release_dma() is NULL-aware, no need to check this in the caller.
> > > While at it, make sure DMA won't be used again, by NULLifying the pointer.

...

> > > -	if (up->dma)
> > > -		serial8250_release_dma(up);
> > > +	serial8250_release_dma(up);
> > > +	up->dma = NULL;
> > 
> > Shouldn't serial8250_release_dma() NULL it instead, so the callers need not
> > to bother?
> 
> I copied what 8250_omap is doing. But we can do what you suggested I think.

I looked at the 8250_dma code and serial8250_release_dma() in particular,
and I think I am not going to change the approach. The 'dma' pointer is
assigned outside of serial8250_request_dma() and NULLifying it in
serial8250_release_dma() will be a layering violation.

-- 
With Best Regards,
Andy Shevchenko


