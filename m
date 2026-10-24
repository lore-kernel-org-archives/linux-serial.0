Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792847965;
	b=w5dZoTvWu6wB08aVoMaqQG9O+recCfyW0rSj/JMGtpv1aiZRf1XwfD2gAS9aXvl3/58L
	 lxFI1wz/kqt3EwQfmkNiCATndiNF6T4k2YZgJjY9moRZed7hHkxNQhQsnMokSG9Xj8T1y
	 d8PtUFR/GaovP18RbyaqKP885I+kKEQELhqnyMxSdCw3UIRJRfj6UIy6K3Qnpey8nbqBS
	 0M4wOyZMnwgRgR/BgC9xRzzukzkzH6Lv5M4K0xi4/nu8+5il7iorkH53t9RxZ5opn+ty+
	 0diEbf42+3gW50EDAdFZvETI9e3jtlFWFqe9ZMgMY+o+Yn1vVG6nvImAv6b1kIk0mCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792847965;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=+eTq2RouSMP57iyX/xKgxw3blvHVYyiPPERedc75Hk0=;
	b=X3XQBgsu9XyoH0f2SQ76cTULCLyVORs4R7/kSMWPZnzL7Zi4A+gJZITqqzpC7L8eS2Wa
	 Vo9OxGbMKjwPCd4OCOEa6RLkGCAYNNaQ8gE9Rp/MmAZ8+jXjX/57ZEHKsBuWTeCNi3ZHp
	 8BvADsxoTG+dxNBPnB6SgSxs3L0OSdhM5iEvCAoyyhZHtHuPi2aGv6C1GqVVaQR5c7dCN
	 3tmJMDlxB4JxWuYA70pQ0NZfNUgBn78e3cpqsdwn8c4gOUwamU+oar0lDfL0/EthMg1Rr
	 hRVedt2gf9fbwnij64k3Ndc8mMskZ/vdOKIHwR85uqeTNyIc4ufBLgkmscu8I6RVtzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k9Z6kVe5;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E05606A31B;
	Sat, 24 Oct 2026 13:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5E05606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k9Z6kVe5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792847965; x=1824383965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CYtQ0z2b8nAxy7Z61dsDKTufFY11coH1fY1mN0AgzEU=;
  b=k9Z6kVe5v3fCaXp1PnEgbOYAlDnojYw1nphzXMVzl3i6lwwBcYsXpr2O
   qziejhRpyIPau5jfJS4NDclJ15fM7pqcWYLcJSXql+Bhqx9AObp+aZBkZ
   dUQrUg/9LNoxgT296OeuTBaFQQfNCt1wKSW1dMhRFDjGb8H8BORe6HmXf
   X4imVQmkLMcoEP5tl1RWLILQaAu7buXHThm41H/WAs6QudveKYT0i6LNW
   GfiFDtoKDFbBkVxLwBqzQl19lFIN5ErJLTGQeIHW6v3Gs44nJ2AA8ugd9
   UftL5FdWwJZpQ11cbe/k0257DHZ5tlyVx5GDcyzlTup4Nag5EaCDKthPl
   w==;
X-CSE-ConnectionGUID: GUljCMOXRaqs6Hnaq35uSw==
X-CSE-MsgGUID: aC+9M4V2Q+GqBC0itL+iTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1485033"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1485033"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 06:19:24 -0700
X-CSE-ConnectionGUID: mClJgBpfQtCb9H9Y4xRoUg==
X-CSE-MsgGUID: J3izvhnITo6KSugqa4/SpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="5714256"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 06:19:20 -0700
Date: Sat, 24 Oct 2026 16:19:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: James Hilliard <james.hilliard1@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/3] serial: 8250_dw: configure the Allwinner H616 UART
Message-ID: <atywVnHU5NsP_gOP@ashevche-desk.local>
References: <20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com>
 <20261023-submit-h616-uart-fifo-v1-v1-2-e4a3bae2eba8@gmail.com>
 <atseYvQUYvpMFEIM@ashevche-desk.local>
 <CADvTj4pRW9q6VyQ=nLi8q0mMF8LgccfO4eqAeqgzzgOkDno1dw@mail.gmail.com>
 <CAGb2v65LVm1GV2kV4bVO8YJd16tkubHOvXUtbJ3uuBw2O3TBsA@mail.gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v65LVm1GV2kV4bVO8YJd16tkubHOvXUtbJ3uuBw2O3TBsA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 10:10:33PM +0900, Chen-Yu Tsai wrote:
> On Sat, Oct 24, 2026 at 12:12 AM James Hilliard
> <james.hilliard1@gmail.com> wrote:
> > On Fri, Oct 23, 2026 at 2:44 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Oct 23, 2026 at 01:33:50AM -0600, James Hilliard wrote:

...

> > > >       /* Internal 8250 only */
> > > >       UART_PORT_AIROHA                = 124,
> > > >       UART_PORT_AIROHA_HS             = 125,
> > > > +     UART_PORT_DW_APB_256    = 126,
> > >
> > > Why? Besides the poorly chosen name, what prevents us from modifying the
> > > corresponding parameters at probe time by leaving the one of the existing
> > > types?
> >
> > The new type was primarily a way to reuse the core's FIFO configuration
> > table, including the RX trigger mapping. H616 uses thresholds of 1, 64,
> > 128 and 254 bytes, whereas PORT_16550A maps the same FCR bits to 1, 4, 8
> > and 14 bytes. Overriding only fifosize and tx_loadsz would leave
> > rx_trig_bytes reporting and selecting the wrong thresholds.
> >
> > The core already has get_rxtrig/set_rxtrig callbacks, though. I'll rework
> > this to retain PORT_16550A, supply the H616 FIFO parameters during setup,
> > and use those callbacks for the correct trigger mapping.
> 
> Please consider just taking the FIFO size from the DT. On some chips
> not every UART has the same size FIFO, so we already need to deal with
> it.
> 
> Also, FIFO size is a standard UART DT property, though somehow not included
> for dw-uart.

FWIW, it supports all standard properties for UART.
Check what uart_read_port_properties() does.


-- 
With Best Regards,
Andy Shevchenko


