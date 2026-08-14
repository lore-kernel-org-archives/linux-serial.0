Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6FB3AB29E;
	Fri, 14 Aug 2026 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786708370; cv=none; b=hpqh69+rKxB/2CKpS/KlEdSwkW961L7kxQV+pam5epuN/YUNPrNNmfvFmKA/mcbS8MIODj3YGjylfiXO69OgT7Odx7QIkpib4NVi9w5O6xTB7ySFEm//yMK4yugD6+yGzmgjzdVkSwpBVlgXo0dWASmYVWPd/K0mgkaXNjgsu/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786708370; c=relaxed/simple;
	bh=FcdBGUrzl0QCcbxTJeDlANFo3txBB5VqLaqK7VwOQ/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwgMiiWR7aG/GevaTDRdlXfMeAKR5ioKwKRKnSTz2JC8dKNVh3xlBEh3fD1WBty3tMxFozeRJ9X1q6glgvYGENX9MdL/nESpYeDPBpRYIIPanX4hXzbHaF1VZN7N37c9EEZ5Iry2clmfLunfcYOByH8PQZ6Bq862bkDd6bid20g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lDhzPN7Q; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lDhzPN7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786708369; x=1818244369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FcdBGUrzl0QCcbxTJeDlANFo3txBB5VqLaqK7VwOQ/w=;
  b=lDhzPN7QO3y4mk6uf0i5IrYcJ42qbh8jDU/uBokyuuAVTtcmr2H7HPMS
   YMtBY7WHTRLdFk85mZ44eJ6Yh7tNUBMKZ9ioAfUF9NkRB82RikFL0SNwp
   5HIg001Wb/OeOpCaIEBrTiSPdm4aUdR1GCuBXFRa1BTTJYCf6aFRCW9D8
   xhwZinqcgiRvddcR4zq+El5koA/NaJLF+veGdb/3+jN9txLWGXd/wJudX
   K7VBm+VA/9YhuUKtUwESWGkMB2Xrmq5AJL1FpkTah9EKYNsppRZTH3tJj
   CmC3X6bKVyynyF7XHUaCy90+VFB9sCnR8+u9/DUsujFis4hZ4MC8DeHCR
   g==;
X-CSE-ConnectionGUID: +crRLpoAR9CBpcuJsvC0DQ==
X-CSE-MsgGUID: qT98ekwZRJG1COEOt2WB3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="97631296"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="97631296"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 04:52:48 -0700
X-CSE-ConnectionGUID: OEG5i7VXRa2w3uS+FUOKVg==
X-CSE-MsgGUID: 7GrVpiJ7SPCzZpkOP6CRNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="260936894"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.134])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 04:52:45 -0700
Date: Fri, 14 Aug 2026 14:52:42 +0300
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
Message-ID: <an8BisPHjhqn4g4d@ashevche-desk.local>
References: <20260813-cv75-v3-c-v3-0-9352b3fd6026@ambarella.com>
 <20260813-cv75-v3-c-v3-2-9352b3fd6026@ambarella.com>
 <an7YKyVbe1YDtyL_@ashevche-desk.local>
 <DS0PR19MB7925F03452B896607C0B8F43DADA2@DS0PR19MB7925.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR19MB7925F03452B896607C0B8F43DADA2@DS0PR19MB7925.namprd19.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 14, 2026 at 09:33:45AM +0000, Long Zhao wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com> 
> Sent: Friday, August 14, 2026 16:56
> On Thu, Aug 13, 2026 at 06:35:13PM +0800, Long Zhao via B4 Relay wrote:
> 
> > Add CV75 platform data with an ETOI IER mask and skip-set-rate so the 
> > DesignWare 8250 driver can drive the Ambarella UART for console use.

> Thanks for the review. Agreed the commit message was too brief.

...

> > +	/* Keep variant-specific bits in the shadow across subsequent 
> > +updates. */
> 
> This says what code is doing. Instead it must say "why?" the code is doing this.
> 
> > +	up->ier |= d->pdata->ier_mask;
> > +	serial_port_out(p, UART_IER, up->ier);

...

> In case there is an HW bug, where can we get the errata, please? (For a bare
> minimum add a reference to the Errata document you give to the customers.)

> This is not a silicon erratum. The Ambarella UART is not Synopsys
> DesignWare IP; it is an Ambarella 8250-compatible UART. We still use
> the snps-dw-apb-uart binding / 8250_dw because the programming model
> matches closely enough, with two quirks (ETOI IER bit and
> SKIP_SET_RATE). I will expand the commit message and rewrite the
> comment to explain why in the next revision.

Okay, what does it make to think that 8250_dw is a suitable choice?
What are the features that are repetitive would be if you use a custom
8250-based driver (using the generic 8250 code)?

-- 
With Best Regards,
Andy Shevchenko


