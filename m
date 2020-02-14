Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2239CC3B1BE
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 19:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFBF206CC
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 19:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgBNTC5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:02:57 -0500
Received: from muru.com ([72.249.23.125]:55354 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728859AbgBNTC5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 14:02:57 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B731D80E7;
        Fri, 14 Feb 2020 19:03:40 +0000 (UTC)
Date:   Fri, 14 Feb 2020 11:02:53 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v2 5/8] serial: 8250_port: Don't use power management for
 kernel console
Message-ID: <20200214190253.GS16391@atomide.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
 <20200214114339.53897-6-andriy.shevchenko@linux.intel.com>
 <20200214181407.GQ16391@atomide.com>
 <20200214185645.GQ10400@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214185645.GQ10400@smile.fi.intel.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [200214 18:57]:
> On Fri, Feb 14, 2020 at 10:14:07AM -0800, Tony Lindgren wrote:
> > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [200214 11:44]:
> > > --- a/drivers/tty/serial/8250/8250_core.c
> > > +++ b/drivers/tty/serial/8250/8250_core.c
> > > @@ -608,6 +608,14 @@ static int univ8250_console_setup(struct console *co, char *options)
> > >  	return retval;
> > >  }
> > >  
> > > +static int univ8250_console_exit(struct console *co)
> > > +{
> > > +	struct uart_port *port;
> > > +
> > > +	port = &serial8250_ports[co->index].port;
> > > +	return serial8250_console_exit(port);
> > > +}
> > > +
> > >  /**
> > >   *	univ8250_console_match - non-standard console matching
> > >   *	@co:	  registering console
> > > @@ -666,6 +674,7 @@ static struct console univ8250_console = {
> > >  	.write		= univ8250_console_write,
> > >  	.device		= uart_console_device,
> > >  	.setup		= univ8250_console_setup,
> > > +	.exit		= univ8250_console_exit,
> > >  	.match		= univ8250_console_match,
> > >  	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
> > >  	.index		= -1,
> > 
> > You're missing adding exit to struct console or these patches
> > are based on some tree I don't have. I had to add the following
> > change to compile for you to fold into this patch.
> 
> In cover letter the [1] link answers to this.
> Can you try again with that series being applied first?

Ah OK thanks will try with that applied.

Regards,

Tony
