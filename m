Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792939767;
	b=L8s8WdwDywkbTvBMy3u5PO6SyX/letxPynj9kGJxvsUvS/URvY3NVu/U25ixQFj8cyQo
	 GOxYX/bJrHv71xeLzhFpEgzRbC1GfI6CgrnOLOFp4Pf+RteFS5a3q0em9tU/EvHJAKAeO
	 AjDTGsSzQsLJ8hTI8ByTLpRdoTLvOjOiyG9hID/kGxab+mTe0Fl0c6UGDXMN80jk7bSMs
	 2GJEo+ygJzaImuSdLkCz/8KswSMcyQfcT4qCZ7l8dYBNHoOyT7bVpllEo+b4Cm7ij/IY9
	 QIZx1NetVhhb7mq81zKrghrtHKoi0hGLCSNOzBJWXDZGSCQQrXBRR/4nx1dz9e5H14g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792939767;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=hG/4IjfT07Q6Afx12UtU9nDqugWqc6o8tThzxSfg8ek=;
	b=lCTHI37dQYEwze3uT/ff8OyAGNkp/CIu9E60ajQ6ZWWvq14sZyS2p3JtcBn9SNm9Wb2q
	 yWMJPRcnqz4B7sUShb4mqzAjvYMN0Ucw/LKotAmDTImrU6YTx6oncf4dVCprhhrbdoeT+
	 DNDkb5e194BUPCd8XnB6GhqE0NvEC//wyYbC6uOr0EER1L5OPgANfIJ+VTx8MIB3kVZmQ
	 81rMvABHBPxCflGBXvp8T9eV7og5yX97L3/a0dQukGmjqozYkm0iSZq/GvimTQhg7dwGT
	 dn30znEFrl7UKlCLw6ooNvAek2uHLKCTNkgGL7zo/Ak6N4NT2w4/nSHOkng8kIDuU5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JoX9YSyY;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D62E606A31B;
	Sun, 25 Oct 2026 14:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D62E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JoX9YSyY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792939767; x=1824475767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wuyAVWzNlf4WMUq3kPSPErfH5dgjJuFGGL+u8KZMwqg=;
  b=JoX9YSyYPo3YSEXEB9DgsDa5kB24LpEaPMOhIUITUv75fnbTIu3ts7PA
   sRRbBGqQP9zSclIYxFcGbt5E8lv38t3ap8sXcFq7LugNjcGc79mOo3pLr
   +6FkNVyVBczl8fDFx5ub9ps8W4teh2yS8YfWBfPlPtHjBtNohH8oiLaaH
   k2Mhg6elLGV2y2bfnY6qjhQRnl+Un1Bm2g7q8l91zKsTVo6lloEnldU3y
   u347VXhtTo03+D3uyw96hmXlZefmR7ROZfA+LHotkCxLiERytcdmrzKDV
   +t0lAhaFLajl0v6IDdpibRfopNG+JJwGVRRJCHBniK9vaKvQ0P6Kle62Y
   Q==;
X-CSE-ConnectionGUID: ny0dF926QfGUduMh+3G2eQ==
X-CSE-MsgGUID: ohqcIaBNQO+CfEm1VSYnkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1524417"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1524417"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 07:49:11 -0700
X-CSE-ConnectionGUID: eYmjATg5S1KYkRpA6TtrFQ==
X-CSE-MsgGUID: PrP7FVEiS6+DW/v+rR1Cow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4147140"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 07:49:06 -0700
Date: Sun, 25 Oct 2026 16:49:04 +0200
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
Message-ID: <at4WnVkovotMBmFe@ashevche-desk.local>
References: <20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com>
 <20261023-submit-h616-uart-fifo-v1-v1-2-e4a3bae2eba8@gmail.com>
 <atseYvQUYvpMFEIM@ashevche-desk.local>
 <CADvTj4pRW9q6VyQ=nLi8q0mMF8LgccfO4eqAeqgzzgOkDno1dw@mail.gmail.com>
 <CAGb2v65LVm1GV2kV4bVO8YJd16tkubHOvXUtbJ3uuBw2O3TBsA@mail.gmail.com>
 <atywVnHU5NsP_gOP@ashevche-desk.local>
 <CAGb2v64P2rM0VnFh0NfNhi+3_xGPYkxt2j+2hmBMu5ZvugHRow@mail.gmail.com>
 <aty37_xHO-QRa7hQ@ashevche-desk.local>
 <CAGb2v66jqrrix903k2OT-z0kV-9XWm6LpXmHQsCyLL5P6uXD7Q@mail.gmail.com>
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
In-Reply-To: <CAGb2v66jqrrix903k2OT-z0kV-9XWm6LpXmHQsCyLL5P6uXD7Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 11:10:40PM +0900, Chen-Yu Tsai wrote:
> On Sat, Oct 24, 2026 at 10:51 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sat, Oct 24, 2026 at 10:41:55PM +0900, Chen-Yu Tsai wrote:
> > > On Sat, Oct 24, 2026 at 10:19 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Sat, Oct 24, 2026 at 10:10:33PM +0900, Chen-Yu Tsai wrote:

...

> > > Ah, that's nice. I hacked up something [1] in the past to get it to
> > > work, but that was probably before you added the helper. I never got
> > > around to splitting up the commits and sending it out.
> >
> > Hmm... The helper is in the kernel for the past 2.5 years.
> > Maybe you rebased it and it lost original dates?
> 
> I had been carrying the changes locally without committing them. I only
> committed them recently to back them up remotely. So yeah, the dates are
> not accurate.
> 
> > But if it's not working, we need to address that, I believe it should work out
> > of the box, because the same function is used across dozen of serial drivers.
> 
> The new helper probably works fine. I can rework my code to use the values
> given by the helpers and give it a try sometime next week.

Would be nice, but I assume there is no hurry.

> > It might be an issue in 8250_dw.c, but I can't tell for sure.
> >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/wens/linux.git/commit/?id=e7e0741fa04f349ad9f94a4059e32467a30ef5d9

-- 
With Best Regards,
Andy Shevchenko


