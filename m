Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B8A70820;
	Fri, 25 Oct 2024 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865071; cv=none; b=B8YmZ4DMJPwL9EomTg+sp2dzDwhJ7dWzDgVvWotQPuSHGQkmparfz70LlqQhqPaBVS8l9F98Zp6KzHoR1cJZBwHOuN65th3FoL29uFPdtJUgiwp20SwnfD++gkilAkiXmrm01Jvo8Me9sdSOjfdh0I77oUKLVpz0fjuwO/kpgTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865071; c=relaxed/simple;
	bh=vykQeynThE6u8FAc/pLYpmAljLUA5z/Z2yEelFtBZ+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7bHdPAVChVQUoTKzZP3elrE1Q+k2Tqji8ZH13k0s9u+e3xAGDrMBRF+rENW+XF3NxwHfrwe1FXz5R1PbpxbyHYee9o/O0/XMcHGKI8CAZpDGB923jhZpFmKbZiwHWeKTjaYkJi20fcnW5+GAzjm5BeTgNlNkw77kvkpwuzwl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggwNEXPw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggwNEXPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729865070; x=1761401070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vykQeynThE6u8FAc/pLYpmAljLUA5z/Z2yEelFtBZ+w=;
  b=ggwNEXPwr+dgyhSs4eCtjmzjVZM0El+F8z9fqGv1jtVhzBq66/sE5X0d
   rk6i/RJY40ATD2wBmi+qNeU5fPiKOfYoLiV2DGTbqu63RL/85a9OPAS4v
   9as6Pv6pTCSpn1VhgVcqSjd0oF9HHSxhCi2peOfr2z+DgMoxS+iD5y/Pc
   X6cQODEL3H3E+TVZOfc5pO8ir6AsPGVMqHqZQkhN1lxJHMmI9m0PRYknD
   jZWeWWjvCiUmbaus1Y2WH598NUoa4tPRyKJOZFh7i4AeZozP1nJgVXAQz
   53nUjoR5F+prfx6NHRM1r7sHYPZjf/kC/X60sIHCejcgoxXolLbbeHWh0
   A==;
X-CSE-ConnectionGUID: P8akttlvQrOONrri0dFTAg==
X-CSE-MsgGUID: j6IaSCkzSbOEyqDnuF8kEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52089958"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52089958"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:04:29 -0700
X-CSE-ConnectionGUID: HLP2qWM+QlKxHT0e7YHuZA==
X-CSE-MsgGUID: BT54Y1PtQKOx3Qk7It9WkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="118380276"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:04:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t4KvK-00000006vxH-0VKX;
	Fri, 25 Oct 2024 17:04:18 +0300
Date: Fri, 25 Oct 2024 17:04:17 +0300
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
Message-ID: <ZxulYcgH1kTyx9Kr@smile.fi.intel.com>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
 <20241025105728.602310-5-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025105728.602310-5-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 01:03:26PM +0206, John Ogness wrote:
> For RS485 mode, if SER_RS485_RX_DURING_TX is not available, the
> console write callback needs to enable/disable TX. It does this
> by calling the rs485_start/stop_tx() callbacks. However, these

It would be nice if you be consistent across the commit messages and also
provide the names of the callbacks in full, because I dunno if we have a local
stop_tx() or rs485_start() or whatever the above means.

If it is "the rs485_start_tx() / rs485_stop_tx() callbacks.", it's
much clearer for the reader.

> callbacks will disable/enable interrupts, which is a problem

toggle?

> for console write, as it must be responsible for
> disabling/enabling interrupts.

toggling ?

> Add an argument @in_con to the rs485_start/stop_tx() callbacks

As per above.

> to specify if they are being called from console write. If so,
> the callbacks will not handle interrupt disabling/enabling.

toggling ?

> For all call sites other than console write, there is no
> functional change.

So, why not call the parameter better to emphasize that it's about IRQ
toggling? bool toggle_irq ?

-- 
With Best Regards,
Andy Shevchenko


