Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368CF126C05;
	Sat, 28 Dec 2024 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735424348; cv=none; b=CF1Jlr3WPOlRBCPN5TcRXFvrYeP+H3djZpbFF0S3Gysjua6W4O+dIZ2kSbHDVQ+/wbDsFtDR+4ySMMkBQMvZKhyZ/770TvTNJ8n+2yxTu9FLtmnpHRl5X5yG4lFHVfkDmGEU8DjKXH+kSN4eTjEzspkhKm/0/qpGlJsvZALErD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735424348; c=relaxed/simple;
	bh=CYotyYWSmunaz27IymD9YuqOxnVhzREjrXIxHRrlV+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nydQ9OE9tSlkFUaUqso5dQmNCmUDlIYwFmcVsWCKD5eS6BYGtp4VuIyU9y1Idvg5jb93GnZ7SwXZTaL3xVtnuwRkLNMHCxERjDWiSkc5tNPMnRDB3gfv6Z3JnaO+CXxs/XJS7XR/lyufaM7nWsiGAfpPrE/recZqtl5UGUhOLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+xBlRmn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+xBlRmn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735424348; x=1766960348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CYotyYWSmunaz27IymD9YuqOxnVhzREjrXIxHRrlV+0=;
  b=O+xBlRmn3rHJJK8qRIwPMR/5EshTqqzVZKGdo4q18s4q6aof4XPBrWSN
   A0yOsuYlU3mvX2FOkLQd4Hg3xUjDQ+7hbct6+vZ9fLyNfTdKSshvYMPar
   K9qtGEZDhYohCqnFy+LD9wtTUsrTjqCy50LeCZ3TiOT69pMRVcCTKMkuq
   HgYWdIpiRkEdBV8kaB6yRY8j/omkKPL0AjGQS0EqVJEOM+4abNM6BrfPa
   wNpAqabQtWxuW54oktZQKi4gseewlj6QDqLB88JgMiXFBdFJvEAefZCDj
   PjTEBnvLRq6IblSZYlTQ1SVYLZgKKeJEfu0nGnZ4oKVH1lcEGfJTpwhPg
   g==;
X-CSE-ConnectionGUID: 7yv5QHomSI6fnHkKFxcGuw==
X-CSE-MsgGUID: AhWKmaefQJWjLTL4CVhbAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="35481716"
X-IronPort-AV: E=Sophos;i="6.12,273,1728975600"; 
   d="scan'208";a="35481716"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 14:19:05 -0800
X-CSE-ConnectionGUID: KcCQ2g4yQRC8OcKGelMC2w==
X-CSE-MsgGUID: pmsZWc/URWybCdhcsqflbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105434107"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2024 14:18:58 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tRf93-0000000DV4W-2WLW;
	Sun, 29 Dec 2024 00:18:53 +0200
Date: Sun, 29 Dec 2024 00:18:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Matt Turner <mattst88@gmail.com>, Stefan Wahren <wahrenst@gmx.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH tty-next v4 0/6] convert 8250 to nbcon
Message-ID: <Z3B5TQkz1S-C1wro@smile.fi.intel.com>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227224523.28131-1-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 27, 2024 at 11:51:16PM +0106, John Ogness wrote:
> This is v4 of a series to convert the 8250 driver to an NBCON
> console, providing both threaded and atomic printing
> implementations. v3 of this series is here [0]. Additional
> background information about NBCON consoles in general is
> available in the cover letter of v2 [1].

Just to be sure I understand the side effect of this series, i.e.
the

https://elixir.bootlin.com/linux/v6.13-rc3/source/drivers/tty/serial/8250/8250_port.c#L44
https://elixir.bootlin.com/linux/v6.13-rc3/source/drivers/tty/serial/8250/8250_pci.c#L9

are not needed anymore (the first one can be replaced to something like
dev_dbg() or analogue)?

-- 
With Best Regards,
Andy Shevchenko


