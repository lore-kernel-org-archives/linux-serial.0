Return-Path: <SRS0=XS4C=B5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA95EC433DF
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 09:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99D5820639
	for <linux-serial@archiver.kernel.org>; Wed, 19 Aug 2020 09:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgHSJYL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:24:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:44082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgHSJYK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Aug 2020 05:24:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26D84ADC1;
        Wed, 19 Aug 2020 09:24:35 +0000 (UTC)
Date:   Wed, 19 Aug 2020 11:24:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <20200819092408.GB4353@alley>
References: <20200814013802.357412-1-sergey.senozhatsky@gmail.com>
 <20200814095928.GK1891694@smile.fi.intel.com>
 <20200818125218.GC17612@alley>
 <20200819015209.GA3302@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819015209.GA3302@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed 2020-08-19 10:52:09, Sergey Senozhatsky wrote:
> On (20/08/18 14:52), Petr Mladek wrote:
> > > I guess we may add some tags here
> > > 
> > > Fixes: 768aec0b5bcc ("serial: 8250: fix shared interrupts issues with SMP and RT kernels")
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Reported-by: Raul Rangel <rrangel@google.com>
> > > BugLink: https://bugs.chromium.org/p/chromium/issues/detail?id=1114800
> > > Link: https://lore.kernel.org/lkml/CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com/T/#u
> > 
> > "Link:" tag should point to the mail that is applied using git am.
> > I am not sure if there is a tag for related discussion in another
> > mail threads.
> 
> Yes, that's a good point. I wonder if we can slightly change that
> rule. That link points to a thread where we discussed various
> approaches to the problem, what would work, what wouldn't and why;
> there is some valuable feedback there. The "8250-fix-locks-v2.patch"
> link, on the other hand, points to nothing valuable.

I agree that the other link is more valuable than the final one.
I just did not want to break a common rule. But it seems that
there already are commits with more Link: tags.

> > Sounds reasonable to me.
> > 
> > Andy proposed many changes. Sergey, could you please send v2?
> 
> Sure, I think I sent v2 already.

Ah, I have missed it. It is pushed now.

Best Regards,
Petr
