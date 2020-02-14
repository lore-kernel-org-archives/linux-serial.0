Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9710C2BA83
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 18:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D16D206CC
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 18:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbgBNS4r (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:56:47 -0500
Received: from mga09.intel.com ([134.134.136.24]:48216 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387552AbgBNS4q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 13:56:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 10:56:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="223104443"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 14 Feb 2020 10:56:43 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j2g8r-001RPt-C1; Fri, 14 Feb 2020 20:56:45 +0200
Date:   Fri, 14 Feb 2020 20:56:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v2 5/8] serial: 8250_port: Don't use power management for
 kernel console
Message-ID: <20200214185645.GQ10400@smile.fi.intel.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
 <20200214114339.53897-6-andriy.shevchenko@linux.intel.com>
 <20200214181407.GQ16391@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214181407.GQ16391@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 14, 2020 at 10:14:07AM -0800, Tony Lindgren wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [200214 11:44]:
> > --- a/drivers/tty/serial/8250/8250_core.c
> > +++ b/drivers/tty/serial/8250/8250_core.c
> > @@ -608,6 +608,14 @@ static int univ8250_console_setup(struct console *co, char *options)
> >  	return retval;
> >  }
> >  
> > +static int univ8250_console_exit(struct console *co)
> > +{
> > +	struct uart_port *port;
> > +
> > +	port = &serial8250_ports[co->index].port;
> > +	return serial8250_console_exit(port);
> > +}
> > +
> >  /**
> >   *	univ8250_console_match - non-standard console matching
> >   *	@co:	  registering console
> > @@ -666,6 +674,7 @@ static struct console univ8250_console = {
> >  	.write		= univ8250_console_write,
> >  	.device		= uart_console_device,
> >  	.setup		= univ8250_console_setup,
> > +	.exit		= univ8250_console_exit,
> >  	.match		= univ8250_console_match,
> >  	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
> >  	.index		= -1,
> 
> You're missing adding exit to struct console or these patches
> are based on some tree I don't have. I had to add the following
> change to compile for you to fold into this patch.

In cover letter the [1] link answers to this.
Can you try again with that series being applied first?

> 
> Regards,
> 
> Tony
> 
> 8< -------------------
> diff --git a/include/linux/console.h b/include/linux/console.h
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -148,6 +148,7 @@ struct console {
>  	struct tty_driver *(*device)(struct console *, int *);
>  	void	(*unblank)(void);
>  	int	(*setup)(struct console *, char *);
> +	int	(*exit)(struct console *);
>  	int	(*match)(struct console *, char *name, int idx, char *options);
>  	short	flags;
>  	short	index;

-- 
With Best Regards,
Andy Shevchenko


