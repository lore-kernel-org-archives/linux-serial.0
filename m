Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115394;
	b=cN/EySZcLq9EQh78KhBHKzGS2FWAZV+vMxCHR3GzFQPi6gL0OLTXNBx3XvNuGh9H23iO
	 b3mvGVSztXa0DHFzSU/u94J2xvIDGGIvTMWk7+oXmyMQgISczC/IP1iLtLkRtI7Dy9IX8
	 T+vsHX48F6Z5Zhr2Hmb4tneGwEGcV/l+8b7ogCdhr8jIooKVBumeyEkjNVWBdbJonAY7p
	 WnygBuajV+pW6Xr7ilPDAW4wJuk4WAcX1L/jiGVjTAgPkGz/4u4Qr/KiPwy37h12Lta84
	 j5Gv7ypfRkl1sSNeRcI6Cn/42Ws2nygVkxukr+BCLKnVNRwlKyh6v4B2iu+oLZaii5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115394;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=ogwM6JGe8dylNPS9rpfDlnZ3s+MH5SY8ZozS0ZEFy3k=;
	b=j1iDCtW2cpDxXHN43NFyfaD/9ddDv1sKmNRvWmuerNGjNljyEghrCFF0bxkixPw6utJI
	 Wji7LAMJEtqXoQY1qCu9r6UBeweL9KJYuXcy3mSOIkpKeX8dfs3MV9t5+obzNqi07QcZQ
	 /ZVzuad0MsJJO2etTJU8VwoieE+ITND7FCqcYt+IgukQYed+ohZ7PSI/2r8KwObkxkjYe
	 bGCTwhQIi9vyXOygIXkHOh5sSGty0lHVie/ttAfvW1kNcz/YFQ305C7vBeL5RawT7cwOQ
	 KLb6Pa0kgR3Wh5n10Rorz2858AQvmQIM+udibWWaQoHo800DrYS1YNy8Nct6BCsvFzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b6fc+K14;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EC6606A31A;
	Tue, 27 Oct 2026 15:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28EC6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b6fc+K14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793115394; x=1824651394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sT8tkxk9bWd1JTh91eqs1Duomnwt0SyB4cpBFIlYwIo=;
  b=b6fc+K147Lnfuw4k7sG4jJGwGx5Zb2xBuoywR6D0bbMj59dhrsXGfsaX
   UWtVAvSG6kSO9w1phNBSoIfUiaZU2EvemOQrIWgQMFOB5N/Qu8SxPv2mM
   sgt/kL1UkJ/Cm8VWdBuMNi2gb1y79prmseXlscllOCXuoGtOthe7wfCkx
   DYQfY9yAxp4t6mXj7/9OEjtwwaPCAVrx/fd058Js/3WZGL4RXTEVF8wws
   Jj1i3V/rL3rUmavQNyypYQXUX34oj5Bxt5ldjdP/Chlo4b0i8pprLHVHL
   ec5cpIEb2XfotSP7jwvrApzlBaOHX0ZrdWQn+NwskLYkuz0GyuNVJ8P9c
   A==;
X-CSE-ConnectionGUID: n/YJIdxORpakFmNZBWYtww==
X-CSE-MsgGUID: re1yUoJeTWOcRQEGGANJzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1713453"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1713453"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:36:32 -0700
X-CSE-ConnectionGUID: NGzJCECEQSKqldj8iemvIQ==
X-CSE-MsgGUID: drg/TW6aR0abig92xWGIvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4695508"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:36:23 -0700
Date: Tue, 27 Oct 2026 17:36:21 +0200
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
	linux-serial@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	stable <stable@kernel.org>
Subject: Re: [PATCH 12/24] serial: 8250: dfl: add bounds check for
 device-provided regshift
Message-ID: <auDE9bQUYp6BK6gT@ashevche-desk.local>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <20261027-tty-llm-v1-12-99b0202ae546@linuxfoundation.org>
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
In-Reply-To: <20261027-tty-llm-v1-12-99b0202ae546@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 12:06:38PM +0100, Greg Kroah-Hartman wrote:
> 
> The DFL UART driver reads regshift from the FPGA feature parameters
> without validating it, which can cause undefined behavior or
> out-of-bounds MMIO access in the 8250 core's offset << regshift
> calculations. Cap regshift at 4 to reject unreasonable values.

8 sounds pretty reasonable to me. I think this patch is odd as it's up to FPGA
what to set there. You need to compare a maximum accessed offset (taking into
account given reg-shift) to the BAR size.

-- 
With Best Regards,
Andy Shevchenko


