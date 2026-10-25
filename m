Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792941010;
	b=oO5wXSBIoCx+GYbuJ1SnK9Rh4YULdjJobISCFGUibQ1I6GP0O9tf7n/XMTiXFcx6XxaI
	 x5W850cZE1mVwq0WvU3CRJmSxR28AdOpb+HMhYCYQ2I8bhp8LpGU9GWWtZpN9l3WwlayB
	 mg1lPQ7r95dEqsk+0lIfqb5PGcQchbgZk6E91vWZ3G20Wl5RMm0a7VeVBL+D5F4ZVTugE
	 VJbVosulBpSc4maTpd6fq0kdFgA6D3BWYzYODKu1m6TTQw//n0W0BDpAmPJkyjF58se9F
	 jKMRTfptsWj1tpOpjitlJU2i1qNqM7/kqiwJs+CUSQ7LU2shZVu6cuIFaQT4/0H/T1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792941010;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=g9Cjhr9HIGyxWaiefhej0MIXutOky0k6Ipx1aCyOOYw=;
	b=kVhFM/Rsv08DSu8VL8YPfH+HS7wI2RmuEfaT5a+ljEcpl93uaF8+NVtWl8woJztccH+o
	 CsU0eDbsyTmTH8SvifTwJO3g1GZhEfVE63b6pPg88sQe6x8OrG4ecOBwoVe5hiPxBZLlY
	 lW9aeesrZwkOQldWcw+aYMCz3xD0FrPUACMRpciogR+5+/uH/lwEI3gUSSePIURyDJY0C
	 kjC78R0yoWB8rWYaYugLbQEiyYmTrmTnDXYaRxTbGFP/yvjt1qo3mDH54GMru+yHnLNP5
	 6SyyvD+jcsMQLl+rNzpdVIpR/20LZrr8EeS8/dwqAvL3rD3BJ2nJSLEkOKjOW7djNlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="L/X34Br4";
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89660606A31A;
	Sun, 25 Oct 2026 15:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89660606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L/X34Br4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792941005; x=1824477005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sA5QKtn9sanR6lQV8toNGWBsgGwYIwudn1w2NIqY2pw=;
  b=L/X34Br4RtJ9g88daUhCVMis2U/0g//FIMZ/h2VtkikoxoqaY8SGICED
   FiLhh2ZYNg5/6TYjziAsn0npDxM22e3aZwpkG+N6AYwj7Y2Lk9H63lqAo
   jTIEMAX1h3cEhh5KzdYllq+FzE7cqr208SK3J3E35G83Ou2eyXoKq32tK
   I8QVASIS3z/mBsdIjTJhWwDiMHJc4enA7evYT6VKDrVMrmGUhbd8LhlsT
   4A3lGmh77f1Y3purCXBqBhwZAhSCR93AqR3Bmk+koWMhLMiHVdC1ofGI9
   xY4o9uZkUBt50Vpm8jweqzHCwA992Qlx6FjLQ5xiakH7HCjYYWSwlIh2g
   A==;
X-CSE-ConnectionGUID: UGPNZQlURE2qWzPMFj/cLg==
X-CSE-MsgGUID: Ba+HitWRS92hfsBJoeV8ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1514233"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1514233"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 08:10:04 -0700
X-CSE-ConnectionGUID: m5yKUqx3Syu8lkGMnczCnA==
X-CSE-MsgGUID: IKd3c9pGR1yxq5RGFZfCAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4150612"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 08:09:57 -0700
Date: Sun, 25 Oct 2026 17:09:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: James Hilliard <james.hilliard1@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raul E Rangel <rrangel@chromium.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 2/5] serial: serialize asynchronous write wakeups with
 the port lock
Message-ID: <at4bw-G8czG-G7Wl@ashevche-desk.local>
References: <20261024-submit-serial-8250-dma-cancel-v1-v5-0-9e52968928d2@gmail.com>
 <20261024-submit-serial-8250-dma-cancel-v1-v5-2-9e52968928d2@gmail.com>
 <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk>
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
In-Reply-To: <alpine.DEB.2.21.2610250459200.42255@angie.orcam.me.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 05:10:03AM +0000, Maciej W. Rozycki wrote:
> On Sat, 24 Oct 2026, James Hilliard wrote:
> 
> > uart_write_wakeup() expects the UART port lock to be held. Several worker,
> > DMA completion and interrupt paths call it without that lock, including
> > indirect calls from uart_handle_cts_change() and the transmit helpers.
> 
>  Fair enough, and thank you for the cleanup and spotting the issue in the 
> first place, however...

He already issues a v6. I think the tactics against AI contributions should be
to not answer for a week or so until there will be a quiescent week. At least
that's what I learn from this patch storm.

-- 
With Best Regards,
Andy Shevchenko


