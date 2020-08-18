Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2AFC433E1
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 12:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C2820706
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 12:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgHRMwd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:52:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:51638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbgHRMwV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 08:52:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E3F9BAE25;
        Tue, 18 Aug 2020 12:52:44 +0000 (UTC)
Date:   Tue, 18 Aug 2020 14:52:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tony Lindgren <tony@atomide.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Raul Rangel <rrangel@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] uart:8250: change lock order in serial8250_do_startup()
Message-ID: <20200818125218.GC17612@alley>
References: <20200814013802.357412-1-sergey.senozhatsky@gmail.com>
 <20200814095928.GK1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814095928.GK1891694@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri 2020-08-14 12:59:28, Andy Shevchenko wrote:
> On Fri, Aug 14, 2020 at 10:38:02AM +0900, Sergey Senozhatsky wrote:
> > We have a number of "uart.port->desc.lock vs desc.lock->uart.port"
> > lockdep reports coming from 8250 driver; this causes a bit of trouble
> > to people, so let's fix it.
> > 
> 
> I guess we may add some tags here
> 
> Fixes: 768aec0b5bcc ("serial: 8250: fix shared interrupts issues with SMP and RT kernels")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Raul Rangel <rrangel@google.com>
> BugLink: https://bugs.chromium.org/p/chromium/issues/detail?id=1114800
> Link: https://lore.kernel.org/lkml/CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com/T/#u

"Link:" tag should point to the mail that is applied using git am.
I am not sure if there is a tag for related discussion in another
mail threads.

A solution might be to add a comment like:

This solution has been discussed in several threads:
https://lore.kernel.org/lkml/CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com/T/#u
https://lore.kernel.org/lkml/20200812154813.GA46894@roeck-us.net/#t


> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -2275,6 +2275,11 @@ int serial8250_do_startup(struct uart_port *port)
> >  
> >  	if (port->irq && !(up->port.flags & UPF_NO_THRE_TEST)) {
> >  		unsigned char iir1;
> 
> > +		bool irq_shared = up->port.irqflags & IRQF_SHARED;
> 
> I'm wondering why we need a temporary variable? This flag is not supposed to be
> changed in between, can we leave original conditionals?
> 
> Nevertheless I noticed an inconsistency of the dereference of the flags which
> seems to be brough by dfe42443ea1d ("serial: reduce number of indirections in
> 8250 code").
> 
> I think we can stick with newer:
> 
> 		if (port->irqflags & IRQF_SHARED)

Sounds reasonable to me.

Andy proposed many changes. Sergey, could you please send v2?

Best Regards,
Petr
