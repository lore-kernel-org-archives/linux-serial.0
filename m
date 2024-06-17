Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A59717FAD5;
	Mon, 17 Jun 2024 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608873; cv=none; b=luE56z+6xDM86SnaydYmp8WXYPSpxClrfKW4UaMcfWHzn3sYu6SAQBu6gXmXIQvUdEGMvp4U5W2fS9IpCUQ/3H8gmY7MThvjComCr/DWkAqQYboL36/iaNSGJ4gfHIG5i2UUwXrQLfcxSvcsM6AjuaU5j4LGLPHmcBgal/NN6s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608873; c=relaxed/simple;
	bh=O8Hy80m1dkmGDc4hbtH/h2WUC7hkN9rLxTmJoaCc+EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaB2svwPmr6BvHB8gpXZHa41lZRsOvpNZuaB3EWGdGd+EpMI7FXDFe9DDxGv3ty6aTWkZfbGWSDOmo5WZ5fabXQD1v+mFn4CIaeOUL+f7pOqOw4bgDvqStd6NaEl753Y2F855mJNhRil70XcjP2XAsXQUYs69RGN3DDaqUWr4ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSzoH4T9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSzoH4T9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718608872; x=1750144872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O8Hy80m1dkmGDc4hbtH/h2WUC7hkN9rLxTmJoaCc+EQ=;
  b=VSzoH4T9d4o/yjJkGxichdBzSlbrjJ0tJZVuMMf1CFmr4hP6lyi42LPp
   QjcsqnIKYXcQKLI6ZVLO7MY+Itd7MtAiRmek7YUM7PjqhlNBUitXoNoRW
   Rh/OcSBCnZb/qjmzd09Ks8oBb97glp5j+ZPQclZey3UDK7ybDNEKhi9UV
   Iz9kFq6MPGWs3tb4jLytpjCNyxTabFKumnfhSnPmtxsKrc6jA4ZsQfOL8
   K3ENls9cz157RraDElCLHNnMxBHcQtrGAx/JjmJWJRuQMceSJiMB8OjG4
   GoVsylqN4BLeoLZ3/kdvxtw0zFErI+v70yzJ8HIG1+Q1ezVpT9JtYiBhh
   A==;
X-CSE-ConnectionGUID: 2BoNlrfkTq+hpx5P+pwEYw==
X-CSE-MsgGUID: P+MOmck7RUiiNAilyDMhww==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="26539796"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="26539796"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 00:21:11 -0700
X-CSE-ConnectionGUID: 7BxMNkWdSwiCNXhWmUEidA==
X-CSE-MsgGUID: jmEXVlR+Q3OlPcqkr6+JLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="41812495"
Received: from unknown (HELO tlindgre-MOBL1) ([10.245.247.243])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 00:21:06 -0700
Date: Mon, 17 Jun 2024 10:20:57 +0300
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] printk: Add update_preferred_console()
Message-ID: <Zm_j2eq3QcaA-g-e@tlindgre-MOBL1>
References: <20240613125113.219700-1-tony.lindgren@linux.intel.com>
 <20240613125113.219700-3-tony.lindgren@linux.intel.com>
 <Zmx7IPQX4FVdSe1J@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmx7IPQX4FVdSe1J@pathway.suse.cz>

On Fri, Jun 14, 2024 at 07:17:20PM +0200, Petr Mladek wrote:
> On Thu 2024-06-13 15:51:08, Tony Lindgren wrote:
> > The earlier attempt on doing this caused a regression with the kernel
> > command line console order as it added calling __add_preferred_console()
> > again later on during init. A better approach was suggested by Petr where
> > we add the deferred console to the console_cmdline[] and update it later
> > on when the console is ready.
> 
> The patch seems to work well. And I am surprised that it is so small ;-)

Your intuition at work :)

> > diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> > index 5ebacb982f9e..a34f55ef6f37 100644
> > --- a/drivers/tty/serial/serial_base_bus.c
> > +++ b/drivers/tty/serial/serial_base_bus.c
> > @@ -210,7 +210,13 @@ void serial_base_port_device_remove(struct serial_port_device *port_dev)
> >  static int serial_base_add_one_prefcon(const char *match, const char *dev_name,
> >  				       int port_id)
> 
> I would suggest to rename also functions on the serial_base side.
> The function is not adding prefcon. It is doing some match_and_update
> job.

OK good idea, I'll do a separate patch for that.

> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2486,8 +2495,8 @@ __setup("console_msg_format=", console_msg_format_setup);
> >   */
> >  static int __init console_setup(char *str)
> >  {
> > -	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
> > -	char *s, *options, *brl_options = NULL;
> 
> I would add
> 
> 	static_assert(sizeof(console_cmdline[0].devname) >= sizeof(console_cmdline[0].name));

That check should still be >= sizeof(console_cmdline[0].name) + 4, right?
For the "number only" consoles we add the "ttyS" prefix.

> The name "chardev" sounds as generic as "devname". I would use one of
> 
>    + "name" like the parameter in __add_preferred_console
>    + "ttyname" as it is mostly used for "tty*" console names
>    + "conname" like a name in struct console.
> 
> Also please split the variables per-line so that future diff's are
> easier to follow. Something like:
> 
> 	static_assert(sizeof(console_cmdline[0].devname) >= sizeof(console_cmdline[0].name));
> 	char buf[sizeof(console_cmdline[0].devname)];
> 	char *brl_options = NULL;
> 	char *ttyname = NULL;
> 	char *devname = NULL;
> 	char *options;
> 	char *s;
> 	int idx;

OK I'll use ttyname like you're suggesting.

> > @@ -2523,12 +2538,12 @@ static int __init console_setup(char *str)
> >  #endif
> >  
> >  	for (s = buf; *s; s++)
> > -		if (isdigit(*s) || *s == ',')
> > +		if ((chardev && isdigit(*s)) || *s == ',')
> >  			break;
> >  	idx = simple_strtoul(s, NULL, 10);
> 
> The @idx value is not really important when @devname is used.
> But it still would be more clear to set it to -1.

OK

> My proposal might be kind of naive. Some people might say that
> it describes obvious things. But the API is for device driver
> users which do not know much about how printk handles
> the console command line and the registration.
> 
> <proposal>
> /**
>  * match_devname_and_update_preferred_console - Update a preferred console
>  *	when matching devname is found.
>  * @devname: DEVNAME:0.0 style device name
>  * @name: Name of the corresponding console driver, e.g. "ttyS"
>  * @idx: Console index, e.g. port number.
>  *
>  * The function checks whether a device with the given @devname is
>  * preferred via the console=DEVNAME:0.0 command line option.
>  * It fills the missing console driver name and console index
>  * so that a later register_console() call could find (match)
>  * and enable this device.
>  *
>  * It might be used when a driver subsystem initializes particular
>  * devices with already known DEVNAME:0.0 style names. And it
>  * could predict which console driver name and index this device
>  * would later get associated with.
>  *
>  * Return: 0 on success, negative error code on failure.
>  */
> </proposal>

That looks good to me.

> At least, this is my understanding of how this works.
> 
> I do not know the whole history. And maybe I get something wrong.
> IMHO, the main problem is that the printk console code
> historically uses TTY device names. But we want to register/enable
> the consoles ASAP when the HW devices are ready for writing().
> It happens before the TTY subsystem gets initialized so
> that we could not use the sysfs kobjects for matching
> the tty device driver names with HW device driver names.
> And we need this kind of hacks.

Yes that's correct.

> > +int update_preferred_console(const char *devname, const char *name, const short idx)
> > +{
> > +	struct console_cmdline *c = console_cmdline;
> > +	int i;
> > +
> > +	if (!devname || !strlen(devname) || !name || !strlen(name) || idx < 0)
> > +		return -EINVAL;
> > +
> > +	for (i = 0; i < MAX_CMDLINECONSOLES && (c->name[0] || c->devname[0]);
> > +	     i++, c++) {
> > +		if (!strcmp(devname, c->devname)) {
> 
> I would add here:
> 
> 			pr_info("associate the preferred console \"%s\" with \"%s%d\"\n",
> 				devname, name, idx);
> 

OK

Regards,

Tony
