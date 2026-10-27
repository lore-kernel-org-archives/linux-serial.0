Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113873;
	b=SI4oxTDAR+UepNNC5Pl3lDCTAscsV9gm0lf3g/acNSR4kFQNUsNsPjPc7hhFq1+8LbU+
	 Sjtlq5NRmmuKnVQ+/QTpdM6/Jj1RCd3oDgqyJ876xf/mVMpY01Y4yGaSI2iwCh80v/cmv
	 yB+PvaiGh4ES8G3yFg7GSf+6ZjcM9MDCWDgez2dVJkyMQZlNZ6GZn0EcX8CJpU6VwKneb
	 BGrOyhf3nC5jvp+X5+KdXxoW2mQl1TXkX4F7AK0xpDC5d7O5pAQAczIMq9WsgEh8P5sfZ
	 Umka/HCx68beRiZX+be+IsvW5UxdNAAqshk5p/ww1gyHTQxc52BALrPF23HfwO0O1nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113873;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=jqoascS4J1xrxtLwHHAIg2Izm1gSs4oGkns3pfwc1iQ=;
	b=BBExqtjJ4siXVU8d476/az9xf6K+9fvFrwHL9b0L34lSSYJctjfpxWXsPvozrCyrNPl7
	 fVuNULGS4RgH6Cd8MVwyfpJvneWEqinwrTrGxW3GyQ6HIJ0S7VVf389nACiqZTGOtgEcM
	 sEzAziKJ20KoCXvMVgD44uBuCUFsrls47zYwzKBYQiZS3jUXymbT3qL/9qDlX3y6is0i/
	 SDGFYi82v+83rXELeFayrG4HFpbwfsjzp2ebHT+OSi1YNzYQEzy+4++h+DkKVzfmC0Wou
	 GiGV0af+k/1czJfAamnJetLq+TGBLuTdv7l3mr+0c+hb/8wSyCywQsD8idlmbbaciWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NkaS4vQ1;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A4606A320;
	Tue, 27 Oct 2026 15:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C54A4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NkaS4vQ1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793113873; x=1824649873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ht+lWxjxFQjahKK+nQbRKL3Gie3yJ91mjgPB+kUqqEE=;
  b=NkaS4vQ1Fmf6xT6cU1mld9yT3APIdNP+k7vk91xsRbfO+6Ca/mtyHhWO
   n+r+/7XQ2cQg2LpWMomdOJ4Tb46C8SMsZFWhXDgm6KpC2pcCXxguEeEzh
   zcOqOPgLwOfHC20GF9e6kWKlULolFh/b5KmfQ5jAzKI7D+52KTgfEJt68
   Zg/NGGIvgCWFQhV9YZ9RrqJrLWBQhE3CnYIlVwmM7yb8yZP5LC90V/uJz
   V1uNEIEvqN1ffP0IEDG7w8JzR8eJTSGnq0w+qLfTKpiY7tWSALCsMhlH4
   ZyIHqRGOafkSkG/LOeli0J6FKbD6kWtLyvvqqKif6cpX8GJdrH4HLBkzI
   A==;
X-CSE-ConnectionGUID: hQB9p/FyQMOjTrU8KPmQTQ==
X-CSE-MsgGUID: Q9vDurQoRP61KqkkNMiHJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1905840"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1905840"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:11:06 -0700
X-CSE-ConnectionGUID: vV+TPVzvRguZxExWATLPmA==
X-CSE-MsgGUID: XZ1cYataRoiIvngmHg9Owg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4904054"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:10:57 -0700
Date: Tue, 27 Oct 2026 17:10:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>,
	Florian Fainelli <f.fainelli@gmail.com>,
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
Message-ID: <auC-_1Er0Kp-Wq76@ashevche-desk.local>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-9-99b0202ae546@linuxfoundation.org>
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
In-Reply-To: <20261027-tty-llm-v1-9-99b0202ae546@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 12:06:35PM +0100, Greg Kroah-Hartman wrote:
> 
> The local variable daddr is declared as u32 but assigned from dma_addr_t
> fields (priv->rx_addr and priv->tx_addr), which are 64-bit on ARM64.
> This silently truncates the upper 32 bits, causing upper_32_bits(daddr)
> to always produce zero when programming the UART DMA descriptor high
> address registers.  Change the type to dma_addr_t to preserve the full
> DMA address.

Since this value goes to HW, it should be u64. Even on 32-bit machines there
are possibilities to cover a bigger address space / DMA space.

-- 
With Best Regards,
Andy Shevchenko


