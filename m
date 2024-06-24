Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877CD381B1;
	Mon, 24 Jun 2024 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719213703; cv=none; b=mm+xgWhOF0t+gCxfOcsoXyIDyQiw+QiAqlWobF6DTk0ZtZbvMtMufnBQtMPpEIc1zCOeqb4rzwuSjJGLCKr0HnDSL3cIxKo9eGW+JUiWOdg24J8zP1806hbjCyG3M7aaWVhzBKEtjQOQH4+iyCoq7jXWM7CfRFIxfBeBSA3Po4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719213703; c=relaxed/simple;
	bh=pFg39WHvyuNoS/V8IG/f3JCgPbumbcLNExlI0I7fPtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MN/Nerbu0f7CyApT9h0vDpevTaYugYZRmlPtqUSwlOPLaw0wsw/pIE3raWXRN/jZcAtwVWFpC1/iQqdtSzPAynEOLv7AoVTJdQUkvoOh/at+bKb+5a94Ew9NmO2IGHCOs2hsR3AVGH8wmfWI7OaQbqjpZyZoImz8I1yXRhctWB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHG0UnOn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHG0UnOn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719213702; x=1750749702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pFg39WHvyuNoS/V8IG/f3JCgPbumbcLNExlI0I7fPtQ=;
  b=kHG0UnOny2/w7z9El+zuMVTXm3q53ToAA3iCSW4e2zFgwfdyCKwBi1s7
   RKghyo6qdLb7XqsagcoOD/D/MKRFULAACEo8LZjOXWHX6r7rGCt2JBXDb
   OE/Ds3GFaTRxSdezR6UKObhJ+unX5Vbodw0uulAOh8c23iNRSxEfqP6iv
   JWBnt8NcEIRkHrzJuyK6z+xN56YyEkmMj2pnniUlZ51cHSViv4hE4UCBd
   1x60i09Ed+Mpw7mis9Per7eeqr4JyBRvzcxWEQf7cYMYMBDFEZ4q0CLaZ
   4e0RiwVZTRhm36kqMF44YT4i4lXoeP/8jdZKAiNymEaJ3cm5MYPvuCC8W
   g==;
X-CSE-ConnectionGUID: Cg3Npu3FQ46HueVnMe+NOA==
X-CSE-MsgGUID: P+2VGZdgQCO+KNwOgrg25w==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="33712958"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="33712958"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 00:21:41 -0700
X-CSE-ConnectionGUID: F5nFQP3BSKiyvJ2t9Mej0Q==
X-CSE-MsgGUID: BNcv3AStT0+HHHrP41+jHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="48158488"
Received: from unknown (HELO tlindgre-MOBL1) ([10.245.247.58])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 00:21:36 -0700
Date: Mon, 24 Jun 2024 10:21:32 +0300
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
Subject: Re: [PATCH v4 4/4] serial: core: Add
 serial_base_match_and_update_preferred_console()
Message-ID: <ZnkefKEyjuPLkJF8@tlindgre-MOBL1>
References: <20240620124541.164931-1-tony.lindgren@linux.intel.com>
 <20240620124541.164931-5-tony.lindgren@linux.intel.com>
 <ZnV0B4wakVehASn4@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnV0B4wakVehASn4@pathway.suse.cz>

On Fri, Jun 21, 2024 at 02:37:27PM +0200, Petr Mladek wrote:
> On Thu 2024-06-20 15:45:29, Tony Lindgren wrote:
> > Let's add serial_base_match_and_update_preferred_console() for consoles
> > using DEVNAME:0.0 style naming.
> > 
> > The earlier approach to add it caused issues in the kernel command line
> > ordering as we were calling __add_preferred_console() again for the
> > deferred consoles.
> > 
> > Signed-off-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> 
> Looks good and seems to work well:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>

OK thanks for testing again.

> See an idea below.
>
> > --- a/drivers/tty/serial/serial_base_bus.c
> > +++ b/drivers/tty/serial/serial_base_bus.c
...
> > +int serial_base_match_and_update_preferred_console(struct uart_driver *drv,
> > +						   struct uart_port *port)
> > +{
> > +	const char *port_match __free(kfree) = NULL;
> > +	int ret;
> > +
> > +	port_match = kasprintf(GFP_KERNEL, "%s:%d.%d", dev_name(port->dev),
> > +			       port->ctrl_id, port->port_id);
> > +	if (!port_match)
> > +		return -ENOMEM;
> 
> The name is going to be compared with:
> 
> struct console_cmdline
> {
> [...]
> 	char	devname[32];			/* DEVNAME:0.0 style device name */
> 
> It looks like an overkill to allocate such a small buffer. It would
> be perfectly fine to use a buffer on stack.
> 
> Well, we would need to define somewhere (likely in include/linux/console.h):
> 
> #define CONSOLE_DEVNAME_LEN 32
> 
> and then do
> 
> 	char port_match[CONSOLE_DEVNAME_LEN];
> 	int len;
> 
> 	len = snprintf(port_match, ARRAY_SIZE(port_match), "%s:%d.%d",
> 		       dev_name(port->dev), port->ctrl_id, port->port_id);
> 	if (len >= ARRAY_SIZE(port_match)) {
> 		pr_warn("Console devname does not fit into the buffer: "%s:%d.%d\n",
> 			 dev_name(port->dev), port->ctrl_id, port->port_id);
> 		return -ENOMEM;
> 	}
> 
> The advantage is that it would warn when there are longer device names.
> It would help to catch situations when CONSOLE_DEVNAME_LEN is not big enough.

Good idea.

> It might be done in a separate patch.

Sounds good to me.

Regards,

Tony
