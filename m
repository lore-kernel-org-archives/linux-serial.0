Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113609;
	b=5BEEXpElIN6jueddn87qmfDtms13Jht64RrT2rIMhDi1IEyZFeNDqFO5G3HjbCCHs+u/
	 SdKnRlNpFGKdN2pGccvgihnxS82G/lC6G3WNPiZGHIyUREKY2mGUC9BsIl+X5+eDF313f
	 EwdHVvg/CFUD6FxPwxl0/F80b8WUe12EpueDqpTuv7gTK3LArf6HMKBF3QpyoVkKBoCJF
	 smJZSjksuK9z19BmOG9kYqbLwoGeXTTgr873qSEzcEpXqlW5B3bl1kur/8NuK30Z0GMfc
	 jlSDRx6Y8U6fUpXDr0Tvv5nSVPcBqWbwU+Pt7vN5kf4czmGmHsw+5TPcN67XiQYekyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113609;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=/CiBhPEQj6cAi0ZZmYZB9BXpBu9X5Xh/q6Jl6so5S/g=;
	b=cBO6BNXnyIXVGRExIoApzwWPCKENA9+8G9iP8codxkg/ij5F2I1Rib2cQMuuSWw5ok/+
	 J6dEVvH+CTJMysWKQB7DIykx14iFe8mhkM80pzkbtHnFg4n8wM4rnVwGmu/eSs6xHz+qv
	 jr2APwBlbY3woXKl/BR4vwUQW0lSI1a1fI6RrFpjGfVk2af6CCSd1HZTAz3H9XBV8OCBZ
	 fE/YVq8z7YiZzwuQ6oBXB0F0a+lCYAfqSUZxO5koTs17gLk+DEP8yMOhkfEgbVZbyChUr
	 ucNtNyq5aHNmH6tOXTXs/YXTVJXyCavQx3EZCkvxKSe2YctiPcIJPluQEZOR2n1GahQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gAmMX1Cv;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993E8606A31D;
	Tue, 27 Oct 2026 15:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 993E8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gAmMX1Cv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793113609; x=1824649609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ox52ksZJXiJ++5z3H2ynQEZ7CXKJ7l0hy8ShuYOszT0=;
  b=gAmMX1CvF/j97TUD9nZTnfiU2ag2sD5uxEw5p09apZueWfSx5GlNqI+M
   UItP0+ekJ7jF0ZSZLWg/sDYfOkphQdFBg/GsUrE1Fghd5/F/vDBNgj/Z7
   i3xMQ2BRFk7aCNYDKRekD0lgsRiGs4U9gT7HL5AvnNpGkxzK071/e7u7E
   5CwsQy8kOh7uNPSiNoiuCNUJyPPPmHvrwbJHGN5jFSFzWdkaVE5mPNVMn
   8EpHyc3Ie8JcimrEu6U2DMSc9dPUN4rGR+epYQknm6YzVOKnRKMFqFfwD
   h78nW+VG4g5BTJ4eSGMehubAYuZyOIaNB9u3RgZ1fC0EDi3codAfeI2qw
   g==;
X-CSE-ConnectionGUID: eqIOKoFBQUOY7TsPhVmpUw==
X-CSE-MsgGUID: QhLrm5l7RZWGXibg8vWaEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1905220"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1905220"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:06:47 -0700
X-CSE-ConnectionGUID: a7xyBooxQtOtLMHAvCWwTA==
X-CSE-MsgGUID: a95+ojVMQh6ffzzET14idw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4902907"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 08:06:33 -0700
Date: Tue, 27 Oct 2026 17:06:31 +0200
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
	Nicolas Pitre <npitre@baylibre.com>,
	Kees Cook <kees+treewide@kernel.org>, Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Randy Dunlap <rdunlap@infradead.org>, Ronan Pigott <ronan@rjp.ie>,
	Liav Mordouch <liavmordouch@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Johan Hovold <johan@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Tony Lindgren <tony.lindgren@linux.intel.com>,
	Tate Whiteberg <whiteberg@arista.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Petr Mladek <pmladek@suse.com>, Moteen Shah <m-shah@ti.com>,
	Kendall Willis <k-willis@ti.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Marnix Rijnart <marnix.rijnart@iwell.eu>,
	Danilo Krummrich <dakr@kernel.org>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Linmao Li <lilinmao@kylinos.cn>, Peng Fan <peng.fan@nxp.com>,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>,
	Robin Gong <yibin.gong@nxp.com>, Pan Chuang <panchuang@vivo.com>
Subject: Re: [PATCH 00/24] tty/serial: a bunch of llm-found fixes
Message-ID: <auC99yMtPR0BGiiH@ashevche-desk.local>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
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
In-Reply-To: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 12:06:26PM +0100, Greg Kroah-Hartman wrote:
> Here's a series of some small llm-found fixes that have been sent to me
> recently.  Most of them are just minor bugfixes and locking cleanups,
> but they are good to have from what I can tell.
> 
> Submitting them here to get a solid Sashiko run and some second eyes on
> them before merging if all goes well.

Since it looks like v2 might be issued, can we move all Cc lists in the patches
outside of the commit messages? (Usually it can be done by moving them below
'---' line.) This reduces a noise in the commit messages and allows to see
better history on a single screen page.

-- 
With Best Regards,
Andy Shevchenko


