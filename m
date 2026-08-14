Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3704F45DF42;
	Fri, 14 Aug 2026 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710725; cv=none; b=XQCYA4/c1fUfVS+lKSiUmH1KqNfXaQLwPw0pPtP3xZHUBPOacK5pyGeD1CsEPJp7/zVxfOgPsG0Qwx/nBpoflIt+xxS1xsHZ52FG7dYkRBBWfv0w66TtBH7M8x7E9+hbUIe/+pjdXQzSlYbGV0Epo8tZa1EjJf8wKNOwoB4OlCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710725; c=relaxed/simple;
	bh=Dtx74Bsr4f54TRVY6Na2ad6xF+H7OWeCuvgZYuVNcGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHa4Ip1uZTnYD8Ilq10MmHpvD8gsqKibQhgUON0oBeaioqRmnkxaNxXMHsXWQesnrHjTVlBGkysMxGmp0F3CUWV/N9FHZnmw0UckbtHCHVfZ1djI3slfSOFPfdO++tdPXQEOgSI/7hOG9RhRQLvMU1sFVqsX2k0r4E0Zvocw8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIviHBlE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIviHBlE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786710724; x=1818246724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dtx74Bsr4f54TRVY6Na2ad6xF+H7OWeCuvgZYuVNcGw=;
  b=EIviHBlEVybE25sWzplwxChvo7MXSnt+ZhDFWzZZDiNA5WPYaXhlvAlm
   s3yjR5gr2pvvGFW90VJA50/P3x11FSlHpHNE4rjy+/Q0SC4aNQZd+4Z10
   +x83Czj/OZYKTTErgO1MNYBdObmWYoDs1K9AuZho2rqs4UbENBAsSQUp6
   uoCrdTbmGDNzFIDdNQAdz7GV5veSU8OVmoff22OFrm6v+SK/jDXHtd1ra
   Ieb94zxp7JcnNSZAV2z8pHUU0FD6ZGCiCbZxjS/opPftrfYNQXn826X7q
   tjdH/LoTMVP8c44OANeIOW3sSpTDQreXaYJcSncQ7O2gv3gZ7aC3X65Ny
   Q==;
X-CSE-ConnectionGUID: DWpz1UMSRciPrxh7nJIlfw==
X-CSE-MsgGUID: 9KX35awGQ+mSCi3IQgQChQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="98802215"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="98802215"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 05:32:03 -0700
X-CSE-ConnectionGUID: p4W/LreoT1yoMz9zVwIvBg==
X-CSE-MsgGUID: XG3IECYcSBmm+iCHPVocTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="289009101"
Received: from inaky-mobl1.amr.corp.intel.com (HELO localhost) ([10.245.244.225])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 05:32:00 -0700
Date: Fri, 14 Aug 2026 15:31:58 +0300
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
Message-ID: <an8KvvHWX0naH3Xw@ashevche-desk.local>
References: <20260813-cv75-v3-c-v3-0-9352b3fd6026@ambarella.com>
 <20260813-cv75-v3-c-v3-2-9352b3fd6026@ambarella.com>
 <an7YKyVbe1YDtyL_@ashevche-desk.local>
 <DS0PR19MB7925F03452B896607C0B8F43DADA2@DS0PR19MB7925.namprd19.prod.outlook.com>
 <an8BisPHjhqn4g4d@ashevche-desk.local>
 <DS0PR19MB79251D4A473960EE4BFDC642DADA2@DS0PR19MB7925.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR19MB79251D4A473960EE4BFDC642DADA2@DS0PR19MB7925.namprd19.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 14, 2026 at 12:10:34PM +0000, Long Zhao wrote:

> Originally we submitted a dedicated Ambarella UART driver. During review,
> Linus pointed out that the register layout is basically 8250-compatible
> and suggested reusing the existing 8250 code instead of maintaining a
> separate driver. That is how we ended up with the current approach of
> binding through 8250_dw plus a small set of Ambarella quirks.

Right, please re-read carefully what he wrote

"This needs to be rewritten using the 8250 library in the kernel
under drivers/tty/serial/8250/8250_ambarella.c
or similar."

You already confirmed that your IP has nothing to do with the Synopsys. Why is
the 8250_dw touched?!

> [1] https://lore.kernel.org/r/CAD++jLm6HzEU1TM-c=Vtjv3FJEBecVP7TyxSgq_Q0zF-YwT6NA@mail.gmail.com/

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com> 
> Sent: Friday, August 14, 2026 19:53
> On Fri, Aug 14, 2026 at 09:33:45AM +0000, Long Zhao wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Friday, August 14, 2026 16:56
> > On Thu, Aug 13, 2026 at 06:35:13PM +0800, Long Zhao via B4 Relay wrote:
> > 
> > > Add CV75 platform data with an ETOI IER mask and skip-set-rate so 
> > > the DesignWare 8250 driver can drive the Ambarella UART for console use.
> 
> > Thanks for the review. Agreed the commit message was too brief.

...

> > > +	/* Keep variant-specific bits in the shadow across subsequent 
> > > +updates. */
> > 
> > This says what code is doing. Instead it must say "why?" the code is doing this.
> > 
> > > +	up->ier |= d->pdata->ier_mask;
> > > +	serial_port_out(p, UART_IER, up->ier);
> 
> ...
> 
> > In case there is an HW bug, where can we get the errata, please? (For 
> > a bare minimum add a reference to the Errata document you give to the 
> > customers.)
> 
> > This is not a silicon erratum. The Ambarella UART is not Synopsys 
> > DesignWare IP; it is an Ambarella 8250-compatible UART. We still use 
> > the snps-dw-apb-uart binding / 8250_dw because the programming model 
> > matches closely enough, with two quirks (ETOI IER bit and 
> > SKIP_SET_RATE). I will expand the commit message and rewrite the 
> > comment to explain why in the next revision.
> 
> Okay, what does it make to think that 8250_dw is a suitable choice?
> What are the features that are repetitive would be if you use a custom 8250-based driver (using the generic 8250 code)?

...

> **********************************************************************
> This email and attachments contain Ambarella Proprietary and/or Confidential Information and is intended solely for the use of the individual(s) to whom it is addressed. Any unauthorized review, use, disclosure, distribute, copy, or print is prohibited. If you are not an intended recipient, please contact the sender by reply email and destroy all copies of the original message. Thank you.

You have to get rid of this trailer. This is last time I reply on messages with
it. (Replying to it might lead to some legal consequences for me and others...)

-- 
With Best Regards,
Andy Shevchenko


