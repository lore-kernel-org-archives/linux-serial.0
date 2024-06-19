Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C32179AE;
	Wed, 19 Jun 2024 04:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718771958; cv=none; b=VkGh1npDt83cx/2QIROe3lsYs31iWVyczAxHFjM/y4GsqlyE3MJfPbfE7+7c+LAGnLwcWcBqz4ENe1CifidL0qotxfXStYwlk5BOaCHqDRvtD50ivENGN9sIPj1dep4PMbJaB3fTNYAZAonwVwWJB53yyq6ARPLjMYF8pjTl6dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718771958; c=relaxed/simple;
	bh=b6m98e4sk/WXMF9G7Y9dAqU8aFp5yb0EEKE+Qaz8hIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0v/sTTpsV01YdAj/pCLQ1BgGXaiG/Ii3uP3rLqJZepvUfid80+x20RftRJRRC+NOgheIL+jv9egZF9cmnckj7peuwCgcpM7E9Pr88GZKcADEPduTiiHpiI/pOP6jMBYrkg5RGUcUYHzGjsS6e2Wj4BM2qn5HPAlCxJCjX0/j5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qgupp7Nj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qgupp7Nj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718771958; x=1750307958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b6m98e4sk/WXMF9G7Y9dAqU8aFp5yb0EEKE+Qaz8hIs=;
  b=Qgupp7Nj/gzDTXJlrKjWGg23NhqwrUOmsPQ4diV6ZVadDqff+vL/6m0g
   +yCtQ39k5EdujjMFG1xpjhw3RGapbtITKdcY6VwOFoMRC8ZRNrFstYTRQ
   QQesJvII/EBagnHzkSK3l5UZLFL/vzUh/FPkT8uLJyh5fTlsiEESSULl8
   /Po2dpGOs/q2FuelmtqNU0lkM5hLIGGZ2boKbPUpbqYsU3fsvOtojCNMz
   AykD16ucCWe/OssWf05xFlBzOJ5e6mvNrizTzIbgORsjoqWEjTm7OcdS3
   cVMy6+MCkFvl8AZitSr9vVLW2JmSu1K2GQosaX3BasKtNhqmUguKSCQDy
   g==;
X-CSE-ConnectionGUID: pBOIqUioSYifaaNz20mazg==
X-CSE-MsgGUID: CHOIUmNgRuSQsijAmvfSuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="27106461"
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="27106461"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 21:39:17 -0700
X-CSE-ConnectionGUID: +LbDWLEoSzS5YheUqJXteg==
X-CSE-MsgGUID: KY5sjASnSIGN9kpDhrZDNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,249,1712646000"; 
   d="scan'208";a="72528622"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO tlindgre-MOBL1) ([10.245.247.16])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 21:39:12 -0700
Date: Wed, 19 Jun 2024 07:39:04 +0300
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
Subject: Re: [PATCH v3 3/3] serial: core: Rename preferred console handling
 for match and update
Message-ID: <ZnJg6KQeIs95UFAB@tlindgre-MOBL1>
References: <20240618045458.14731-1-tony.lindgren@linux.intel.com>
 <20240618045458.14731-4-tony.lindgren@linux.intel.com>
 <ZnGQ8JAu2OQf0GX8@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnGQ8JAu2OQf0GX8@pathway.suse.cz>

On Tue, Jun 18, 2024 at 03:51:44PM +0200, Petr Mladek wrote:
> On Tue 2024-06-18 07:54:50, Tony Lindgren wrote:
> > We are now matching and updating the preferred console, not adding it.
> > Let's update the naming accordingly to avoid confusion.
> > 
> > --- a/drivers/tty/serial/serial_base_bus.c
> > +++ b/drivers/tty/serial/serial_base_bus.c
> > @@ -304,7 +305,7 @@ int serial_base_add_preferred_console(struct uart_driver *drv,
> 
> I was curious whether this patch renamed everything. And it seems
> that it did not rename serial_base_add_preferred_console().

Oops, will update the naming for that too.

> >  	const char *port_match __free(kfree) = NULL;
> >  	int ret;
> >  
> > -	ret = serial_base_add_prefcon(drv->dev_name, port->line);
> > +	ret = serial_base_match_and_update_prefcon(drv->dev_name, port->line);
> >  	if (ret)
> >  		return ret;
> >  
> 
> Honestly, I do not understand what are all these layers for.
> Especially, serial_base_match_and_update_prefcon() looks suspicious:
> 
> static int serial_base_match_and_update_prefcon(const char *name, int idx)
> {
> 	const char *char_match __free(kfree) = NULL;
> 	const char *nmbr_match __free(kfree) = NULL;
> 	int ret;
> 
> 	/* Handle ttyS specific options */
> 	if (strstarts(name, "ttyS")) {
> 		/* No name, just a number */
> 		nmbr_match = kasprintf(GFP_KERNEL, "%i", idx);
> 		if (!nmbr_match)
> 			return -ENODEV;
> 
> 		ret = serial_base_match_and_update_one_prefcon(nmbr_match, name, idx);
> 		if (ret)
> 			return ret;
> 
> 		/* Sparc ttya and ttyb */
> 		ret = serial_base_add_sparc_console(name, idx);
> 		if (ret)
> 			return ret;
> 	}
> 
> 	/* Handle the traditional character device name style console=ttyS0 */
> 	char_match = kasprintf(GFP_KERNEL, "%s%i", name, idx);
> 	if (!char_match)
> 		return -ENOMEM;
> 
> 	return serial_base_match_and_update_one_prefcon(char_match, name, idx);
> }
> 
> It seems to try whether c->devname matches a number "X", or "ttySX".
> It even tries the sparc-specific transformations in
> serial_base_add_sparc_console()
> 
> But this is the original format which does _not_ include ":".
> It never will be stored in c->devname and will never match.

Good catch, this won't do anything now with console_setup()
checking for ":" for deferred consoles. So we should revert commit
a0f32e2dd998 ("serial: core: Handle serial console options").

> I think that it has been the case even before this patchset.

For the earlier case, I tested things with serial handling removed
from console_setup() to let the serial layer handle the quirks.

With the new handling, we could just eventually defer the serial
consoles in console_setup(), and let the serial core do the quirk
handling. No immediate need for that though, that would be just
longer term clean-up.

> I think that we should remove these layers and check just
> the "DEVNAME:X.Y" format, aka "%s:%d.%d" [*].

Yes let's revert the quirk handling.
 
> [*] It would be nice to use the same printf format "%s:%d.%d"
>     in both serial_base_device_init() and also in the functions
>     matching the devname to make it clear that these are
>     the same names. Heh, I just guess that these are the same
>     names.

I'll do a separate clean-up patch for that, and that can then
be used for the match() too eventually.

Regards,

Tony
