Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121273;
	b=1TYgNo8ZOSmF9Ag/Y+FBhTWhr5uFJGngEGyiXVIKIDj89m2TDjUtrw2bdhFaJhTBYCth
	 aIqIh5Z1fPTZqD8NJ+wQkfcDdtEUQZGbYO3SPdUQ9XMBqud631RNNVz82KHFLC+u/woPK
	 H4qSElqyVZEDrLA3/ok82B5ogkAI9YfMzdOuilThAzHTXQMfkxpT4BW7xuEetMuB50DNz
	 pUzsjhxHAH27jixGMmNLxp/3WM/k8qipxskOsFmyLehcvLzfR3sBZihUhac9s02sV9uiv
	 gWXfqsZO/bZp/72xYLZKD/enFFNCswpW9PpMu0NX5JiEV1bxDyJFm856rlnBahsed/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121273;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=S85l8Woo2n42w+mdbtmL1Ny0tCWNmA/b6rF1AAZnA1Q=;
	b=0JozdsbuF6NpM8kX3cFoAdnyGbnAzaalO1kt6pmQU7ARjfthH/66fE/bpK6tVlu7tevX
	 lSdlhiiXk+V4Pe6JYw9Bd1OfSI2mshbW755HqL+kqjIEi1JYCfFv6dedLaINrHjlq8eqV
	 +wi3k+PGamiQgP86WAAA1i31Zqk7JeU/0q7tS1UBybDTJP1XVaYmEbdQ6gEBHc/DLUbbW
	 uiOh/mVDOpaJE8dQ+d8+c1EqgvKSt+as2fF74qOfe9+5wr8bngkX1WHotrj0rTW4kD4AX
	 r4aibKAEn0tsHs8vDUXIGuMHH4LDfNtsNkb4C1S1xXddJXJOlrFP49iOUNjyN2GvEsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JpGIu19i;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DD4606A31A;
	Tue, 27 Oct 2026 17:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93DD4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JpGIu19i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793121272; x=1824657272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z+AoUZ3Jbi8/yJc4Clk0h3Uwg0gBVBmsypOqa/x8S+w=;
  b=JpGIu19i3xH8QptRwV9j26JivpqEMSJFGpUs/oI/Kzg1ykrFPI7BrdEw
   rCpEiOOFnltWa9luGEjhmMd4mDeM1H2R4/PNotc95/Ioq+2le6ZFbfWkY
   pqrCHoWEIvvQTLIoWq1/x0/1tBtFuiHxPBVDSFOKHquFCurwNUMWd4AXH
   q+oi42QD6LYj937dOU+6fSswkZsbgWLUE+/ql/S+PT3jBT5bJl6si1ubR
   faouHAtsSaFGG922r8DcyE3xd10ejHIOAAwlBKM3j++/FXv1Bek/5OYvn
   8by3tSKQQb2AFZfh/bv4A1DktB44OK1yBx3M4kpevPn9p5XTXH0CTxBpl
   g==;
X-CSE-ConnectionGUID: mOrZPj48TEOSi/wVUyuvcQ==
X-CSE-MsgGUID: kFPXrstBTsuo1IzPnITcJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1737293"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1737293"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 10:14:30 -0700
X-CSE-ConnectionGUID: 0SfYDsRuS5q2Bbi+6x3gBQ==
X-CSE-MsgGUID: PMsHtbB0RTG1rZ4k3oBZWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6436944"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 10:14:22 -0700
Date: Tue, 27 Oct 2026 19:14:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Peter Hurley <peter@hurleysoftware.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Frank Li <Frank.Li@nxp.com>, Sherry Sun <sherry.sun@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Olof Johansson <olof@lixom.net>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Robert Baldyga <r.baldyga@samsung.com>,
	Thomas Abraham <thomas.abraham@linaro.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, stable <stable@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH 09/24] serial: 8250: 8250_bcm7271: fix DMA address
 truncation to 32 bits
Message-ID: <auDb57N7KCqaTWW0@ashevche-desk.local>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-9-99b0202ae546@linuxfoundation.org>
 <auC-_1Er0Kp-Wq76@ashevche-desk.local>
 <993d16f4-c8e6-4896-adf4-f7f36d937152@broadcom.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <993d16f4-c8e6-4896-adf4-f7f36d937152@broadcom.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 09:41:17AM -0700, Florian Fainelli wrote:
> On 10/27/26 08:10, Andy Shevchenko wrote:
> > On Tue, Oct 27, 2026 at 12:06:35PM +0100, Greg Kroah-Hartman wrote:
> > > 
> > > The local variable daddr is declared as u32 but assigned from dma_addr_t
> > > fields (priv->rx_addr and priv->tx_addr), which are 64-bit on ARM64.
> > > This silently truncates the upper 32 bits, causing upper_32_bits(daddr)
> > > to always produce zero when programming the UART DMA descriptor high
> > > address registers.  Change the type to dma_addr_t to preserve the full
> > > DMA address.
> > 
> > Since this value goes to HW, it should be u64. Even on 32-bit machines there
> > are possibilities to cover a bigger address space / DMA space.
> 
> That is one way to go about it, but since the size of dma_addr_t follows
> ARCH_DMA_ADDR_T_64BIT, we could also take this patch, and also make the
> upper 32-bits programming conditional upon CONFIG_ARCH_DMA_ADDR_T_64BIT.

You never know this. The use of u64 is simple as that: it goes to HW as 64-bit
value no matter what. Note, in the past we used to have a problematic use of
dma_addr_t exactly due to its dependency on the data bus size when programming
HW, and hence, based on my experience, I hardly recommend not to use dma_addr_t
in this case, use plain fixed u64.

-- 
With Best Regards,
Andy Shevchenko


