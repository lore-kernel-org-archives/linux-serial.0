Return-Path: <SRS0=r/Py=AR=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880E0C433E0
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jul 2020 20:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1E4206B6
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jul 2020 20:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgGFUFW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:05:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:63686 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgGFUFV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jul 2020 16:05:21 -0400
IronPort-SDR: QtFrwyy4JC7OnfzO25SN9md7yTnSRiPXz1aXIqocC/l8tnL3Vltuf/Fepeg7ABFXAZ8mFYa9M6
 RNNgYCaDZivA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="212473290"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="212473290"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 13:05:21 -0700
IronPort-SDR: u6xPTF2cYsvsne3M9Z2lu3jWzip6Iq33Z+QxnGAoySPiHB63Ry9Zg36OlzDUZy+yo9Wvp4d7cG
 qwZEUS2eEoiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="388289246"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jul 2020 13:05:19 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jsXMd-000MiO-O3; Mon, 06 Jul 2020 23:05:19 +0300
Date:   Mon, 6 Jul 2020 23:05:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Anatoly Pugachev <matorola@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] serial: core: Initialise spin lock before use in
 uart_configure_port()
Message-ID: <20200706200519.GZ3703480@smile.fi.intel.com>
References: <20200706143548.63985-1-andriy.shevchenko@linux.intel.com>
 <bfa0f8b35fe5b1864338376fa34b0db1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfa0f8b35fe5b1864338376fa34b0db1@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jul 06, 2020 at 05:36:56PM +0100, Marc Zyngier wrote:
> On 2020-07-06 15:35, Andy Shevchenko wrote:
> > The comment near to uart_port_spin_lock_init() says:
> > 
> >   Ensure that the serial console lock is initialised early.
> >   If this port is a console, then the spinlock is already initialised.
> > 
> > and there is nothing about enabled or disabled consoles. The commit
> > a3cb39d258ef ("serial: core: Allow detach and attach serial device
> > for console") made a change, which follows the comment, and also to
> > prevent reinitialisation of the lock in use, when user detaches and
> > attaches back the same console device. But this change discovers
> > another issue, that uart_add_one_port() tries to access a spin lock
> > that now may be uninitialised. This happens when a driver expects
> > the serial core to register a console on its behalf. In this case
> > we must initialise a spin lock before use.

...

> > +static inline void uart_any_port_spin_lock_init(struct uart_port *port)
> 
> nit: __uart_port_spin_lock_init() looks like a better name to me
> (as a primitive of uart_port_spin_lock_init). You can also drop
> the inline which doesn't mean much these days (and this isn't
> a hot path).

Actually I was thinking about that name, but decided to go without underscores
(b/c some developers like this approach, some like that one). I'm fine with
your proposal nevertheless.

> > +		/*
> > +		 * If this driver supports console, and it hasn't been
> > +		 * successfully registered yet, initialise spin lock for it.
> > +		 */
> > +		if (port->cons && !(port->cons->flags & CON_ENABLED))
> > +			uart_any_port_spin_lock_init(port);
> > +
> >  		/*
> >  		 * Ensure that the modem control lines are de-activated.
> >  		 * keep the DTR setting that is set in uart_set_options()
> 
> Otherwise looks OK to me (having tested an earlier version).
> With the above addressed:
> 
> Acked-by: Marc Zyngier <maz@kernel.org>

Thanks!

-- 
With Best Regards,
Andy Shevchenko


