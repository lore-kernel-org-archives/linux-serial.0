Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vy890Kym"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184551A4;
	Tue,  5 Dec 2023 08:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701792410; x=1733328410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SnTk7nOHVSMIu9T+BADpl5VGVuyyj8VgRZf8UHPCHBo=;
  b=Vy890KymV9N3FgrONbWOj3/fQcDhlI0hd8ajIY0o6NjmzpcrfuBkz7/r
   s2cxGn8ck7qXazco3XlsYeZb9Wngq5SwMnZzt/vRpKq6Ed5HKecEOMAL6
   ou9E5wpv6bsaAFWeavyj3aiHa625uxgUKbhNVdfH/zypnkB1X89dNPZL3
   SkzURQa/EwLkYzqVISvUytt97vzcAI7obq5Bi27DYA6kYlTy2G09KbjAt
   cMoTgKmxTBjDGMFeiHOhCIbhO9qSVj7EawWcEf8l74fpfjDUs8uXMdjvA
   qjpHXtkUK/20Ldv9TY6XqLLwYeeFJHlpz/Nif3MQCky9klhFrCSsO3uoF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="392778993"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="392778993"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 08:06:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="747288930"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="747288930"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 08:06:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rAXwY-000000024zS-0y52;
	Tue, 05 Dec 2023 18:06:42 +0200
Date: Tue, 5 Dec 2023 18:06:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 3/4] serial: core: Handle serial console options
Message-ID: <ZW9KkUDnhD5d_nhu@smile.fi.intel.com>
References: <20231205073255.20562-1-tony@atomide.com>
 <20231205073255.20562-4-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205073255.20562-4-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 05, 2023 at 09:32:35AM +0200, Tony Lindgren wrote:
> In order to start moving the serial console quirks out of console_setup(),
> let's add parsing for the quirks to the serial core layer. We can use
> add_preferred_console_match() to handle the quirks.
> 
> At this point we can't drop the quirks from console_setup() because it
> would confuse add_preferred_console(). And try_enable_default_console()
> would get called before try_enable_preferred_console().
> 
> Note that eventually we may want to set up driver specific console quirk
> handling for the serial port device drivers to use. But we need to figure
> out which driver(s) need to call the quirk. So for now, we just handle the
> sparc quirk directly.

...

> +static int serial_base_add_sparc_console(struct uart_driver *drv,
> +					 struct uart_port *port)
> +{
> +	const char *name = NULL;
> +	int ret;
> +
> +	switch (port->line) {
> +	case 0:
> +		name = "ttya";
> +		break;
> +	case 1:
> +		name = "ttyb";
> +		break;
> +	default:
> +		return 0;
> +	}

> +	ret = add_preferred_console_match(name, drv->dev_name, port->line);
> +	if (ret && ret != -ENOENT)
> +		return ret;
> +
> +	return 0;

	return serial_base_add_one_prefcon(...);

?

> +}

...

> +	if (!strncmp(drv->dev_name, "ttyS", 4)) {

str_has_prefix()

> +	}

-- 
With Best Regards,
Andy Shevchenko


