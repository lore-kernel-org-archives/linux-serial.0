Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792849911;
	b=zuE2oU0hAiXtMh4bQj9LxBPZNIuep0PG/C4On1M0DfPuI2/i1tx5P1Wj13ewLIMyOVpD
	 OkzBxKOeRtVXGg9JJ2ASEyBL1wP7TFxXrT9Z/0IEVkC5ckGo7dcsNLGKB51CnkMvoXoKf
	 MiSSLy/Se2mYWXWO9vePD4hYlyt0BLbz4XN47axtrhpZcOHu5kInCzSwBTp/ALZg+tXUf
	 6NXEM4qTfDNI2LIO5jB0w2peOurLzdM+5I9sGS5duovDQ3CWZMBiA44xQfsY8D4CYnpvt
	 lh/R5T3i9zquyndyOR854nVIfRav+ZA0qGPUIbDldyCuYQEfjsjL10xbj7WKqigNFVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792849911;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=VNvuAkw7QkT+wvTWGaXbgJXLIuhwrQN+czM0d14/REY=;
	b=jI9e7QKPxmkNNT4Mv0hvlKldc1foeytYO+he/ae1zCpwAb8J7W+59/1u6RdCZPB6MmEh
	 6JM6auDAhP3+LYvDJGCxqoJOJHJpKIefYLH/UublQAoSuc+GI8qFHbD7OfetCW2Y0wMzy
	 4XLa6XFmDnlEUS5PecXPLgQEdFukJWRnaMzrZgxzYc17lXexUcsu067c7ZayODqAhwYk+
	 /KwiflzZCAmTWrZL1oL3YydYoUK03st7fpt5Gv5vodljjgdS5uFA760Bph+AXWjYRo91Z
	 IIKqo2fzVtwgGwgk2qo1zSRCgn/2NgCFs2tlM2JaCTKRgVG6W0Tu9PEUrNIiFZ2M/9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Xpkpr/+H";
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2228606A31A;
	Sat, 24 Oct 2026 13:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2228606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Xpkpr/+H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792849910; x=1824385910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iHJ1jsMSG70HKpCFDLvKZwZhUAtFu0nbkgAE4wJmOhw=;
  b=Xpkpr/+HI1+YcneekDWUSXVBge8WTc1L85ONOggj6ZFbKkuIk1Ov1izd
   0tvc74uLZXgsgxnI28qjqzjm4nOE4nPtk9OgV281D93ie6NnroE04WY48
   240yN30g6E1M3fhDGmFybhoYfGy6FAw7LlAQJjE0p9lc/R1NsU55Zn0Nl
   N1oIhtcHafxgBg3KokgZznuPWuxfitcWeJcvJL1wuRosys6dR2y//hj6z
   6xhEyZYp8Iq8I+8uALNk0zD5AW2senit79acnKjNgZQDrBCvMXsr08EWa
   FqbuPqfLi94+OacHjy3ix722Fh7hxfjbGZFNl7qSxsXXT+aJbAyier9yb
   A==;
X-CSE-ConnectionGUID: sDpfsBSoSwWrt4FeX+HmHw==
X-CSE-MsgGUID: 87Uu71dPQg2AZBjFi+Em2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1611733"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1611733"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 06:51:49 -0700
X-CSE-ConnectionGUID: rRmRkfmSTlefUQGWbtXKBg==
X-CSE-MsgGUID: OFOQLRY0RwuYkVOu9WHwaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="3751173"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 06:51:45 -0700
Date: Sat, 24 Oct 2026 16:51:43 +0300
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
Message-ID: <aty37_xHO-QRa7hQ@ashevche-desk.local>
References: <20261023-submit-h616-uart-fifo-v1-v1-0-e4a3bae2eba8@gmail.com>
 <20261023-submit-h616-uart-fifo-v1-v1-2-e4a3bae2eba8@gmail.com>
 <atseYvQUYvpMFEIM@ashevche-desk.local>
 <CADvTj4pRW9q6VyQ=nLi8q0mMF8LgccfO4eqAeqgzzgOkDno1dw@mail.gmail.com>
 <CAGb2v65LVm1GV2kV4bVO8YJd16tkubHOvXUtbJ3uuBw2O3TBsA@mail.gmail.com>
 <atywVnHU5NsP_gOP@ashevche-desk.local>
 <CAGb2v64P2rM0VnFh0NfNhi+3_xGPYkxt2j+2hmBMu5ZvugHRow@mail.gmail.com>
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
In-Reply-To: <CAGb2v64P2rM0VnFh0NfNhi+3_xGPYkxt2j+2hmBMu5ZvugHRow@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 10:41:55PM +0900, Chen-Yu Tsai wrote:
> On Sat, Oct 24, 2026 at 10:19 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sat, Oct 24, 2026 at 10:10:33PM +0900, Chen-Yu Tsai wrote:
> > > On Sat, Oct 24, 2026 at 12:12 AM James Hilliard
> > > <james.hilliard1@gmail.com> wrote:
> > > > On Fri, Oct 23, 2026 at 2:44 AM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Fri, Oct 23, 2026 at 01:33:50AM -0600, James Hilliard wrote:

...

> > > > > >       /* Internal 8250 only */
> > > > > >       UART_PORT_AIROHA                = 124,
> > > > > >       UART_PORT_AIROHA_HS             = 125,
> > > > > > +     UART_PORT_DW_APB_256    = 126,
> > > > >
> > > > > Why? Besides the poorly chosen name, what prevents us from modifying the
> > > > > corresponding parameters at probe time by leaving the one of the existing
> > > > > types?
> > > >
> > > > The new type was primarily a way to reuse the core's FIFO configuration
> > > > table, including the RX trigger mapping. H616 uses thresholds of 1, 64,
> > > > 128 and 254 bytes, whereas PORT_16550A maps the same FCR bits to 1, 4, 8
> > > > and 14 bytes. Overriding only fifosize and tx_loadsz would leave
> > > > rx_trig_bytes reporting and selecting the wrong thresholds.
> > > >
> > > > The core already has get_rxtrig/set_rxtrig callbacks, though. I'll rework
> > > > this to retain PORT_16550A, supply the H616 FIFO parameters during setup,
> > > > and use those callbacks for the correct trigger mapping.
> > >
> > > Please consider just taking the FIFO size from the DT. On some chips
> > > not every UART has the same size FIFO, so we already need to deal with
> > > it.
> > >
> > > Also, FIFO size is a standard UART DT property, though somehow not included
> > > for dw-uart.
> >
> > FWIW, it supports all standard properties for UART.
> > Check what uart_read_port_properties() does.
> 
> Ah, that's nice. I hacked up something [1] in the past to get it to
> work, but that was probably before you added the helper. I never got
> around to splitting up the commits and sending it out.

Hmm... The helper is in the kernel for the past 2.5 years.
Maybe you rebased it and it lost original dates?

But if it's not working, we need to address that, I believe it should work out
of the box, because the same function is used across dozen of serial drivers.

It might be an issue in 8250_dw.c, but I can't tell for sure.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/wens/linux.git/commit/?id=e7e0741fa04f349ad9f94a4059e32467a30ef5d9

-- 
With Best Regards,
Andy Shevchenko


