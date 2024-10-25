Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FAA70817;
	Fri, 25 Oct 2024 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864704; cv=none; b=qPEFrnFxZR6wOl//2JQrWk/tI2qJcZ3YstmzFQGS1+8CF7yH/WPgW4nBRcvxeFGp6nNcYEPxtQH7iS8J6a01Q3njMNDEDoSfYq2X9Bd8+Urv+5jhK+6ajjOqLSXVrtEsFturwFdoE0bxeeB5gXb6jPDfverBvy4I1fJmAbBfS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864704; c=relaxed/simple;
	bh=6VuCN7L4Lvp32KsLOP8nEDd2sa9hW4SN48lK8/qBOs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1Y9ph2uoxEnvu55m24bFX3D29vk4ouTnugm1NglZQWsEfc7M99c9hmwXOH6xwblHIntvCHMebHawa/s6bsp2Enbiu2/xeYDhduGHYZ4VC0eEh5qe3HRB44kiEYjOHGowpDPQeq3F7LAH2mlZidO141B/vruumDrO5srKsnvm9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YD2yV3TP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YD2yV3TP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729864702; x=1761400702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6VuCN7L4Lvp32KsLOP8nEDd2sa9hW4SN48lK8/qBOs0=;
  b=YD2yV3TPjgLdKtAslGRvGTlrV6sJoSyQ8MB7dTGc7KE1vuJDSin+AgSg
   U++4ASu4UkawlRM49ahxisjPxe47e985aLRhpFZ7anaSF1HbnnoE4GXQ4
   JfuXwo1fh36J/2GlikhPQZUR6cqXX0IzFHDw8xubSuZbgBBFYx5pgaKVd
   jPhDBICDPp788PMLxClothNZWX3TLlHPuAi3eq2YCzDdxFoaLFuUrXstQ
   A7VHKNpPBXTg4VfAZm3zayLfwASiqIr/SbLmbK22mTwki6wg61knni/JW
   T7ZlPEtiUkwhRYQ5XCA39L7NNzxq/H9T1zC8Z/hUQu8ncOofmwm6XW03B
   Q==;
X-CSE-ConnectionGUID: 9b3PmEQqRdCpgbLSIAW0aw==
X-CSE-MsgGUID: 9f+ZVVDnQxyp5f8PxHm7rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33230980"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33230980"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:58:21 -0700
X-CSE-ConnectionGUID: w88ZmuEJSkyVWZn3ToWBVw==
X-CSE-MsgGUID: eUoBHrpMQXOmX3CvFN8APg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="104226092"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:58:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t4KpO-00000006vs3-1f5j;
	Fri, 25 Oct 2024 16:58:10 +0300
Date: Fri, 25 Oct 2024 16:58:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rengarajan S <rengarajan.s@microchip.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Peter Collingbourne <pcc@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Stefan Wahren <wahrenst@gmx.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Ronald Wahl <ronald.wahl@raritan.com>, Udit Kumar <u-kumar1@ti.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH tty-next v3 0/6] convert 8250 to nbcon
Message-ID: <Zxuj8rFQikEjr2gR@smile.fi.intel.com>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025105728.602310-1-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 01:03:22PM +0206, John Ogness wrote:
> This is v3 of a series to convert the 8250 driver to an NBCON
> console, providing both threaded and atomic printing
> implementations. v2 of this series is here [0], which also
> contains additional background information about NBCON consoles
> in general in the cover letter.
> 
> To test this version I acquired real hardware (TI AM3358
> BeagleBone Black) and tested the following modes:
> 
> RS232
> - no flow control
> - software flow control
>   (UPF_SOFT_FLOW, UPSTAT_AUTOXOFF)
> - hardware flow control
>   (UPF_HARD_FLOW, UPSTAT_AUTOCTS, UPSTAT_AUTORTS)
> - software emulated hardware flow control
>   (UPF_CONS_FLOW, UPSTAT_CTS_ENABLE)
> 
> RS485
> - with SER_RS485_RX_DURING_TX
> - without SER_RS485_RX_DURING_TX
> 
> The tests focussed on kernel logging in various combinations of
> normal, warning, and panic situations. Although not related to
> the console printing code changes, the tests also included
> using a getty/login session on the console.
> 
> Note that this UART (TI16750) supports a 64-byte TX-FIFO, which
> is used in all console printing modes except for the software
> emulated hardware flow control.

Thank you for the update.

I am going to review some patches at some point, but what I want to say here
is that if you have a new functions to utilise something, please also check
if the rest of 8250*.c may have an advantage of. It would reduce churn in case
if your series already exports APIs or provides inliners for such cases.

-- 
With Best Regards,
Andy Shevchenko


