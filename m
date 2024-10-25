Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE9C2003DC;
	Fri, 25 Oct 2024 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866887; cv=none; b=NPAwiwzuGGHSVEBIvNn7diiVO9560NSZoV0IUeGarHekljr8YSyk0RiEMDwX2MShm6rMdD18gceT2mMcR6ZoWX1NauSbsu0XQfyIaI0ju47THicsNpJZAR8/Xmr4IEi3ZCqSUWlkJhjyRxYWyDvvn6heecLWasBGONLpzg46sK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866887; c=relaxed/simple;
	bh=7viiuER8jbmujoSNmtJXcCtGTp3mpZ8PS5MMH/KdKno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8tVuN11BAJfz7sjC/9wCTlFXM1Mvwy9fxhZt6YiGftKZByOpHc0U5ObPq5LAY3W7V8JdQhV5U0MvfPRXLcoCjUgUveCo0Xrie+hTa1GX9Of16qZDmebSQOTME9dFrlkWQD0EO87jbaJJX7lji/dkC5J3qcAekI9cTx7k0ev1Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/Zj6D8o; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/Zj6D8o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729866886; x=1761402886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7viiuER8jbmujoSNmtJXcCtGTp3mpZ8PS5MMH/KdKno=;
  b=H/Zj6D8o73gImFcVHF3QAVJinEB4jdVheu+zWqY0axs4ydvqm9rL5GvV
   4lZpGVrG2IHL9DsZHl2TedQ6bONSuLtOu/UOETgJCJ0ifXaTmilNQ1TUv
   ZwhNwvHIv2QTV2CZO7oRbNJCmitF9FNed6qiauLHr9Dv06OtQHgQQXV3b
   pql0XPcRRO6d5sjNk5pShhzGiSE2tZpQr9BpJHkpDAcU6aRWZaSejLQTa
   z21DuNbEelL60b7AUR47Jw/+YZG7Ktu+uNI5L+yQ1xA3oZjmjjfwBm1uK
   wDlUJZyjNqHjbBTNuCi55HwcXv2Nl43vsD6LBw1eZ2M9VJg1qiT5fDRfK
   w==;
X-CSE-ConnectionGUID: 2emJ9bf/RUWJhb3K6spZlw==
X-CSE-MsgGUID: cKQu1/hkTTu+xvv6peCn8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40642751"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40642751"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:34:45 -0700
X-CSE-ConnectionGUID: byLy1efMTj6exO2UKV5Ynw==
X-CSE-MsgGUID: 8C37kqSxTve1124j9dGQhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="84889931"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:34:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t4LOc-00000006wVK-3qoB;
	Fri, 25 Oct 2024 17:34:34 +0300
Date: Fri, 25 Oct 2024 17:34:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
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
	Rengarajan S <rengarajan.s@microchip.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH tty-next v3 4/6] serial: 8250: Specify console context
 for rs485_start/stop_tx
Message-ID: <ZxusemBwE8t9cAZ5@smile.fi.intel.com>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-5-john.ogness@linutronix.de>
 <ZxulYcgH1kTyx9Kr@smile.fi.intel.com>
 <84v7xg2rb2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84v7xg2rb2.fsf@jogness.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 04:31:05PM +0206, John Ogness wrote:
> On 2024-10-25, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >> Add an argument @in_con to the rs485_start/stop_tx() callbacks
> >> to specify if they are being called from console write. If so,
> >> the callbacks will not handle interrupt disabling/enabling.
> >
> > toggling ?
> >
> >> For all call sites other than console write, there is no
> >> functional change.
> >
> > So, why not call the parameter better to emphasize that it's about IRQ
> > toggling? bool toggle_irq ?
> 
> Currently there are only 2 users:
> 
> serial8250_em485_stop_tx()
> bcm2835aux_rs485_stop_tx()
> 
> The first one toggles the IER bits, the second one does not. I figured
> it would make more sense to specify the context rather than what needs
> to be done and let the 8250-variant decide what it should do.
> 
> But I have no problems renaming it to toggle_irq. It is an 8250-specific
> callback with few users. And really the IER bits is the only reason that
> the argument even needs to exist.

Maybe toggle_ier will be better than? I haven't looked deeply into the
implementations, so choose whichever describes better what's behind it.

-- 
With Best Regards,
Andy Shevchenko


