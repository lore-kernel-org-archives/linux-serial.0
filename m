Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE030F958;
	Sat, 15 Aug 2026 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786782872; cv=none; b=oIRpGLm92wl9o6ZygtDk2r9BgRfqzOAiFAGWKxlRilF0w8yiWkZdn6DWmUxYRyL+6vk/vXrt2jA58mDm98zJW41AW2zt/vkZb/200biduu5mix5+q9CFu3KolRsDMfJG3zTT7tkO9qD6yUn+aKOiPh3YIMBIsiJdBaej6N1foYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786782872; c=relaxed/simple;
	bh=gKJof34KC+wd1b2hMut55TPaTnGyH+YfRJH6ytIadFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkeHLK+c6yGN6euCcbYVBVCtQTd1zlgsqbi7lrYxZ5K9HCYd9Z06Epz0S0/TyKZxBY7JXMD+0F/sGF0JTPlBy5s54A0GsdUhAz5txpeZGGmWCu2PF7HDylhYzkKTWnmCLgG70VZdJ7vaERsh4dXHmMOiEs0+ylDKVuc3479+jqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmKYx5DQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmKYx5DQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786782870; x=1818318870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gKJof34KC+wd1b2hMut55TPaTnGyH+YfRJH6ytIadFw=;
  b=GmKYx5DQNeaOkN+3kQb4EjoCSIQIiwGc+NkvFKnvfzyR8E6FbCSxK4ao
   BAtItcpGKz0Ug9R5Zzez8/+53kV9kLFJbdzatuKJFlbA4B0dAk46zhz67
   bn7DOKg1zqZbVY0qF/4H9EdZXO/2aMIxUwQgCrVvAnOLv24hfrtco3L6J
   hyV2Xu8y0ro7V+wbctQcxtxF+HbwjQjuptzOhIWk/04hMbYnSnUb049NK
   6wU2qiBpOKXE/JDa4x0tP+Fc7J2pG96HNgu/ZWeos6aMfKV4VzW13jzCt
   K5Jt6DPOwYwGcHccuIVWEIWOxwWTH18IjeXj6XF2/FD31aegYE1K/KEvO
   w==;
X-CSE-ConnectionGUID: t/bUL5uyR+KMycBrXrAoHg==
X-CSE-MsgGUID: Y0uokZJnSda4cwQhyLc5Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="98706090"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="98706090"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 01:34:30 -0700
X-CSE-ConnectionGUID: lFhuD22QTkWGMJWmStLEGw==
X-CSE-MsgGUID: neTxRVOLSImPvL389ZF98g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="267926708"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.12])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 01:34:27 -0700
Date: Sat, 15 Aug 2026 11:34:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Long Zhao <longzhao@ambarella.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v3 2/2] serial: 8250_dw: add Ambarella CV75
 quirks
Message-ID: <aoAkkJQ8W_3gsQlx@ashevche-desk.local>
References: <20260813-cv75-v3-c-v3-0-9352b3fd6026@ambarella.com>
 <20260813-cv75-v3-c-v3-2-9352b3fd6026@ambarella.com>
 <an7YKyVbe1YDtyL_@ashevche-desk.local>
 <DS0PR19MB7925F03452B896607C0B8F43DADA2@DS0PR19MB7925.namprd19.prod.outlook.com>
 <an8BisPHjhqn4g4d@ashevche-desk.local>
 <DS0PR19MB79251D4A473960EE4BFDC642DADA2@DS0PR19MB7925.namprd19.prod.outlook.com>
 <an8KvvHWX0naH3Xw@ashevche-desk.local>
 <7E774305-3920-4BB7-BA46-E0772D6BED84@ambarella.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7E774305-3920-4BB7-BA46-E0772D6BED84@ambarella.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 14, 2026 at 12:39:12PM +0000, Long Zhao wrote:

> OK, Andy. We will switch to 8250_ambarella.c instead in V4.

You also may consider a quirk in 8250_of.c if it's quite standard OF-enumerated
8250-compatible device.

> 在 2026年8月14日，20:34，Andy Shevchenko <andriy.shevchenko@linux.intel.com> 写道：
> 
> ﻿On Fri, Aug 14, 2026 at 12:10:34PM +0000, Long Zhao wrote:
> 
> > Originally we submitted a dedicated Ambarella UART driver. During review,
> > Linus pointed out that the register layout is basically 8250-compatible
> > and suggested reusing the existing 8250 code instead of maintaining a
> > separate driver. That is how we ended up with the current approach of
> > binding through 8250_dw plus a small set of Ambarella quirks.
> 
> Right, please re-read carefully what he wrote
> 
> "This needs to be rewritten using the 8250 library in the kernel
> under drivers/tty/serial/8250/8250_ambarella.c
> or similar."
> 
> You already confirmed that your IP has nothing to do with the Synopsys. Why is
> the 8250_dw touched?!
> 
> > [1] https://urldefense.com/v3/__https://lore.kernel.org/r/CAD**AjLm6HzEU1TM-c=Vtjv3FJEBecVP7TyxSgq_Q0zF-YwT6NA@mail.gmail.com/__;Kys!!PeEy7nZLVv0!j8LqPRT2bzim1iC2xrU0AW4QUYvJ4oc4JqHIP3DMrOJVI-SdMHNYj2KIirs8ySAtvDwx1-Glz56DsGX6v1vzzCpWOGOb9LYXjg$
> 
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Friday, August 14, 2026 19:53
> > On Fri, Aug 14, 2026 at 09:33:45AM +0000, Long Zhao wrote:
> >> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Sent: Friday, August 14, 2026 16:56
> >> On Thu, Aug 13, 2026 at 06:35:13PM +0800, Long Zhao via B4 Relay wrote:
> >> 
> >>> Add CV75 platform data with an ETOI IER mask and skip-set-rate so
> >>> the DesignWare 8250 driver can drive the Ambarella UART for console use.
> > 
> >> Thanks for the review. Agreed the commit message was too brief.

...

> >>> +    /* Keep variant-specific bits in the shadow across subsequent
> >>> +updates. */
> >> 
> >> This says what code is doing. Instead it must say "why?" the code is doing this.
> >> 
> >>> +    up->ier |= d->pdata->ier_mask;
> >>> +    serial_port_out(p, UART_IER, up->ier);

...

> >> In case there is an HW bug, where can we get the errata, please? (For
> >> a bare minimum add a reference to the Errata document you give to the
> >> customers.)
> > 
> >> This is not a silicon erratum. The Ambarella UART is not Synopsys
> >> DesignWare IP; it is an Ambarella 8250-compatible UART. We still use
> >> the snps-dw-apb-uart binding / 8250_dw because the programming model
> >> matches closely enough, with two quirks (ETOI IER bit and
> >> SKIP_SET_RATE). I will expand the commit message and rewrite the
> >> comment to explain why in the next revision.
> > 
> > Okay, what does it make to think that 8250_dw is a suitable choice?
> > What are the features that are repetitive would be if you use a custom
> > 8250-based driver (using the generic 8250 code)?

-- 
With Best Regards,
Andy Shevchenko


