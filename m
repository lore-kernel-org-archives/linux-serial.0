Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D478A199938;
	Thu,  5 Sep 2024 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544437; cv=none; b=tmLxW13hgnPlk9AKPhUOzdhmu3SJMHbeDgPoXkU9yuo9x59oewaA5b4B6lHyDPLb+Ub7fTuH9qV+8hD8/q87R9spwLG0o6cxFSxJvJpoX/eF3WUQzeg3JsyNp31nl51837x9YZ1kul6FzkW66vrS2xj7iGDhNGz4FK+J85V/E1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544437; c=relaxed/simple;
	bh=ldpMruZmOqq5mhdXAGLxXTdCZJ/TZ6YWaXl34z7WL7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnkWl0cAKAGfHNSc/nFTYJipAhByOmy+V2qZyFMS5FXzxABoKs+V5jEur0wUZOBqP480BptzwxZ4byrRon4NRXEVe7L8cIiGpYKkYXmCSseiew6I4t+jyIjGr5BsMQsPP8qy2aQD1WfbdmB1OUP9jWKRev3LQBtSusv7TND+qGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lyHTfygO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lyHTfygO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725544436; x=1757080436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ldpMruZmOqq5mhdXAGLxXTdCZJ/TZ6YWaXl34z7WL7c=;
  b=lyHTfygOy2kZFZB6mlOonVx4JzsJepIwJeWpNXCGoDpY8rCoPrfKBKcX
   8KuDZ7MV8722Y/IHl7E9Xfpjl1SL+UwZ4FzgQz6brxWzxpFyPwUm4pdIZ
   nO7PuYp7XZoDneV/mb6XynfJrhAfNFpKtzRL5GRiNINW5yBdsuR8Yj6Kg
   wtcv18oh0I2GRz0IiUSbCJ+9A59J1A3cDC26I5oTo6Agycm4+JPWN+Hdk
   NUy1/FoUs3IvHV1887yv79ESi4WSnkmjFjS6JVpgmuWNzAREEv9Jqnpgn
   EKrKqkPh4NhqB0Ibf1asmVjfJHdRe9baNwWi4pXsgSJvnIW4yirt0ML4j
   g==;
X-CSE-ConnectionGUID: 2Mw24WXKRxCyGbAT1UeGFw==
X-CSE-MsgGUID: 4jbRu4qgTniczEkZev9RRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="34926614"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="34926614"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 06:53:55 -0700
X-CSE-ConnectionGUID: CIZf5RD5Rtm3Rp8Eq3xcig==
X-CSE-MsgGUID: CwJZnJ4kQimy8JftNu/arA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70045366"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 06:53:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1smCvj-00000005Phr-0ZLy;
	Thu, 05 Sep 2024 16:53:47 +0300
Date: Thu, 5 Sep 2024 16:53:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Derek Barbosa <debarbos@redhat.com>
Subject: Re: [PATCH tty-next v1 0/2] convert 8250 to nbcon
Message-ID: <Ztm36qPI7fVteSX_@smile.fi.intel.com>
References: <20240905134719.142554-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905134719.142554-1-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 05, 2024 at 03:53:17PM +0206, John Ogness wrote:
> The recent printk rework introduced a new type of console NBCON
> that will perform printing via a dedicated kthread during
> normal operation. For times when the kthread is not available
> (early boot, panic, reboot/shutdown) the NBCON console will
> print directly from the printk() calling context (even if from
> NMI).
> 
> Futher details about NBCON consoles are available here [0].
> 
> This series converts the 8250 driver to an NBCON console,
> providing both threaded and atomic printing implementations.
> Users can verify the UART console is an NBCON console via the
> proc filesystem. For example:
> 
> $  cat /proc/consoles
> ttyS0                -W- (EC N  a)    4:64
> 
> The 'N' shows that it is an NBCON console.
> 
> There will also be a dedicated printing kthread. For example:
> 
> $ ps ax | grep pr/
>    16 root       0:00 [pr/ttyS0]

Wondering if this can use the DEVNAME instead of opaque (to some extent) ttySx?
Or is it using the same what has been passed to the console= kernel command line
parameter?

> Derek Barbosa performed extensive tests [1] using this driver
> and encountered no issues. On the contrary, his tests showed
> the improved reliability and non-interference features of the
> NBCON-based driver.
> 
> Since this is the first console driver to be converted to an
> NBCON console, it may include variables and functions that
> could be abstracted to all UART consoles (such as the
> @console_newline_needed field). However, we can abstract such
> things later as more consoles are converted to NBCON.
> 
> John Ogness
> 
> [0] https://lore.kernel.org/lkml/20230302195618.156940-1-john.ogness@linutronix.de
> [1] https://lore.kernel.org/lkml/ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb

-- 
With Best Regards,
Andy Shevchenko


