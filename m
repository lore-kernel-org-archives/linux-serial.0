Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A8A2BEC52;
	Tue, 28 Apr 2026 10:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373872; cv=none; b=rfphqBEXhkrzyNfOZEGB1TyWaGpbGLo70rts3xNPLHAIIep3dhBHb90mAdHVuEZa0denei6DEQz+QrS1geITjvzklpSM9pEh0EwR64XHEvTxl6kWQ0NCJtJW0Pu4B4ykua99AckfQCqwoQqmL6jhy6R8d5I8fuGCTMX5EFVwd5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373872; c=relaxed/simple;
	bh=jZqbKM6fTH2y2tP3GL5djv9kTVVxmpd9tFQDt64FRzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/12yxziIjwkh36Ow02ZqX8HFS+iw664QMOYw2W4/Gb0vfhT4AIW09hIYqdFAV4PXRISJz/SsasLjPL8Fzx0zFetoK2eO3UZzhfIfos3juPyiKfI2Kfy2gNyFrlkXqwZqeqV6itNv8+7GXg4cFlWFQlj9K2pz2VaVd6uWAd7NO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cG5SXQP/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cG5SXQP/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777373871; x=1808909871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jZqbKM6fTH2y2tP3GL5djv9kTVVxmpd9tFQDt64FRzY=;
  b=cG5SXQP/eUssWCTJAL6Mb+RhI+8HPp5H9yxDfag4rR6UlZBZiA/SYWIT
   VDLAx3oaJCOEeLKfRCPjwhbYVlEMtTnZEJrpkOhj/R9cjROKw3lusb8W4
   unccpiz7bti3Sac0fRowZl8UiBx1WPxY41alvFWmscgMo9/fmRgd+PM03
   N9mNhtK6CS/ZBIi7PG2CDCZWDpIMMp7yis/wRMu4/IQeAOKZDyszzDS87
   X5mOKuNCaVYA3VfBgM4XNpebRw9GZIHbTi692Q4A1DXCdGJWF0kQeFqEi
   I9n7jNZIQQL2CCxOGtsnTk5rwNq1MJ48GS12RZNrh2kONNq7Fg74Ap3Dx
   Q==;
X-CSE-ConnectionGUID: Y5nBkscdQq67r867YyIZwA==
X-CSE-MsgGUID: ahKxCNmVTlWISqY9ekut3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82142420"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="82142420"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:57:51 -0700
X-CSE-ConnectionGUID: eQok1vOwTLq9TgtktLe6yA==
X-CSE-MsgGUID: gN56KnSvSeu0fNlNRPvrGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="229567811"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:57:46 -0700
Date: Tue, 28 Apr 2026 13:57:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jia Wang <wangjia@ultrarisc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/4] serial: 8250_dw: build Renesas RZN1 CPR value
 from DW_UART_CPR_* definitions
Message-ID: <afCSqA0RguPKfUp0@ashevche-desk.local>
References: <20260428-ultrarisc-serial-v5-0-97de63b1e3eb@ultrarisc.com>
 <20260428-ultrarisc-serial-v5-2-97de63b1e3eb@ultrarisc.com>
 <afBhkbGLsuqUitOl@ashevche-desk.local>
 <23c80500-f2c1-0eb3-f640-00f7b108059b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23c80500-f2c1-0eb3-f640-00f7b108059b@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 11:41:27AM +0300, Ilpo Järvinen wrote:
> On Tue, 28 Apr 2026, Andy Shevchenko wrote:
> > On Tue, Apr 28, 2026 at 01:26:27PM +0800, Jia Wang wrote:

...

> > >  /* Helper for FIFO size calculation */
> > >  #define DW_UART_CPR_FIFO_SIZE(a)	(FIELD_GET(DW_UART_CPR_FIFO_MODE, (a)) * 16)
> > 
> > > +#define DW_UART_CPR_FIFO_MODE_MAX	0x80
> > 
> > You used decimal values elsewhere (id est 16), use upper limit in decimal
> > as well.
> > 
> > > +#define DW_UART_CPR_FIFO_MODE_FROM_SIZE(size)				\
> > > +	(BUILD_BUG_ON_ZERO(!IS_ALIGNED((size), 16)) +			\
> > > +	 BUILD_BUG_ON_ZERO(((size) / 16) > DW_UART_CPR_FIFO_MODE_MAX) +	\
> > > +	 ((size) / 16))
> > 
> > I don't see the need in having that maximum being defined separately (we don't
> > have that for 16, no need to have it for 128.
> > 
> > Since some ISA:s have one assembly instruction to get both / and % divisions,
> > it's better to use that instead of IS_ALIGNED(). Can you check code generation
> > for x86_64 / x86?
> 
> Do those BUILD_BUGs even generate code, especially when they are expected 
> to only appear in a struct initializer?

Good question if this affects the code generation.

> > #define DW_UART_CPR_FIFO_MODE_FROM_SIZE(size)				\
> > 	(BUILD_BUG_ON_ZERO((size) > 2048) + BUILD_BUG_ON_ZERO((size) % 16) + ((size) / 16))
> > 
> > Note, I dropped first division in order to show the upper limit in a plain
> > number since 16 is also FIFO size in bytes.
> > 
> > Also note, this evaluates (size) three times, which might be problematic,
> > but I think we can leave with that for now.
> 
> I'd put also FIELD_PREP_CONST() into the macro itself as I don't see much 
> value for this macro outside of those .cpr_value initializations.

Yep, and it would make it on par with the existing _FIFO_SIZE() that has
FIELD_GET() there.

> IMO, the entire macro would be cleaner looking as a truly multi-line 
> construct. Can we use static_assert()s in struct field initialization 
> (I'm not sure), something along these lines:

I believe one may put there static_assert():s.

> #define DW_UART_CPR_FIFO_MODE_FROM_SIZE(size)			\
> ({								\
> 	typeof (size) __size = size;				\

Perhaps auto ?

> 								\
> 	static_assert(IS_ALIGNED((__size), 16));		\
> 	static_assert(__size <= DW_UART_CPR_FIFO_MODE_MAX);	\

But I still think the % and / paired are clearer (for reading and understanding)
even if they do not affect code generation. Also I think the plain number of the
maximum size is better for the same reasons we do not have it for 16.

> 								\
> 	FIELD_PREP_CONST(DW_UART_CPR_FIFO_MODE, __size / 16);	\
> })

-- 
With Best Regards,
Andy Shevchenko


