Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F391B14F3;
	Mon,  9 Sep 2024 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875439; cv=none; b=TyU5Y4+oXKws94UtV5vRAgRlF4pjNhdBvWVYo1cvvBzgyD4PAIu3OL/sixER5RNO8P2Ze+wbGo0u002G37dbadLiOU8iV3zbk7bJnMpNL16XHBzRS5y8qd4kdBGh9B1qPktEY8tZTxEL5Zg5NGkLUfQKpCVjJ7tq4r/CAofgwe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875439; c=relaxed/simple;
	bh=o4rOS0CzQ5rPhhDK/93V5f1NvBFIKfEtauA5bUn6VVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uR0Sl1okVIZMSqArrS+InKG5m8lMCVbpMwsH/fjNwP6h1vjgh9YX5VtrRnGzxmFegb2tW6G8HTNDWwMnocqY5x2rJcRmhhcoUepnO/WIoeo5UNkFdGLPjGSQhFX2WCidz5DcwN7VFXASMLl9u5lE3X7TebkeAo3MFoJ9bHRfd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rs1AWpvM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rs1AWpvM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725875438; x=1757411438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o4rOS0CzQ5rPhhDK/93V5f1NvBFIKfEtauA5bUn6VVs=;
  b=Rs1AWpvMLeVr1SICpBja1jVKsTTiAIYmnPI+AgcP+bhuDLf0swqtX3Vu
   2uz7zhLnAQjUtqP25GTljRJaBu2FnHR4vt2jvX1SUVlwXCGAmUYBdqdJj
   G1ZVmdc0KoYWYtmw/vmQf2jYyLmq74PEXcqd96hn+SA0GBhedjV9/mQU4
   nMtj00qgcRCSpVAklPz9Tpc8/jnG8vCI3R9Au/9ey9+rI54QQeJvjUCtz
   rxlxK21Mb5F3vqQUB9hAcV7UChfeEfbiHmkk989bv3x6G9vIXl/VRKBsY
   RaEjNnina4A2+oKuVurZB2UpI+oqGOGxljtkRwtYk6VEa59+AeHVqcyfb
   g==;
X-CSE-ConnectionGUID: bUbqCJo6QhWnRuaGujk9qw==
X-CSE-MsgGUID: tGD8oeWoRK+nGEnrGv7jeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="28305244"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="28305244"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:50:36 -0700
X-CSE-ConnectionGUID: AVP+6Ok/T3yKJibYd1mFZg==
X-CSE-MsgGUID: B1mzV0whTr+EAHsgexMlvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="89901639"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:50:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1snb2S-00000006jxH-3uhm;
	Mon, 09 Sep 2024 12:50:28 +0300
Date: Mon, 9 Sep 2024 12:50:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH next v1 1/2] serial: 8250: Switch to nbcon console
Message-ID: <Zt7E5DrlPiXLNXXH@smile.fi.intel.com>
References: <20240905134719.142554-1-john.ogness@linutronix.de>
 <20240905134719.142554-2-john.ogness@linutronix.de>
 <Ztr3f8M2FaT2Rz1c@pathway.suse.cz>
 <87mskkdhwd.fsf@jogness.linutronix.de>
 <87jzfod9f2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzfod9f2.fsf@jogness.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 06, 2024 at 06:44:41PM +0206, John Ogness wrote:
> On 2024-09-06, John Ogness <john.ogness@linutronix.de> wrote:
> >> Wait! This makes the rs485 consoles much less usable for debugging.
> >> They might have troubles to see the emergency and panic messages.
> >>
> >> Is this acceptable? Why?
> >
> > It is not acceptable. I am looking into making the atomic part work for
> > RS485 as well.
> 
> So there are 2 things _not_ supported by the write_atomic() callback:
> 
> 1. RS485 mode. This is due to the need to start up TX for the
> write, which can lead to:
> 
> up->rs485_start_tx()
>   serial8250_em485_start_tx()
>     serial8250_stop_rx()
>       serial8250_rpm_get()
>         pm_runtime_get_sync()
>           __pm_runtime_resume()
>             spin_lock_irqsave()
> 
> Taking a spin lock is not safe from NMI and thus disqualifies this call
> chain for write_atomic().
> 
> If UART_CAP_RPM is not set, the pm_runtime_get_sync() is avoided. So I
> could only disable atomic RS485 if UART_CAP_RPM is set. But the OMAP
> variant of the 8250 does set this capability.

Please, don't add a new code which relies on UART_CAP_RPM.
The idea is to enable runtime PM for all users who provides respective
callbacks. Rather, you should ask runtime PM for this information.

> 2. Modem control. This is due to waiting for inputs, which can lead to:
> 
> serial8250_modem_status()
>   wake_up_interruptible()
> 
> Performing wakes is not safe from scheduler or NMI and thus disqualifies
> this call chain for write_atomic().
> 
> It would probably be acceptable to move serial8250_modem_status() into
> an irq_work.
> 
> I would be grateful for any insights on how best to handle these 2
> issues if we want full write_atomic() support for all 8250 variants.

-- 
With Best Regards,
Andy Shevchenko


