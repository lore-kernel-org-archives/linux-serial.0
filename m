Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118753;
	b=maxzKvbRRYWpp00EPfSqNgu6KEtwEIngGK5XRA6saK1AiAOL1u58HyQAOkFYhDI+KzKS
	 GWxYrcXqsXw8Oo0vZuEbEvKxRHkHLZzekNvhalmbdLXDGAi7xRCX0sSJBUGXq51y0X0hJ
	 Ynh5X486BCm1lLff3zkYWDDHkBD9qABbWiF4BP+wC9U2UKsB/2QtZKCYFJy9Xq6htjMMS
	 dciZA+VZoDH2AVMegjiFVnZD9o/HoFcnoJ+/vctmkgXo/YPlytXSyWiIMX0lxGwtXUnyZ
	 U4NwKZ5k6epYqJh/UYPMVRSiC0HA+kveYeLXfsMSH+c3aXBBTN5rCemI5zcmliWUbkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118753;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=nW4bn8E5eZWGG6/KqJMWcUD1PsGrGFy7Fu7LcITxh0c=;
	b=qP+Na2c/zU1To91vNxSk1VQdQ40ApuJnyoIpNmCKxFdsTwAlkRKKLuhOAfsQWH9HMeuk
	 1LZYejgxmQh3fYoRaQ/VjyfJQ0s5noYFA6qsctcq2bQ5/NxdwTvtmEuCwXJxpINWUjIhJ
	 il1qaf7tCUHQ9Lpbk5k8A8u+f8bgyC9SqjyH0BitpLaSPVKM3YZ6Sl2eRX2ofs0QpZeES
	 m8puP6aiB4/TmsyRzh6gIiYH2fzdugm04eTg1z9PmDFG4L67PGKoK6Xc0WSY2EcOThtLu
	 Q+lgv0a79b15fI2y7zHLe+My01tggAYSOGU4qBBnfBgr/5gYopY58OgzR6cTXuyyZ4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A+Ek0181;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EF6606A31D;
	Tue, 27 Oct 2026 16:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14EF6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A+Ek0181
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793118752; x=1824654752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8J6LRfQpSdprcBJFd9RHHER10O5PMspv+WQoLrxJLX0=;
  b=A+Ek01817YXCQN5TmuZJPfS1nS99Lopbea5zPmuvKjzZHOl7sY6I5sCO
   UeB7wB2OO+JmLnFV6JA4sEeqyRXi6fhlM22+W7nJhBQj3oFg87xy7pnRt
   L0DYQueege9mdkzV2LbXIm0M0IdOUYrG5Zp6E3YOAguGdkWkGH1I8liwy
   V66BLoOeCbH9gs99kavoDLnOS/DD82o1tgGXlaVSC7M4ddCKOKkjric7G
   o2L+3IGWBsb6LbHpqDckRwTnRc/IzlxIHpdl67v4DWNDlCV9k5rvrwyxT
   dZXBF5lCoKU0D32+mYfZ5XJrd7NurTHhw58BNoYq4G1u0U8LAbwn/8+fe
   w==;
X-CSE-ConnectionGUID: ZyjqEX+KTX+KbNyt0LgkrQ==
X-CSE-MsgGUID: 69olwEu3S/yIrL3dwyf3iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1711552"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1711552"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:32:30 -0700
X-CSE-ConnectionGUID: DzWFxx0hSCy2x/iY267W/Q==
X-CSE-MsgGUID: rFu+AlftRfeC6TVmjsok3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4686820"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:32:16 -0700
Date: Tue, 27 Oct 2026 18:32:13 +0200
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
Message-ID: <auDSDaSDNFtgS94W@ashevche-desk.local>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
 <auC99yMtPR0BGiiH@ashevche-desk.local>
 <2026102706-consensus-neon-ed05@gregkh>
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
In-Reply-To: <2026102706-consensus-neon-ed05@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 04:50:43PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Oct 27, 2026 at 05:06:31PM +0200, Andy Shevchenko wrote:
> > On Tue, Oct 27, 2026 at 12:06:26PM +0100, Greg Kroah-Hartman wrote:
> > > Here's a series of some small llm-found fixes that have been sent to me
> > > recently.  Most of them are just minor bugfixes and locking cleanups,
> > > but they are good to have from what I can tell.
> > > 
> > > Submitting them here to get a solid Sashiko run and some second eyes on
> > > them before merging if all goes well.
> > 
> > Since it looks like v2 might be issued, can we move all Cc lists in the patches
> > outside of the commit messages? (Usually it can be done by moving them below
> > '---' line.) This reduces a noise in the commit messages and allows to see
> > better history on a single screen page.
> 
> b4 doesn't do that "below the --- line" mess, but I will trim things
> better next time around, this was a mess, sorry about that.

Actually you can achieve that by keeping them with --- locally. Another
possibility is to use `b4 trailers`. It was a useful discussion here on
the topic: https://lore.kernel.org/lkml/20260123113708.416727-19-bigeasy@linutronix.de/
(read the patch 18 subthread).

-- 
With Best Regards,
Andy Shevchenko


